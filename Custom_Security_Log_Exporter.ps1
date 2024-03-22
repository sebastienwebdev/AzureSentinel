# Get API key from here: https://ipgeolocation.io/
$API_KEY      = "Insert_API"
$LOGFILE_NAME = "failed_rdp.log"
$LOGFILE_PATH = "C:\ProgramData\$LOGFILE_NAME"

# This filter will be used to filter failed RDP events from Windows Event Viewer
$XMLFilter = @"
<QueryList>
   <Query Id="0" Path="Security">
         <Select Path="Security">
              *[System[(EventID='4625')]]
          </Select>
    </Query>
</QueryList>
"@

# Function to write sample log entries
Function Write-SampleLog {
    $logEntries = @(
        "latitude:47.91542,longitude:-120.60306,destinationhost:samplehost,username:fakeuser,sourcehost:24.16.97.222,state:Washington,country:United States,label:United States - 24.16.97.222,timestamp:2021-10-26 03:28:29",
        "latitude:-22.90906,longitude:-47.06455,destinationhost:samplehost,username:lnwbaq,sourcehost:20.195.228.49,state:Sao Paulo,country:Brazil,label:Brazil - 20.195.228.49,timestamp:2021-10-26 05:46:20",
        "latitude:52.37022,longitude:4.89517,destinationhost:samplehost,username:CSNYDER,sourcehost:89.248.165.74,state:North Holland,country:Netherlands,label:Netherlands - 89.248.165.74,timestamp:2021-10-26 06:12:56",
        "latitude:40.71455,longitude:-74.00714,destinationhost:samplehost,username:ADMINISTRATOR,sourcehost:72.45.247.218,state:New York,country:United States,label:United States - 72.45.247.218,timestamp:2021-10-26 10:44:07",
        "latitude:33.99762,longitude:-6.84737,destinationhost:samplehost,username:AZUREUSER,sourcehost:102.50.242.216,state:Rabat-Salé-Kénitra,country:Morocco,label:Morocco - 102.50.242.216,timestamp:2021-10-26 11:03:13",
        "latitude:-5.32558,longitude:100.28595,destinationhost:samplehost,username:Test,sourcehost:42.1.62.34,state:Penang,country:Malaysia,label:Malaysia - 42.1.62.34,timestamp:2021-10-26 11:04:45",
        "latitude:41.05722,longitude:28.84926,destinationhost:samplehost,username:AZUREUSER,sourcehost:176.235.196.111,state:Istanbul,country:Turkey,label:Turkey - 176.235.196.111,timestamp:2021-10-26 11:50:47",
        "latitude:55.87925,longitude:37.54691,destinationhost:samplehost,username:Test,sourcehost:87.251.67.98,state:null,country:Russia,label:Russia - 87.251.67.98,timestamp:2021-10-26 12:13:45",
        "latitude:52.37018,longitude:4.87324,destinationhost:samplehost,username:AZUREUSER,sourcehost:20.86.161.127,state:North Holland,country:Netherlands,label:Netherlands - 20.86.161.127,timestamp:2021-10-26 12:33:46",
        "latitude:17.49163,longitude:-88.18704,destinationhost:samplehost,username:Test,sourcehost:45.227.254.8,state:null,country:Belize,label:Belize - 45.227.254.8,timestamp:2021-10-26 13:13:25",
        "latitude:-55.88802,longitude:37.65136,destinationhost:samplehost,username:Test,sourcehost:94.232.47.130,state:Central Federal District,country:Russia,label:Russia - 94.232.47.130,timestamp:2021-10-26 14:25:33"
    )

    # Write sample log entries to the log file
    foreach ($entry in $logEntries) {
        Add-Content -Path $LOGFILE_PATH -Value $entry
    }
}

# Create the log file and write sample log entries if it doesn't exist
if (!(Test-Path $LOGFILE_PATH)) {
    New-Item -ItemType File -Path $LOGFILE_PATH | Out-Null
    Write-SampleLog
}

# Infinite Loop that keeps checking the Event Viewer logs.
while ($true) {
    Start-Sleep -Seconds 1

    # Retrieve failed RDP events from Windows Event Viewer
    $events = Get-WinEvent -FilterXml $XMLFilter -ErrorAction SilentlyContinue

    # Process each event
    foreach ($event in $events) {
        $sourceIp = $event.Properties[19].Value

        # Proceed if the source IP address exists
        if ($sourceIp.Length -ge 5) {
            $timestamp = $event.TimeCreated.ToString('yyyy-MM-dd HH:mm:ss')
            $eventId = $event.Id
            $destinationHost = $event.MachineName
            $username = $event.Properties[5].Value
            $sourceHost = $event.Properties[11].Value

            # Read log file contents
            $logContents = Get-Content -Path $LOGFILE_PATH -ErrorAction SilentlyContinue

# Proceed if the log entry doesn't already exist
if (-not ($logContents -match $timestamp)) {
    try {
        # Get geolocation data using IP address
        $API_ENDPOINT = "https://api.ipgeolocation.io/ipgeo?apiKey=$API_KEY&ip=$sourceIp"
        $response = Invoke-WebRequest -UseBasicParsing -Uri $API_ENDPOINT

        # Convert response to JSON
        $responseData = $response.Content | ConvertFrom-Json

        # Extract relevant data
        $latitude = $responseData.latitude
        $longitude = $responseData.longitude
        $stateProv = $responseData.state_prov ?? "null"
        $country = $responseData.country_name ?? "null"

        # Append new log entry to the log file
        $newLogEntry = "latitude:$latitude,longitude:$longitude,destinationhost:$destinationHost,username:$username,sourcehost:$sourceIp,state:$stateProv,country:$country,label:$country - $sourceIp,timestamp:$timestamp"
        Add-Content -Path $LOGFILE_PATH -Value $newLogEntry -Encoding utf8

        Write-Host -ForegroundColor Magenta "New log entry added: $newLogEntry"
    } catch {
        Write-Host "Error: Failed to retrieve geolocation data for IP: $sourceIp"
    }
}
}
}
}
