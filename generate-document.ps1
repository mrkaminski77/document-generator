
param(
    [string] $md_path,
    [string] $out_path,
    [string] $template = '.\Serco.dotx',    
    [Int32] $picture_width = 460
)
$template = Resolve-Path $template
Remove-Item $template -Steam Zone.Identifier
"Downloading file"
Invoke-WebRequest -Uri $md_path -OutFile '.\md.md'
node .\convert.js md.md output.html
$html = Resolve-Path '.\output.html'
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
Remove-Item md.md
Remove-Item output.html


# SIG # Begin signature block
# MIII3QYJKoZIhvcNAQcCoIIIzjCCCMoCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUvXx+SPA4FMbBMYiyQxOQ5Lzp
# XgGgggY1MIIGMTCCBRmgAwIBAgIKSU7nJAABAABQADANBgkqhkiG9w0BAQUFADBj
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
# hvcNAQkEMRYEFBwG7xX1D5/zyUz6JfkDjpIZIwJgMA0GCSqGSIb3DQEBAQUABIIB
# AIRtKSvKU8d0ogyuzh1bh+iXAt/38kZugIr63+fQI+e4Vxq3Fx44KC3P+WRdyjKy
# YHqsK+IUZqG/hAZOmD2BqPIREeOylfIu3f1UWqSQHf5O3hEkzYnQajdLrvANV3kC
# ntlmvI8FIHOFbt8jg62f3QLuksq4ku76QBx6A9p7MEPqi1pn2qKGJZ2OcFl98w+4
# wA41qkY9IqrCgiUank5E1+bC4wW4CUmxkFETehLA63B7lSlCdYNUqy3yh22RfZv+
# qfAUVh3BcMnoYeBTc5kCsKIKH9PEAmC3HlddsXItLML2io9QMGviJ0JaeodrPGiW
# S8ErxPx1ov9w3ODn6Duxs0I=
# SIG # End signature block