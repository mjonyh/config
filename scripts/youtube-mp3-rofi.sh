#!/bin/bash
#
# YouTube to MP3 Downloader with Rofi Interface
# Dependencies: rofi, yt-dlp, notify-send

# Define Music directory path
LIB_PATH="$HOME/Music"

# Function to display error message
show_error() {
    message="$1"
    # Show error in both rofi dialog and as notification
    echo "$message" | rofi -dmenu -p "Error" > /dev/null
    send_notification "Error" "$message" "dialog-error"
}

# Function to send desktop notification
send_notification() {
    title="$1"
    message="$2"
    icon="${3:-audio-x-generic}"
    
    notify-send -i "$icon" "$title" "$message"
}

# Main loop
AGAIN_MSG="yes"
while [ "$AGAIN_MSG" = "yes" ]; do
    # Step 1: Take search query input from the user
    SEARCH_QUERY=$(echo "" | rofi -dmenu -p "Enter YouTube Search Query")
    
    # Exit if no query provided
    if [ -z "$SEARCH_QUERY" ]; then
        AGAIN_MSG="no"
        continue
    fi
    
    # Step 2: Search for videos using yt-dlp with network error handling
    echo "Searching for: $SEARCH_QUERY"
    # Notify that search has started
    send_notification "YouTube Search" "Searching for: $SEARCH_QUERY" "system-search"
    SEARCH_RESULTS=$(timeout 30 yt-dlp --flat-playlist --get-title --get-id "ytsearch15:$SEARCH_QUERY" 2>/tmp/yt_error.log)
    
    if [ $? -ne 0 ] || [ -z "$SEARCH_RESULTS" ]; then
        ERROR_MSG="Network error or no results found. Please check your internet connection."
        if [ -s /tmp/yt_error.log ]; then
            ERROR_MSG="Error: $(cat /tmp/yt_error.log | head -1)"
        fi
        show_error "$ERROR_MSG"
        # Note: No need to call send_notification here since show_error now does it
        AGAIN_MSG=$(echo -e "Yes\nNo" | rofi -dmenu -i -p "Network Error. Retry?" | tr '[:upper:]' '[:lower:]')
        continue
    fi
    
    # Step 3: Parse search results
    # Create a list of titles with their IDs for rofi
    ROFI_ENTRIES=""
    TITLES=()
    IDS=()
    
    # Parse titles and IDs from alternate lines in the output
    while read -r line; do
        TITLES+=("$line")
        read -r id
        IDS+=("$id")
        ROFI_ENTRIES="${ROFI_ENTRIES}${line} (${id})\n"
    done < <(echo "$SEARCH_RESULTS")
    
    # Check if we have valid results
    if [ ${#TITLES[@]} -eq 0 ]; then
        show_error "No valid search results found."
        # Note: No need to call send_notification here since show_error now does it
        AGAIN_MSG=$(echo -e "Yes\nNo" | rofi -dmenu -i -p "No results found. Retry?" | tr '[:upper:]' '[:lower:]')
        continue
    fi
    
    # Step 4: Display results in rofi and get selection
    SELECTED_ENTRY=$(echo -e "${ROFI_ENTRIES}" | rofi -dmenu -i -p "Select Video")
    
    # Step 5: Check if an entry was selected
    if [ -n "$SELECTED_ENTRY" ]; then
        # Extract video ID from the selected entry
        SELECTED_VIDEO_ID=$(echo "$SELECTED_ENTRY" | sed 's/.*(\(.*\))/\1/')
        
        # Create music directory if it doesn't exist
        MUSIC_DIR="${LIB_PATH/#\~/$HOME}"
        mkdir -p "$MUSIC_DIR"
        
        # Extract title for notification
        VIDEO_TITLE=$(echo "$SELECTED_ENTRY" | sed 's/ (.*)$//')
        
        # Download the selected video as MP3
        echo "Downloading: $SELECTED_ENTRY"
        send_notification "Download Started" "Downloading: $VIDEO_TITLE" "document-save"
        if timeout 300 yt-dlp -x --audio-format mp3 -o "$MUSIC_DIR/%(title)s.%(ext)s" \
            "https://www.youtube.com/watch?v=$SELECTED_VIDEO_ID" > /tmp/yt_download.log 2>&1; then
            
            # Send notification for successful download
            SUCCESS_MESSAGE="Downloaded to $LIB_PATH"
            send_notification "Download Complete" "$VIDEO_TITLE\n$SUCCESS_MESSAGE" "audio-x-generic"
            
            # Continue with rofi dialog
            DOWNLOAD_MESSAGE="Downloaded to $LIB_PATH."
            AGAIN_MSG=$(echo -e "Yes\nNo" | rofi -dmenu -i -p "$DOWNLOAD_MESSAGE Download another one (Y/n)" | tr '[:upper:]' '[:lower:]')
        else
            # Get error message
            ERROR_MESSAGE="Download failed. Please check your internet connection."
            if [ -s /tmp/yt_download.log ]; then
                ERROR_MESSAGE="Download error: $(head -1 /tmp/yt_download.log)"
            fi
            
            show_error "$ERROR_MESSAGE"
            # Note: No need to call send_notification here since show_error now does it
            AGAIN_MSG=$(echo -e "Yes\nNo" | rofi -dmenu -i -p "Download Failed. Retry?" | tr '[:upper:]' '[:lower:]')
        fi
    else
        # No video selected
        send_notification "No Selection" "No video was selected" "dialog-information"
        AGAIN_MSG=$(echo -e "Yes\nNo" | rofi -dmenu -i -p "No video selected. Try again?" | tr '[:upper:]' '[:lower:]')
    fi
done

# Clean up temporary files
rm -f /tmp/yt_error.log /tmp/yt_download.log

# Send exit notification
send_notification "YouTube Downloader" "Program completed" "application-exit"

exit 0