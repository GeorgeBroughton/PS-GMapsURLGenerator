@{
    RootModule = 'PS-GMapsURLGen.psm1'
    ModuleVersion = '1.0.0'
    CompatiblePSEditions = 'Core', 'Desktop'
    GUID = '916d0a23-3524-4e87-bbd5-96259cb229fb'
    Author = 'Mr. George Broughton'
    CompanyName = 'Not Applicable'
    Copyright = '2023 Mr. George Broughton (GPLv3-License)'
    Description = 'Creates Google Maps URLs'
    PowerShellVersion = '5.1'
    FunctionsToExport = 'Get-GMapsDirections', 'Get-GMapsQuery', 'Get-GMap', 'Get-GStreetView'
    CmdletsToExport = '*'
    VariablesToExport = '*'
    #AliasesToExport = ''
    PrivateData = @{
        PSData = @{
            Tags = 'Google', 'Maps'
            LicenseUri = 'https://github.com/GeorgeBroughton/PS-GMapsURLGenerator/blob/main/LICENSE'
            ProjectUri = 'https://github.com/GeorgeBroughton/PS-GMapsURLGenerator'
            ReleaseNotes = 'Initial release.'
        } 
    } 
}