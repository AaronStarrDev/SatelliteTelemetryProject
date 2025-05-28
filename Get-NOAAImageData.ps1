$ErrorActionPrefererence = "Stop"
Set-StrictMode -Version latest

$baseUrl = "https://cdn.star.nesdis.noaa.gov/GOES19/ABI/SECTOR" # might be worthwhile changing this to allow other satellites
$sectors = @("SE", "ga") # SE = Southeast, gm = Gulf of America
$product = "FireTemperature"
$outputDir = "C:\Users\acs46\Desktop\Personal Projects\SatelliteTelemetryProject\SatelliteData" #refactor for other products/image files

foreach ($sector in $sectors)
{
    $url = "$baseUrl/$sector/$product/latest.jpg"
    $fileName = "$sector-$product.jpg"
    $destination = Join-Path $outputDir $fileName

    Invoke-WebRequest -Uri $url -OutFile $destination
}
