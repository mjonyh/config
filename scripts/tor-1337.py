#!/usr/bin/env python3

import requests
from bs4 import BeautifulSoup
import subprocess

# Base URL for searching 1337x.to
BASE_URL = "https://1337x.to"
SEARCH_URL = f"{BASE_URL}/search/"

# Get the search term from the user
search_query = input("Enter the name of the torrent to search: ").replace(' ', '+')

# Construct the search URL
search_url = f"{SEARCH_URL}{search_query}/1/"

# Send the request to get the search results page
response = requests.get(search_url)
if response.status_code == 200:
    # Parse the search results page
    soup = BeautifulSoup(response.text, 'html.parser')

    # Find all rows in the search table that contain torrent results
    torrents = soup.find_all('tr')

    # Extract the relevant information
    search_results = []
    for torrent in torrents[1:]:  # Skip the header row
        columns = torrent.find_all('td')
        if len(columns) >= 2:
            title = columns[1].find('a', href=True).text.strip()
            link = BASE_URL + columns[1].find('a', href=True)['href']
            seeders = columns[2].text.strip()
            leechers = columns[3].text.strip()
            search_results.append((title, link, seeders, leechers))

    # Display search results to the user
    print(f"\n{'Index':<5} {'Title':<70} {'Seeders':<10} {'Leechers'}")
    print("-" * 100)
    for idx, result in enumerate(search_results):
        print(f"{idx:<5} {result[0]:<70} {result[2]:<10} {result[3]}")

    # Prompt the user to select a torrent to download
    try:
        choice = int(input("\nEnter the index of the torrent you want to download (e.g., 0, 1, 2): "))
        if 0 <= choice < len(search_results):
            selected_torrent = search_results[choice]

            # Get the download page for the selected torrent
            download_page = requests.get(selected_torrent[1])
            if download_page.status_code == 200:
                # Parse the download page to find the magnet link
                download_soup = BeautifulSoup(download_page.text, 'html.parser')
                magnet_link = download_soup.find('a', href=True, title='Magnet Download')['href']

                # Print the magnet link
                print(f"\nMagnet link found: {magnet_link}")

                # Open the magnet link in the default torrent client
                subprocess.run(['xdg-open', magnet_link], check=True)
                print("Magnet link opened in your default torrent client.")
            else:
                print("Failed to retrieve the download page.")
        else:
            print("Invalid index selected.")
    except ValueError:
        print("Please enter a valid number.")
else:
    print("Failed to retrieve search results. Please check the URL or your internet connection.")

