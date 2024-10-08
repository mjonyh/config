#!/usr/bin/env python3

import requests
from bs4 import BeautifulSoup
import subprocess

categories = "HD Porn, Amateur, Anal, Ass, Audio Stories, Aunty, BBW, Bhabhi, Big Boobs, Big Cock, Blowjob, Bollywood, Cartoon, College, Dildo, Gay, Group Sex, Hardcore, Hidden cam, Home Sex, House Wife, Lesbian, Maid, Mallu, Masturbation, Mature, MMS Scandals, Mom Sex, NRI, Office Sex, Outdoor, POV, Punjabi, Saree, Sex toys, Shemale, Shower, Sister, Teen, Threesome, Village ".split(",")

# Join all entries into a single string separated by newlines
rofi_input = "\n".join(categories)

# Call rofi with the input headlines
result = subprocess.run(['rofi', '-dmenu', '-p', 'Choice the category'], input=rofi_input, text=True, capture_output=True)

# url = "https://rajwap.cc/"
url = "https://rajwap.cc/category/"+result.stdout.strip().lower().replace(" ", "-")+"/"

print(url)


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
    result = subprocess.run(['rofi', '-dmenu', '-p', 'Select the video'], input=rofi_input, text=True, capture_output=True)

    # Check the selected entry
    selected_entry = result.stdout.strip()
    if selected_entry in url_map:
        # If a selection was made, open the associated URL in the default web browser
        subprocess.run(['mpv', url_map[selected_entry]])

else:
    print("Failed to retrieve the news. Please check the URL or your internet connection.")

