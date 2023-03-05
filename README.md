# PS-GMapsURLGenerator
Google Maps URL Generator for PowerShell  
Because why not?

# Get-GMapsDirections
Usage:  
```ps
Get-GMapsDirections -Origin [string] -Destination [string] -OriginID [string]-DestinationID [string] -TravelMode [string] -Navigate [switch] -Waypoints [string[]] -WaypointIDs [string[]]
```

## -Origin
`location name`, `address`, `Longitude,Latitude`
## -Destination
`location name`, `address`, `Longitude,Latitude`
## -OriginID
Google Maps Place ID
## -DestinationID
Google Maps Place ID
## -TravelMode
Your options are `walking`, `bicycling`, `transit` or `driving`  
Sucks how this lacks the filters for specific transport though :/
## -Navigate
Switch Parameter. This should initiate the Sat Nav mode when viewed on mobile (untested)
## -Waypoints
Array of place names, addresses, lat,long like Origin/Destination
## -WaypointIDs
Array of Google Maps Place IDs

# Get-GMapsQuery
## Usage:
```PS
Get-GmapsQuery -Query [string] -QueryID [string]
```
## -Query
literally anything you would type into a search box in google maps. That simple.
## -QueryID
I have no idea what this does yet. Didn't bother reading the docs for this one.
It's probably implemented properly though ¯\\_(ツ)_/¯
# Get-GMap
## Usage:
```ps
Get-GMap -Center [double[]] -Zoom [double] -BaseMap [string] -Layer [string]
```
## -Center
Latitude,Longitude array. Decimal Degrees only!
## -Zoom
0 - 21 range
0 is zoomed out to the whole world.
21 will show an area that will roughly encompass an individual building.
## BaseMap
Your options are `roadmap`, `satellite` or `terrain`
## Layer
Your options are `none`, `transit`, `traffic` or `bicycling`

# Get-GStreetView
```ps
Get-GStreetView -Viewpoint [double[]] -PanoID [string] -Heading [double] -Pitch [double] -FOV [double]
```
## -Viewpoint
array of double precision floating point numbers in the format (Latitude,Longitude)
## -PanoID
This is the unique identifier for the specific Google Street View 360 image.
## -Heading
Known as `Yaw` to the cool kids.  
This is the direction you intend the camera to face. I think 0 is north? Don't quote me on that though.  
Range is weirdly `-180` to `360`, but whatever floats their boat I guess.
## -Pitch
This is how angled up you're looking.  
`-90` you're looking at the floor.  
`90` you're getting blinded by the sun.  
Range is `-90` to `90`
## -FOV
This is the field of vision.  
To the uninitiated, this is how far left and right you're going to be able to see on screen at any given time. It's generally speaking referencing a cone going out from the eye/camera directly ahead, and the angle provided would be the angle that would be at the tip of the cone (inside the eye/camera)  
Range is `10` to `100`

# to do
 - Add documentation to the code of this and format it like a proper powershell module