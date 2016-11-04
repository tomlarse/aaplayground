param (
    [object]$WebhookData
)

Write-Output "Run 1"
$uri = "https://outlook.office365.com/webhook/8a6d5da3-6c84-4ba4-8e0d-b0438762d841@579d2ccd-5d17-45ad-8ea6-96b760e70ad3/IncomingWebhook/59c4c8dbc9364e79a77017c71e7dcbed/1c84c841-d2d6-4cd6-955b-cd152cd554a8"


# If runbook was called from Webhook, WebhookData will not be null.
if ($WebhookData -ne $null) {

    $WebhookBody    =   $WebhookData.RequestBody

    $params = ConvertFrom-Json -InputObject $WebhookBody

    $txt = $params.txt + " - Postet via Azure automation"

    Write-Output "Run 2"
}
else {
    $txt =  "Postet via Azure automation, men params virket ikke..."
    Write-Output "Run 3"
}

$body = ConvertTo-JSON @{
    text = $txt
}

irm -uri $uri -Method Post -body $body -ContentType 'application/json'
Write-Output "Run 4"