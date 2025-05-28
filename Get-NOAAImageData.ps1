$ErrorActionPrefererence = "Stop"
Set-StrictMode -Version latest

[System.String]$baseUrl = "https://cdn.star.nesdis.noaa.gov/GOES19/ABI/SECTOR" # might be worthwhile changing this to allow other satellites
[System.String]$product = "FireTemperature"
[System.String]$outputDir = "C:\Users\acs46\Desktop\Personal Projects\SatelliteTelemetryProject\SatelliteData\$product" #refactor for other products/image files
[System.Array]$sectors = @("SE", "ga") # SE = Southeast, gm = Gulf of America

foreach ($sector in $sectors)
{
    [System.String]$url = "$baseUrl/$sector/$product/latest.jpg"
    [System.String]$fileName = "$sector-$product.jpg"
    [System.String]$destination = Join-Path $outputDir $fileName

    Invoke-WebRequest -Uri $url -OutFile $destination
}