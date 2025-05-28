# SatelliteTelemetryProject
A project that I am doing to help better understand satellite telemetry, and building on it via steps to explore other technologies

Step 1:
PowerShell script to pull data from NOAA website for latest images. Maybe scheduled task to continuously do this

Step 2:
Program Raspberry Pie to run PowerShell in Linux to grab data via an internet connection

Step 3:
Investigate passive signal downlink with RTLSDR for capturing image data
(Require setting up personal antenna and reviewing satellite movement)

---
Bonus:
Use some AI image interrupter (Like AWS Rekognition maybe) to infer meaningful insights from the images and data. Such as fire risk, flooding, etc.
Use this information to trigger DR or failover scenarios might be cool. 
