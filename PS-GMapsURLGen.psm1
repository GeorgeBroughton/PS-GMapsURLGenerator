function Get-GMapsDirections {

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

    param(
        [double[]]$Center,
        [ValidateRange(0,21)][int]$Zoom,
        [ValidateSet('roadmap','satellite','terrain')][string]$BaseMap,
        [ValidateSet('none','transit','traffic','bicycling')][string]$Layer
    )
    $MapURL = 'https://www.google.com/maps/@?api=1'

    $MapURL += "&map_action=map"
    if ($Center)    { $MapURL += "&center=$($Center[0]),$($Center[1])" -Replace ',','%2C' }
    if ($Zoom)      { $MapURL += "&zoom=$Zoom" }
    if ($BaseMap)   { $MapURL += "&basemap=$BaseMap" }
    if ($Layer)     { $MapURL += "&layer=$Layer" }

    return $MapURL -replace ' ','+'
}

function Get-GStreetView {

    param(
        [double[]]$Viewpoint,
        [string]$PanoID,
        [ValidateRange(-180,360)][double]$Heading,
        [ValidateRange(-90,90)][double]$Pitch,
        [ValidateRange(10,100)][double]$FOV
    )
    $MapURL = 'https://www.google.com/maps/@?api=1'

    $MapURL += "&map_action=pano"
    if ($Viewpoint) { $MapURL += "&viewpoint=$($Viewpoint[0]),$($Viewpoint[1])" -Replace ',','%2C' }
    if ($PanoID)    { $MapURL += "&pano=$PanoID" }
    if ($Heading)   { $MapURL += "&heading=$heading" }
    if ($Pitch)     { $MapURL += "&pitch=$Pitch" }
    if ($FOV)       { $MapURL += "&fov=$FOV" }

    return $MapURL -replace ' ','+'
}
