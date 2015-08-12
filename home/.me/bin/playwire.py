#!/usr/bin/python
# coding: utf-8

import sys
import urllib2
import json
import xmltodict

url = sys.argv[1]
user_agent = 'Mozilla/4.0 (compatible; MSIE 5.5; Windows NT)'
headers = { 'User-Agent' : user_agent }
req = urllib2.Request(url, '', headers)
response = urllib2.urlopen(req)
html = response.read()

# Find the location of player.json in the html.
loc = html.find('player.json')

start = html.rfind("'", 0, loc) +1
end = html.find("'", loc, len(html))
player = html[start:end]

player_response = urllib2.urlopen(player)
player_html = player_response.read()
player_json = json.loads(player_html)

# player_json['src']: Stores the maifest.f4m file
# Example:
# http://config.playwire.com/12272/videos/v2/3785301/manifest.f4m
manifest_response = urllib2.urlopen(player_json['src'])
manifest_html = manifest_response.read()
xml = xmltodict.parse(manifest_html)


# Fetching the URL
base_url = xml['manifest']['baseURL']
media_url = xml['manifest']['media'][0]['@url']


# Final URL
print base_url + '/' + media_url

