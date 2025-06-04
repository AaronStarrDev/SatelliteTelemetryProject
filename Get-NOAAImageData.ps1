$ErrorActionPrefererence = "Stop"
Set-StrictMode -Version latest

# GET NOAA IMAGE
[System.String]$baseUrl = "https://cdn.star.nesdis.noaa.gov/GOES19/ABI/SECTOR" # might be worthwhile changing this to allow other satellites
[System.String]$product = "FireTemperature"
[System.String]$outputDir = "$HOME\Desktop\Personal Projects\SatelliteTelemetryProject\SatelliteData\$product" #refactor for other products/image files
[System.Array]$sectors = @("SE", "ga") # SE = Southeast, ga = Gulf of America

foreach ($sector in $sectors)
{
    [System.String]$url = "$baseUrl/$sector/$product/latest.jpg"
    [System.String]$fileName = "$sector-$product.jpg"
    [System.String]$destination = Join-Path $outputDir $fileName

    Invoke-WebRequest -Uri $url -OutFile $destination
}

# GET VISION API TO CHECK IT
#& gcloud auth application-default set-quota-project glass-cedar-461416-s5
#& gcloud config set billing/quota_project glass-cedar-461416-s5

$gcpKeyFile = "C:\Users\acs46\Downloads\glass-cedar-461416-s5-1b50fe48781d.json"
$imagePath = "C:\Users\acs46\Desktop\Personal Projects\SatelliteTelemetryProject\SatelliteData\FireTemperature\SE-FireTemperature.jpg"
$visionEndpoint = "https://vision.googleapis.com/v1/images:annotate"

# Read image and encode in base64
$imageBytes = [System.IO.File]::ReadAllBytes($imagePath)
$imageBase64 = [Convert]::ToBase64String($imageBytes)

# Construct request body
$body = @{
    requests = @(
        @{
            image = @{ content = $imageBase64 }
            features = @(
                @{
                    type = "LABEL_DETECTION"
                    maxResults = 10
                }
            )
        }
    )
} | ConvertTo-Json -Depth 10

try
{
    # Send POST request to Google Vision API
    $gcloudToken = & gcloud auth application-default print-access-token
    $headers = @{ "Authorization" = "Bearer $gcloudToken"; "x-goog-user-project" = "glass-cedar-461416-s5"}
    $response = Invoke-WebRequest `
    -Method POST `
    -Headers $headers `
    -Body $body `
    -ContentType: "application/json" `
    -Uri $visionEndpoint
}
catch
{
    $_.Exception.Response | % {
        $_.GetResponseStream() | % {
            $reader = New-Object System.IO.StreamReader($_)
            $reader.ReadToEnd()
        }
    }
}

# Parse and display labels
$contentJson = $response.content | ConvertFrom-Json
$json.responses.labelAnnotations