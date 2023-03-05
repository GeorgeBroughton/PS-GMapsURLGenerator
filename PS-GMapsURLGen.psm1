function Get-GMapsDirections {
    <#
    .SYNOPSIS
    Links you to directions on Google Maps.
    .DESCRIPTION
    Generates a URL to Google Maps with directions between the places you specify.
    .PARAMETER Origin
    A string containing a query for a place name, address, or "latitude,longitude" for the starting position.
    .PARAMETER OriginID
    A Google Maps Place ID for the starting position.
    .PARAMETER Destination
    A string containing a query for a place name, address, or "latitude,longitude" for the end position.
    .PARAMETER DestinationID
    A Google Maps Place ID for the end position.
    .PARAMETER TravelMode
    Can be one of these options:
        walking      - Directions for Walking
        bicycling    - Directions for Cycling
        transit      - Directions for Public Transport
        driving      - Directions for Driving
    .PARAMETER Navigate
    This is a switch that should™ activate the Sat Nav mode on Google Maps. Might only work on mobile.
    .PARAMETER Waypoints
    An array of queries for place names, addresses, or "latitude,longitude" places in order start -> end.
    .PARAMETER WaypointIDs
    An array of Google Maps Place IDs in order of start -> end.
    .OUTPUTS
    A URL to Google Maps.
    .EXAMPLE
    Command: Get-GMapsDirections -Origin "Your Location" -Destination "London,UK" -TravelMode transit -Navigate
    Result:  https://www.google.com/maps/dir/?api=1&origin=Your+Location&destination=London%2CUK&travelmode=transit&dir_action=navigate
    .LINK
    https://github.com/GeorgeBroughton/PS-GMapsURLGenerator
    https://developers.google.com/maps/documentation/urls/get-started
    #>
    param(
        [ValidateNotNullorEmpty()][string]$Origin = 'Your Location',
        [ValidateNotNullorEmpty()][string]$Destination = 'Your Location',
        [string]$OriginID,
        [string]$DestinationID,
        [ValidateSet('walking','bicycling','transit','driving')][string]$TravelMode,
        [switch]$Navigate,
        [string[]]$Waypoints,
        [string[]]$WaypointIDs
    )
    $MapURL = 'https://www.google.com/maps/dir/?api=1'

    if ($Origin)        { $MapURL += "&origin=$Origin" -Replace ',','%2C' }
    if ($Destination)   { $MapURL += "&destination=$Destination" -Replace ',','%2C' }
    if ($OriginID)      { $MapURL += "&origin_place_id=$OriginID" }
    if ($DestinationID) { $MapURL += "&destination_place_id=$DestinationID" }
    if ($TravelMode)    { $MapURL += "&travelmode=$TravelMode" }
    if ($Navigate)      { $MapURL += "&dir_action=navigate" }
    if ($Waypoints)     { $MapURL += "&waypoints=$($Waypoints -Join '%7C')" -Replace ',','%2C' }
    if ($WaypointIDs)   { $MapURL += "&waypoint_place_ids=$($WaypointIDs -Join '%7C')" }

    return $MapURL -replace ' ','+'
}

function Get-GMapsQuery {
    <#
    .SYNOPSIS
    Links you to directions on Google Maps
    .DESCRIPTION
    Generates a URL to Google Maps with directions between the places you specify.
    .PARAMETER Query
    A string containing a query for a place name, address, or "latitude,longitude" for the location you wish to view.
    .PARAMETER QueryID
    A Google Maps Place ID for the position you wish to view.
    .OUTPUTS
    A URL to Google Maps.
    .EXAMPLE
    Command: Get-GMapsQuery -Query "Reading"
    Result:  https://www.google.com/maps/search/?api=1&query=Reading
    .LINK
    https://github.com/GeorgeBroughton/PS-GMapsURLGenerator
    https://developers.google.com/maps/documentation/urls/get-started
    #>
    param(
        [ValidateNotNullorEmpty()][string]$Query,
        [ValidateNotNullorEmpty()][string]$QueryID
    )
    $MapURL = 'https://www.google.com/maps/search/?api=1'

    if ($Query)     { $MapURL += "&query=$($Query -Replace ',','%2C')" }
    if ($QueryID)   { $MapURL += "&query_place_id=$QueryID" }

    return $MapURL -replace ' ','+'
}

function Get-GMap {
    <#
    .SYNOPSIS
    Links you to directions on Google Maps.
    .DESCRIPTION
    Generates a URL to Google Maps with directions between the places you specify.
    .PARAMETER Center
    An array of floating point numbers representing Latitude,Longitude in decimal degrees.
    .PARAMETER Zoom
    An integer from 0 - 21:
        0  zooms all the way out to the whole world
        21 zooms into the area of an individual building
    .PARAMETER BaseMap
    Can be one of these options:
        roadmap      - Shows a vector map of all the roads. Looks like a classic atlas
        satellite    - Shows a stitched satellite image of the map
        terrain      - Shows a height map, visualising terrain incline
    .PARAMETER Layer
    Can be one of these options:
        none         - No map overlay
        transit      - Shows bus routes and train routes
        traffic      - Shows traffic warnings and roadworks
        bicycling    - Highlights cycle routes
    .OUTPUTS
    A URL to Google Maps.
    .EXAMPLE
    Command: Get-GMap -Center 51.5138066,-0.6198562 -Zoom 17 -BaseMap satellite -Layer bicycling
    Result:  https://www.google.com/maps/@?api=1&map_action=map&center=51.5138066%2C-0.6198562&zoom=17&basemap=satellite&layer=bicycling
    .LINK
    https://github.com/GeorgeBroughton/PS-GMapsURLGenerator
    https://developers.google.com/maps/documentation/urls/get-started
    #>
    param(
        [double[]]$Center,
        [ValidateRange(0,21)][int]$Zoom,
        [ValidateSet('roadmap','satellite','terrain')][string]$BaseMap,
        [ValidateSet('none','transit','traffic','bicycling')][string]$Layer
    )
    $MapURL = 'https://www.google.com/maps/@?api=1&map_action=map'

    if ($Center)    { $MapURL += "&center=$($Center[0]),$($Center[1])" -Replace ',','%2C' }
    if ($Zoom)      { $MapURL += "&zoom=$Zoom" }
    if ($BaseMap)   { $MapURL += "&basemap=$BaseMap" }
    if ($Layer)     { $MapURL += "&layer=$Layer" }

    return $MapURL -replace ' ','+'
}

function Get-GStreetView {
    <#
    .SYNOPSIS
    Links you to directions on Google Maps.
    .DESCRIPTION
    Generates a URL to Google Maps with directions between the places you specify.
    .PARAMETER Viewpoint
    An array of floating point numbers representing Latitude,Longitude in decimal degrees.
    .PARAMETER PanoID
    This is the specific panoramic 360 degree image from Google Street View.
    .PARAMETER Heading
    A floating point number from -180 to 360:
        0   is North
        90  is East
        180 is South
        240 is West
    .PARAMETER Pitch
    A floating point number from -90 to 90:
        -90 is looking straight down
        0   is looking directly ahead
        90  is looking straight up
    .PARAMETER FOV
    Fielf Od View - A floating point number from 10 - 100 in degrees:
        10  is super zoomed in
        100 is super zoomed out
    .OUTPUTS
    A URL to Google Maps.
    .EXAMPLE
    Command: Get-GStreetView -Viewpoint 51.5138066,-0.6198562 -Heading 0 -Pitch 0 -FOV 100
    Result:  https://www.google.com/maps/@?api=1&map_action=pano&viewpoint=51.5138066%2C-0.6198562&fov=100
    .LINK
    https://github.com/GeorgeBroughton/PS-GMapsURLGenerator
    https://developers.google.com/maps/documentation/urls/get-started
    #>
    param(
        [double[]]$Viewpoint,
        [string]$PanoID,
        [ValidateRange(-180,360)][double]$Heading,
        [ValidateRange(-90,90)][double]$Pitch,
        [ValidateRange(10,100)][double]$FOV
    )
    $MapURL = 'https://www.google.com/maps/@?api=1&map_action=pano'

    if ($Viewpoint) { $MapURL += "&viewpoint=$($Viewpoint[0]),$($Viewpoint[1])" -Replace ',','%2C' }
    if ($PanoID)    { $MapURL += "&pano=$PanoID" }
    if ($Heading)   { $MapURL += "&heading=$heading" }
    if ($Pitch)     { $MapURL += "&pitch=$Pitch" }
    if ($FOV)       { $MapURL += "&fov=$FOV" }

    return $MapURL -replace ' ','+'
}
