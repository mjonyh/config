#!/usr/bin/env python3

import subprocess
import os

# Define the Music directory path
lib_path = '~/Music'
again_msg = 'yes'

while (again_msg == 'yes'):
    # Function to run a command and return its output
    def run_command(command):
        result = subprocess.run(command, shell=True, capture_output=True, text=True)
        return result.stdout.strip()

    # Step 1: Take search query input from the user
    # search_query = input("Enter the YouTube video search query: ").strip()
    search_query = run_command('echo "" | rofi -dmenu -p "Enter YouTube Search Query"')

    # Step 2: Search for videos using yt-dlp
    search_command = f'yt-dlp --flat-playlist --get-title --get-id "ytsearch15:{search_query}"'
    search_output = run_command(search_command)

    # Step 3: Parse the search results
    search_lines = search_output.split('\n')
    video_entries = list(zip(search_lines[::2], search_lines[1::2]))  # Pair titles and IDs

    # Step 4: Format entries for rofi
    rofi_entries = "\n".join([f"{title} ({video_id})" for title, video_id in video_entries])

    # Step 5: Display the results in rofi and get the selected entry
    selected_entry = run_command(f'echo "{rofi_entries}" | rofi -dmenu -i -p "Select Video"')

    # Step 6: Check if an entry was selected
    if selected_entry:
        # Extract video ID from the selected entry
        selected_video_id = selected_entry.split('(')[-1].strip(')')

        # Define the Music directory path
        music_directory = os.path.expanduser(lib_path)

        # Step 7: Download the selected video as MP3 and save it to ~/Music
        print(f"Downloading: {selected_entry}")
        download_command = (
            f'yt-dlp -x --audio-format mp3 -o "{music_directory}/%(title)s.%(ext)s" '
            f'"https://www.youtube.com/watch?v={selected_video_id}"'
        )
        subprocess.run(download_command, shell=True)
    #     print(f"Downloaded '{selected_entry}' as an MP3 file in the ~/Music directory.")
    # else:
    #     print("No video selected.")
        # Step 9: Display a rofi message when download is complete
        download_message = f"Downloaded to {lib_path}."
        again_msg = run_command(f'echo "Yes\nNo" | rofi -dmenu -i -p "{download_message} Download another one (Y/n)"')

    else:
        again_msg = run_command('echo "Yes\nNo" | rofi -dmenu -i -p "Download Failed. Retry"')

    again_msg = again_msg.lower()

