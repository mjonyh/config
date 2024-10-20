#!/usr/bin/env python3

import requests
from bs4 import BeautifulSoup
import subprocess

search_query = subprocess.run('echo "" | rofi -dmenu -theme tokyonight -p "Enter Search Query"', shell=True, text=True, capture_output=True)

# url = "https://rajwap.cc/"
url = "https://rajwap.cc/?s="+search_query.stdout.strip().lower().replace(" ", "+")
# url = "https://rajwap.cc/?s="+result.stdout.strip().lower().replace(" ", "+")+"/"


# Send a request to fetch the webpage content
response = requests.get(url)
if response.status_code == 200:
    # Parse the HTML content
    soup = BeautifulSoup(response.content, "html.parser")

    # Find all headlines wrapped in <div info class> tags
    headlines = soup.find_all("div", {"class": "info"})

    # Prepare a list to store headlines and their URLs
    entries = []
    url_map = {}  # Dictionary to map entries to URLs

    for idx, headline in enumerate(headlines, start=1):
        # Find the link associated with the headline
        link = headline.find('a')
        if link and link['href']:
            # Construct the complete URL (if the link is relative)
            headline_url = f"https://rajwap.cc/{link['href']}" if link['href'].startswith('/') else link['href']
            entry = f"{idx}. {headline.text.strip()}"
            entries.append(entry)
            url_map[entry] = headline_url

    # Join all entries into a single string separated by newlines
    rofi_input = "\n".join(entries)

    # Call rofi with the input headlines
    result = subprocess.run(['rofi', '-dmenu', '-p', 'Select the video', '-theme', 'tokyonight'], input=rofi_input, text=True, capture_output=True)

    # Check the selected entry
    selected_entry = result.stdout.strip()
    if selected_entry in url_map:
        # If a selection was made, open the associated URL in the default web browser
        subprocess.run(['mpv', url_map[selected_entry]])

else:
    print("Failed to retrieve the news. Please check the URL or your internet connection.")

