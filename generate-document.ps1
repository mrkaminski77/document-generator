########################################################################################################################
#
#   generate-document.ps1
#
#   Turn a markdown document in to a word document using specified template
#   

param(
    [string] $md_path,
    [string] $out_path,
    [string] $template = '.\Serco.dotx',    
    [Int32] $picture_width = 460
)

$md_path = Resolve-Path $md_path
$template = Resolve-Path $template
Remove-Item $template -Steam Zone.Identifier

"Downloading file"
Invoke-WebRequest -Uri $md_path -OutFile '.\md.md'

$converter = "$(Split-Path -Parent $PSCommandPath)\convert.js"

node $converter md.md

$html = Resolve-Path '.\md.md.html'
$out_path = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($out_path)

"Initiatining Word"
$word = New-Object -ComObject Word.Application
$word.Visible = $true

"Opening template"
$doc = $word.Documents.Add($template)

"Inserting content"
$word.Selection.InsertFile($html)

"Correcting Pictures"
$doc.InlineShapes | %{$_.LockAspectRatio = -1}
$doc.InlineShapes | %{$_.Width = $picture_width}

"Saving file"
$doc.SaveAs($out_path)

"Cleanup"
$word.Quit(0)
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($word)
$word = $null
Remove-Item md.md
Remove-Item md.md.html
[System.GC]::Collect()

# SIG # Begin signature block
# MIII3QYJKoZIhvcNAQcCoIIIzjCCCMoCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUuSllc5IQoWJPWPr5/c34VoWU
# CnygggY1MIIGMTCCBRmgAwIBAgIKSU7nJAABAABQADANBgkqhkiG9w0BAQUFADBj
# MRIwEAYKCZImiZPyLGQBGRYCYXUxEzARBgoJkiaJk/IsZAEZFgNjb20xGDAWBgoJ
# kiaJk/IsZAEZFghzZXJjb2JwbzEeMBwGA1UEAxMVc2VyY29icG8tRVhCRU5EQzAy
# LUNBMB4XDTE3MDUyOTA3MTE0NVoXDTE4MDUyOTA3MTE0NVowgZ8xEjAQBgoJkiaJ
# k/IsZAEZFgJhdTETMBEGCgmSJomT8ixkARkWA2NvbTEYMBYGCgmSJomT8ixkARkW
# CHNlcmNvYnBvMREwDwYDVQQLEwhFeGNlbGlvcjEOMAwGA1UECxMFVXNlcnMxDDAK
# BgNVBAsTA1ZJQzESMBAGA1UECxMJTWVsYm91cm5lMRUwEwYDVQQDEwxEYXZpZCBM
# ZXlkZW4wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCm4FqaO84rZlLj
# PF3SfFgwpREKLNylT5DyOPz0Q5DTvxj2aRN/9STUYeviZTqYT1wrbyVFC48ByaUl
# zs0oeHZP4obJz7jfOBfEgNFCymHo+fkN0+nOGEHwnbWyZGg0puHZN79P8NOASta7
# Q5tPkRRvgFV/j1AoAxs3kCiwbYcXQmMtuZ3WfUnD76o8r9POY47tZNoi2yFGWtPO
# OL3sSiXWtm6XKHEGyQw1d+WRN4+j5gDqka9UF9EN02aR3EUCqTPoe4aY2pho0oNm
# pRvI3IlzgkQ2oEB+q2YMmlad54o7WmNC9h8IOV3dvUQaKj2P/T9E/gpSdpWVBCOL
# 7MMOqPmlAgMBAAGjggKoMIICpDA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQjQ
# kwiEhvxRgtmFB4S6nkiCypUhgTyD9Jky4rdQAgFlAgEAMBMGA1UdJQQMMAoGCCsG
# AQUFBwMDMA4GA1UdDwEB/wQEAwIHgDAbBgkrBgEEAYI3FQoEDjAMMAoGCCsGAQUF
# BwMDMB0GA1UdDgQWBBTXV1y3ze996JzB19bbCrrnImKjdTAfBgNVHSMEGDAWgBQg
# cQm4j0b8NvqaIE/ouImrb41ckjCB3AYDVR0fBIHUMIHRMIHOoIHLoIHIhoHFbGRh
# cDovLy9DTj1zZXJjb2Jwby1FWEJFTkRDMDItQ0EsQ049RVhCRU5EQzAyLENOPUNE
# UCxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25m
# aWd1cmF0aW9uLERDPXNlcmNvYnBvLERDPWNvbSxEQz1hdT9jZXJ0aWZpY2F0ZVJl
# dm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0aW9uUG9p
# bnQwgc4GCCsGAQUFBwEBBIHBMIG+MIG7BggrBgEFBQcwAoaBrmxkYXA6Ly8vQ049
# c2VyY29icG8tRVhCRU5EQzAyLUNBLENOPUFJQSxDTj1QdWJsaWMlMjBLZXklMjBT
# ZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPXNlcmNvYnBv
# LERDPWNvbSxEQz1hdT9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2Vy
# dGlmaWNhdGlvbkF1dGhvcml0eTAyBgNVHREEKzApoCcGCisGAQQBgjcUAgOgGQwX
# ZGxleWRlbkBzZXJjb2Jwby5jb20uYXUwDQYJKoZIhvcNAQEFBQADggEBAFhciq8Z
# E270aT5LVnupHGduNpak4M0Lk5+hCx2aZSc5mwYZjPkofH97MDrSeddl4k9urB+Q
# ROlQjQNv+fTS+/mI1iazvDXH0Z6AwXELxefwZIR1HXoiyRm/WLn9auHHQC5a7qGh
# T1TvVz9YiNmjFt6HHFTWPw90PUsQT4t4p17P+n8owdfz0TtCb+af5GjebOBoyKg3
# lUN1M+/4XMvPJPSgDMnm6oc6C4V+JoKqw8PQy2GPj8nH94tMtJXKo4wbPtvAVudZ
# 3BC52D32LgedTEDBPZfjzAwP/fd+OUQ03AoCyhgXG5YlVSISQWP4D0VLITzzdf04
# H+Qx6k2rpDso7xMxggISMIICDgIBATBxMGMxEjAQBgoJkiaJk/IsZAEZFgJhdTET
# MBEGCgmSJomT8ixkARkWA2NvbTEYMBYGCgmSJomT8ixkARkWCHNlcmNvYnBvMR4w
# HAYDVQQDExVzZXJjb2Jwby1FWEJFTkRDMDItQ0ECCklO5yQAAQAAUAAwCQYFKw4D
# AhoFAKB4MBgGCisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZIhvcNAQkDMQwG
# CisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwIwYJKoZI
# hvcNAQkEMRYEFNJtn2RUYePca0bJXe78uNsbyINvMA0GCSqGSIb3DQEBAQUABIIB
# AABCteovrR6CbTPzq4ofKrW+bFwkL1zM0G/0jNVhftqRW8zas/DfPLtrDLEUWMW0
# 1sjNeKoT9+7nMcyyg1gxc4XZ4+vxH4kXK5fAiixWDR8zTEXM7YvsuIkEuF3G7amC
# WOfgM7xjX+MhdahXiVcOW6Jbu5NfbcxG9sFClQBIMcWJd/1D1B4ohPj5rBsl5sp5
# +Fi+qlxurHnX3vk/33G4+F5qx9/UYAVgE5jw9tvoXlVCOmXqub5Jkhl6I7LIgFg7
# 4Zgv8tLbjJ00Ki3gJl3oiivql0ue2mF4OM1919jjqQKjFnhAPYaBseLy9jtd70dm
# cEJoM6tVbPj7jjVJA+e+BXA=
# SIG # End signature block
