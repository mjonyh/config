#!/bin/bash

# yt-audio-downloader.sh
# A shell script to search YouTube, select videos, and download their audio in high quality.

# --- Configuration ---
MAX_SEARCH_RESULTS=10  # Maximum number of search results to display
OUTPUT_DIRECTORY="/Users/mjonyh/youtube_audio" # Directory where audio files will be saved
AUDIO_FORMAT="best"     # Desired audio format (e.g., mp3, opus, flac, best)
AUDIO_QUALITY="0"      # Audio quality (0 for best VBR MP3, 'best' for other formats)

# --- Colors ---
C_RESET='\033[0m'
C_RED='\033[0;31m'
C_GREEN='\033[0;32m'
C_YELLOW='\033[0;33m'
C_BLUE='\033[0;34m'
C_CYAN='\033[0;36m'
C_WHITE='\033[0;37m'

# --- Helper Functions ---

# Function to check for required dependencies
check_dependencies() {
    echo -e "${C_BLUE}Checking for required dependencies...${C_RESET}"
    command -v yt-dlp >/dev/null 2>&1 || {
        echo -e >&2 "${C_RED}Error: yt-dlp is not installed.${C_RESET}"
        echo -e >&2 "Please install it: pip install yt-dlp (or refer to yt-dlp documentation)."
        exit 1
    }
    command -v jq >/dev/null 2>&1 || {
        echo -e >&2 "${C_RED}Error: jq is not installed.${C_RESET}"
        echo -e >&2 "Please install it: sudo apt-get install jq (Debian/Ubuntu), brew install jq (macOS), or refer to jq documentation."
        exit 1
    }
    command -v ffmpeg >/dev/null 2>&1 || {
        echo -e >&2 "${C_YELLOW}Warning: ffmpeg is not installed. Audio conversion will not be available.${C_RESET}"
        echo -e >&2 "Please install it to enable audio conversion."
    }
    YTDLP_VERSION=$(yt-dlp --version)
    CURRENT_YEAR=$(date +%Y)
    YTDLP_YEAR=$(echo $YTDLP_VERSION | cut -d '.' -f 1)
    if [ "$YTDLP_YEAR" -lt "$CURRENT_YEAR" ]; then
        echo -e "${C_YELLOW}Warning: Your yt-dlp version is from $YTDLP_YEAR. It is recommended to update to the latest version.${C_RESET}"
        echo -e "You can update by running: ${C_GREEN}pip install --upgrade yt-dlp${C_RESET}"
    fi
    echo -e "${C_GREEN}Dependencies (yt-dlp, jq) found.${C_RESET}"
}

# Function to display help message
display_help() {
    echo -e "${C_CYAN}--- Help ---${C_RESET}"
    echo -e "This script allows you to search YouTube and download audio."
    echo ""
    echo -e "1. Enter a search term when prompted."
    echo -e "2. A list of results will be displayed."
    echo -e "3. To select videos for download, you can:"
    echo -e "   - Enter space-separated numbers (e.g., '1 3 5')"
    echo -e "   - Enter a range (e.g., '1-3')"
    echo -e "   - Enter 'a' to download all listed videos."
    echo -e "   - Enter 's' to perform a new search."
    echo -e "   - Enter 'f' to change the audio format (current: ${C_YELLOW}$AUDIO_FORMAT${C_CYAN})."
    echo -e "   - Enter 'u' to update yt-dlp."
    echo -e "   - Enter 'q' to quit the script."
    echo ""
    echo -e "Audio will be saved to the '${C_YELLOW}$OUTPUT_DIRECTORY${C_CYAN}' directory as '${C_YELLOW}$AUDIO_FORMAT${C_CYAN}' files."
    echo -e "--------------${C_RESET}"
}

# Function to download audio from a given URL
download_audio() {
    url=$1
    echo -e "${C_BLUE}--- Downloading: $url ---${C_RESET}"
    if [[ "$AUDIO_FORMAT" == "best" ]]; then
        # Download the best audio without re-encoding
        if ! yt-dlp -f bestaudio -o "$OUTPUT_DIRECTORY/%(title)s.%(ext)s" "$url"; then
            echo -e "${C_RED}Error: Failed to download audio from $url${C_RESET}"
            echo -e "Please check the URL and your network connection."
            echo -e "You can also try to update yt-dlp by running: ${C_GREEN}pip install --upgrade yt-dlp${C_RESET}"
        fi
    else
        # Download and convert to the specified format
        if ! yt-dlp -x --audio-format "$AUDIO_FORMAT" --audio-quality "$AUDIO_QUALITY" \
                    --restrict-filenames \
                    -o "$OUTPUT_DIRECTORY/%(title)s.%(ext)s" "$url"; then
            echo -e "${C_RED}Error: Failed to download audio from $url${C_RESET}"
            echo -e "Please check the URL and your network connection."
            echo -e "You can also try to update yt-dlp by running: ${C_GREEN}pip install --upgrade yt-dlp${C_RESET}"
        fi
    fi
    echo -e "${C_GREEN}--- Download finished for $url ---${C_RESET}"
}

# --- Main Script Logic ---

# 1. Dependency Check
check_dependencies

# 2. Initialization
mkdir -p "$OUTPUT_DIRECTORY" || {
    echo >&2 "Error: Could not create output directory '$OUTPUT_DIRECTORY'."
    exit 1
}
echo "Audio files will be saved to: $OUTPUT_DIRECTORY"

# 3. Main Loop (Search and Download Cycle)
while true; do
    echo ""
    read -p "$(echo -e "${C_YELLOW}Enter search query (or 'q' to quit, 'h' for help, 'f' for format, 'u' to update): ${C_RESET}")" SEARCH_QUERY
    SEARCH_QUERY=$(echo "$SEARCH_QUERY" | xargs) # Trim whitespace

    if [[ "$SEARCH_QUERY" == "q" ]]; then
        echo -e "${C_GREEN}Exiting. Goodbye!${C_RESET}"
        exit 0
    elif [[ "$SEARCH_QUERY" == "h" ]]; then
        display_help
        continue
    elif [[ -z "$SEARCH_QUERY" ]]; then
        echo -e "${C_RED}Search query cannot be empty. Please try again.${C_RESET}"
        continue
    elif [[ "$SEARCH_QUERY" == "f" ]]; then
        echo -e "${C_BLUE}Select audio format (mp3, flac, opus, best):${C_RESET}"
        read -p "$(echo -e "${C_YELLOW}Enter format: ${C_RESET}")" NEW_AUDIO_FORMAT
        NEW_AUDIO_FORMAT=$(echo "$NEW_AUDIO_FORMAT" | tr '[:upper:]' '[:lower:]' | xargs)
        if [[ "$NEW_AUDIO_FORMAT" == "mp3" || "$NEW_AUDIO_FORMAT" == "flac" || "$NEW_AUDIO_FORMAT" == "opus" || "$NEW_AUDIO_FORMAT" == "best" ]]; then
            AUDIO_FORMAT="$NEW_AUDIO_FORMAT"
            echo -e "${C_GREEN}Audio format set to: $AUDIO_FORMAT${C_RESET}"
        else
            echo -e "${C_RED}Invalid audio format. Please choose from mp3, flac, opus, or best.${C_RESET}"
        fi
        continue
    elif [[ "$SEARCH_QUERY" == "u" ]]; then
        echo -e "${C_BLUE}Updating yt-dlp...${C_RESET}"
        pip install --upgrade yt-dlp
        continue
    fi
    # yt-dlp outputs one JSON object per line for --flat-playlist and --print-json
    # We redirect stderr to /dev/null to suppress yt-dlp's informational messages during search.
    echo -e "${C_BLUE}Searching for \"$SEARCH_QUERY\" (displaying up to $MAX_SEARCH_RESULTS results)...${C_RESET}"
    SEARCH_RESULTS_JSON=$(yt-dlp --print-json --flat-playlist "ytsearch${MAX_SEARCH_RESULTS}:${SEARCH_QUERY}" 2>/dev/null)

    if [[ -z "$SEARCH_RESULTS_JSON" ]]; then
        echo -e "${C_YELLOW}No results found for \"$SEARCH_QUERY\". Please try a different query.${C_RESET}"
        continue
    fi

    # 5. Parse and Display Search Results
    # Using a while-read loop for portability
    VIDEO_TITLES=()
    while IFS= read -r line; do
        VIDEO_TITLES+=("$line")
    done < <(printf "%s\n" "$SEARCH_RESULTS_JSON" | jq -r '.title // "Unknown Title"')

    VIDEO_UPLOADERS=()
    while IFS= read -r line; do
        VIDEO_UPLOADERS+=("$line")
    done < <(printf "%s\n" "$SEARCH_RESULTS_JSON" | jq -r '.uploader // "Unknown Uploader"')

    VIDEO_URLS=()
    while IFS= read -r line; do
        VIDEO_URLS+=("$line")
    done < <(printf "%s\n" "$SEARCH_RESULTS_JSON" | jq -r '.webpage_url // .url // "Invalid URL"')

    if [[ "${#VIDEO_TITLES[@]}" -eq 0 ]]; then
        echo -e "${C_RED}No parseable results found. This might indicate an issue with yt-dlp or jq output.${C_RESET}"
        continue
    fi

    echo ""
    echo -e "${C_BLUE}--- Search Results for \"$SEARCH_QUERY\" ---${C_RESET}"
    for i in "${!VIDEO_TITLES[@]}"; do
        echo -e "${C_WHITE}$((i+1)). ${VIDEO_TITLES[$i]} (by ${VIDEO_UPLOADERS[$i]})${C_RESET}"
    done
    echo -e "${C_BLUE}------------------------------------------${C_RESET}"

    # 6. User Selection
    TO_DOWNLOAD_URLS=() # Reset for each new search

    while true; do
        echo ""
        read -p "$(echo -e "${C_YELLOW}Enter numbers to download (e.g., '1 3 5', '1-3', 'a' for all, 's' to search again, 'q' to quit): ${C_RESET}")" SELECTION_INPUT
        SELECTION_INPUT=$(echo "$SELECTION_INPUT" | tr '[:upper:]' '[:lower:]' | xargs) # Convert to lowercase and trim

        if [[ "$SELECTION_INPUT" == "q" ]]; then
            echo -e "${C_GREEN}Exiting. Goodbye!${C_RESET}"
            exit 0
        elif [[ "$SELECTION_INPUT" == "s" ]]; then
            break # Break inner loop, continue main loop for new search
        elif [[ "$SELECTION_INPUT" == "a" ]]; then
            TO_DOWNLOAD_URLS=("${VIDEO_URLS[@]}")
            break # All selected, proceed to download
        elif [[ -z "$SELECTION_INPUT" ]]; then
            echo -e "${C_RED}No selection made. Please try again.${C_RESET}"
            continue
        else
            # Handle numeric selections and ranges
            IFS=' ' read -r -a SELECTIONS_ARRAY <<< "$SELECTION_INPUT"
            VALID_SELECTION_MADE=false
            TEMP_DOWNLOAD_URLS=() # Use a temporary array to build selections and handle duplicates

            for item in "${SELECTIONS_ARRAY[@]}"; do
                if [[ "$item" =~ ^[0-9]+$ ]]; then # Single number
                    index=$((item - 1))
                    if [[ "$index" -ge 0 && "$index" -lt "${#VIDEO_URLS[@]}" ]]; then
                        TEMP_DOWNLOAD_URLS+=("${VIDEO_URLS[$index]}")
                        VALID_SELECTION_MADE=true
                    else
                        echo -e "${C_YELLOW}Warning: Invalid selection number '$item'. Skipping.${C_RESET}"
                    fi
                elif [[ "$item" =~ ^([0-9]+)-([0-9]+)$ ]]; then # Range
                    start_index=$((BASH_REMATCH[1] - 1))
                    end_index=$((BASH_REMATCH[2] - 1))

                    if [[ "$start_index" -ge 0 && "$end_index" -lt "${#VIDEO_URLS[@]}" && "$start_index" -le "$end_index" ]]; then
                        for ((j=start_index; j<=end_index; j++)); do
                            TEMP_DOWNLOAD_URLS+=("${VIDEO_URLS[$j]}")
                            VALID_SELECTION_MADE=true
                        done
                    else
                        echo -e "${C_YELLOW}Warning: Invalid range '$item'. Skipping.${C_RESET}"
                    fi
                else
                    echo -e "${C_YELLOW}Warning: Invalid input format '$item'. Please use numbers, ranges (e.g., '1-3'), 'a', 's', or 'q'.${C_RESET}"
                fi
            done

            if [[ "$VALID_SELECTION_MADE" == "true" ]]; then
                # Remove duplicates from TEMP_DOWNLOAD_URLS
                DEDUPED_DOWNLOAD_URLS=()
                for url in "${TEMP_DOWNLOAD_URLS[@]}"; do
                    if ! echo "${DEDUPED_DOWNLOAD_URLS[@]}" | grep -q -F "$url"; then
                        DEDUPED_DOWNLOAD_URLS+=("$url")
                    fi
                done
                TO_DOWNLOAD_URLS=("${DEDUPED_DOWNLOAD_URLS[@]}")
                break # Valid selections made, proceed to download
            else
                echo -e "${C_RED}No valid selections were made. Please try again.${C_RESET}"
            fi
        fi
    done

    # If the user chose 's' (search again), TO_DOWNLOAD_URLS will be empty.
    # The 'break' from the inner loop will lead here.
    # We need to check if we should continue to the next search or proceed with download.
    if [[ "$SELECTION_INPUT" == "s" ]]; then
        continue # Skip download and go to next main loop iteration (new search)
    fi

    if [[ "${#TO_DOWNLOAD_URLS[@]}" -eq 0 ]]; then
        echo -e "${C_YELLOW}No videos selected for download. Returning to search.${C_RESET}"
        continue # Go to next main loop iteration (new search)
    fi

    # 7. Download Selected Audio
    echo ""
    echo -e "${C_BLUE}Starting download of ${#TO_DOWNLOAD_URLS[@]} audio file(s) to '$OUTPUT_DIRECTORY'...${C_RESET}"
    for url in "${TO_DOWNLOAD_URLS[@]}"; do
        download_audio "$url"
    done
    echo -e "${C_GREEN}All selected downloads complete for this batch.${C_RESET}"
    echo ""

done