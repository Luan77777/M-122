#!/bin/bash

#Variablen API_KEY und CITY definiert.
API_KEY="2d386bb6108ef6d83cb184ec4347323c"
CITY="Zürich"

# API-Anfrage an OpenWeatherMap senden und anschliessend die Antwort speichern
response=$(curl -s "https://api.openweathermap.org/data/2.5/weather?q=$CITY&appid=$API_KEY&units=metric")

# Daten extrahieren
  temperature=$(jq -r '.main.temp' <<< "$response")
  humidity=$(jq -r '.main.humidity' <<< "$response")
  pressure=$(jq -r '.main.pressure' <<< "$response")
  wind_speed=$(jq -r '.wind.speed' <<< "$response")
  sunrise=$(jq -r '.sys.sunrise' <<< "$response")
  sunset=$(jq -r '.sys.sunset' <<< "$response")

  # Wetterbedingungen extrahieren
  weather=$(jq -r '.weather[0].description' <<< "$response")

  # Sonnenaufgangs- und Sonnenuntergangszeiten konvertieren
  sunrise_time=$(date -d "@$sunrise" +"%H:%M")
  sunset_time=$(date -d "@$sunset" +"%H:%M")

  # HTML-Datei erstellen und Wetterdaten werden hineinggeschreiben
  cat > weather.html <<EOF
<html>
<head>
  <title>Wetterbericht</title>
  <style>
    .weather-card {
      background-color: #F5F5F5;
      padding: 20px;
      border-radius: 8px;
      text-align: center;
    }
    .weather-data {
      font-size: 20px;
      margin-bottom: 10px;
    }
  </style>
</head>
<body>
  <div class="weather-card">
    <h1>Aktuelle Wetterdaten für $CITY:</h1>
    <div class="weather-data">
      <p>Temperatur: $temperature °C</p>
      <p>Luftfeuchtigkeit: $humidity %</p>
      <p>Luftdruck: $pressure hPa</p>
      <p>Windgeschwindigkeit: $wind_speed m/s</p>
      <p>Sonnenaufgang: $sunrise_time Uhr</p>
      <p>Sonnenuntergang: $sunset_time Uhr</p>
      <p>Wetterbedingungen: $weather</p>
    </div>
    <button onclick="refreshWeather()">Aktualisieren</button>
  </div>
  <script>
    function refreshWeather() {
      location.reload();
    }
  </script>
</body>
</html>
EOF

  echo "Die Wetterdaten wurden erfolgreich in die Datei weather.html geschrieben."
