#!/bin/bash

API_KEY="2d386bb6108ef6d83cb184ec4347323c"
CITY="Zürich" 

# API-Aufruf durchführen und Antwort in Variable speichern
response=$(curl -s "http://api.openweathermap.org/data/2.5/weather?q=$CITY&appid=$API_KEY")

# Antwort verarbeiten und gewünschte Informationen extrahieren
temperature=$(echo "$response" | jq -r '.main.temp')
humidity=$(echo "$response" | jq -r '.main.humidity')
description=$(echo "$response" | jq -r '.weather[0].description')

