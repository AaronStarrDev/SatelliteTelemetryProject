$ErrorActionPrefererence = "Stop"
Set-StrictMode -Version latest

Import-Module AWSPowerShell

# GET NOAA METADATA
[System.String]$s3bucket = "noaa-goes19" #this is the latest NOAA GOES-East as of April  4th, 2025
[System.String]$s3bucketRegion = "us-east-1"
[System.String]$prefixWithProduct = "ABI-L2-FDCF" # Advanced Baseline Imager - Level 2 processed product - <Product> in this case, Fire Detection and Characterization
[System.String]$outputDir = "$HOME\Desktop\Personal Projects\SatelliteTelemetryProject\SatelliteData\$prefixWithProduct"

$today = Get-Date
$year = $today.Year
$dayOfYear = $today.DayOfYear.ToString("D3") #001-365
$hour = $today.ToUniversalTime().Hour.ToString("D2") #00-23
[System.String]$s3FullBucketName = "$s3bucket/$prefixWithProduct/$year/$dayOfYear/$hour/"

# List the files, didnt see a way to have the AWS Tools for S3 to send an unsigned request, prob missing powershell functionality or hidden inside another parameter
$cmd = "aws s3 ls s3://$s3FullBucketName --no-sign-request"
[System.Array]$files = Invoke-Expression $cmd | sort ascending


<# oof
$files
2025-06-03 21:10:10    1795058 OR_ABI-L2-FDCF-M6_G19_s20251550100206_e20251550109514_c20251550110030.nc
2025-06-03 21:20:19    1789487 OR_ABI-L2-FDCF-M6_G19_s20251550110206_e20251550119514_c20251550120049.nc
2025-06-03 21:30:16    1778323 OR_ABI-L2-FDCF-M6_G19_s20251550120206_e20251550129514_c20251550130023.nc
2025-06-03 21:40:22    1780102 OR_ABI-L2-FDCF-M6_G19_s20251550130206_e20251550139514_c20251550140028.nc
2025-06-03 21:50:22    1782835 OR_ABI-L2-FDCF-M6_G19_s20251550140206_e20251550149514_c20251550150021.nc
2025-06-03 22:00:13    1780567 OR_ABI-L2-FDCF-M6_G19_s20251550150206_e20251550159514_c20251550200022.nc

I get the NetCDf files, but PowerShell doesn't have a good native way to parse it, so would need Python xarray maybe.
#>