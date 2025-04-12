#!/usr/bin/env python3

import subprocess
import os
import sys
import time
import shlex

# Define the Music directory path
lib_path = '~/Music'
again_msg = 'yes'

# Function to run a command and return its output with error handling
def run_command(command):
    try:
        result = subprocess.run(command, shell=True, capture_output=True, text=True, timeout=30)
        return result.stdout.strip(), result.stderr.strip(), result.returncode
    except subprocess.TimeoutExpired:
        return "", "Command timed out", 1

# Function to display error message using rofi
def show_error(message):
    run_command(f'echo "{message}" | rofi -dmenu -p "Error"')
    
# Function to send desktop notification
def send_notification(title, message, icon="audio-x-generic"):
    # Escape special characters to prevent shell injection
    safe_title = shlex.quote(title)
    safe_message = shlex.quote(message)
    
    # Send notification
    run_command(f'notify-send -i {icon} {safe_title} {safe_message}')

while (again_msg == 'yes'):
    # Step 1: Take search query input from the user
    search_query_stdout, _, _ = run_command('echo "" | rofi -dmenu -p "Enter YouTube Search Query"')
    search_query = search_query_stdout.strip()
    
    if not search_query:
        again_msg = "no"
        continue
        
    try:
        # Step 2: Search for videos using yt-dlp with network error handling
        search_command = f'yt-dlp --flat-playlist --get-title --get-id "ytsearch15:{search_query}"'
        search_output, search_error, return_code = run_command(search_command)
        
        # Check for network or other errors
        if return_code != 0 or not search_output:
            error_msg = "Network error or no results found. Please check your internet connection."
            if search_error:
                error_msg = f"Error: {search_error}"
            show_error(error_msg)
            again_msg = run_command('echo "Yes\nNo" | rofi -dmenu -i -p "Network Error. Retry?"')[0].lower()
            continue
            
        # Step 3: Parse the search results
        search_lines = search_output.split('\n')
        
        # Check if we have valid results
        if len(search_lines) < 2:
            show_error("No valid search results found.")
            again_msg = run_command('echo "Yes\nNo" | rofi -dmenu -i -p "No results found. Retry?"')[0].lower()
            continue
            
        video_entries = list(zip(search_lines[::2], search_lines[1::2]))  # Pair titles and IDs

        # Step 4: Format entries for rofi
        rofi_entries = "\n".join([f"{title} ({video_id})" for title, video_id in video_entries])

        # Step 5: Display the results in rofi and get the selected entry
        selected_entry, _, _ = run_command(f'echo "{rofi_entries}" | rofi -dmenu -i -p "Select Video"')

        # Step 6: Check if an entry was selected
        if selected_entry:
            # Extract video ID from the selected entry
            selected_video_id = selected_entry.split('(')[-1].strip(')')

            # Define the Music directory path
            music_directory = os.path.expanduser(lib_path)
            
            # Ensure music directory exists
            os.makedirs(music_directory, exist_ok=True)

            # Step 7: Download the selected video as MP3 and save it to ~/Music
            print(f"Downloading: {selected_entry}")
            download_command = (
                f'yt-dlp -x --audio-format mp3 -o "{music_directory}/%(title)s.%(ext)s" '
                f'"https://www.youtube.com/watch?v={selected_video_id}"'
            )
            
            # Run download with error handling
            _, download_error, download_code = run_command(download_command)
            
            if download_code != 0:
                error_message = "Download failed. Please check your internet connection."
                if download_error:
                    error_message = f"Download error: {download_error[:100]}..."
                show_error(error_message)
                # Also send notification for the error
                send_notification("Download Failed", error_message, icon="dialog-error")
                again_msg = run_command('echo "Yes\nNo" | rofi -dmenu -i -p "Download Failed. Retry?"')[0].lower()
            else:
                # Extract title for notification
                video_title = selected_entry.split(" (")[0] if " (" in selected_entry else selected_entry
                
                # Send notification for successful download
                success_message = f"Downloaded to {lib_path}"
                send_notification("Download Complete", f"{video_title}\n{success_message}", icon="audio-x-generic")
                
                # Continue with rofi dialog
                download_message = f"Downloaded to {lib_path}."
                again_msg_stdout, _, _ = run_command(f'echo "Yes\nNo" | rofi -dmenu -i -p "{download_message} Download another one (Y/n)"')
                again_msg = again_msg_stdout.lower()
        else:
            # No video selected
            again_msg_stdout, _, _ = run_command('echo "Yes\nNo" | rofi -dmenu -i -p "No video selected. Try again?"')
            again_msg = again_msg_stdout.lower()
            
    except Exception as e:
        # Handle any unexpected errors
        show_error(f"Unexpected error: {str(e)}")
        again_msg_stdout, _, _ = run_command('echo "Yes\nNo" | rofi -dmenu -i -p "An error occurred. Retry?"')
        again_msg = again_msg_stdout.lower()

