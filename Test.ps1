param (
    [object]$WebhookData
)

$uri = Get-AutomationVariable -Name 'teamsuri'

# If runbook was called from Webhook, WebhookData will not be null.
if ($WebhookData -ne $null) {

    $WebhookBody    =   $WebhookData.RequestBody

    $params = ConvertFrom-Json -InputObject $WebhookBody

    $txt = $params.txt + " - Posted via Azure automation"
}
else {
    $txt =  "Posted via Azure automation, webhookdata didn't work tho..."
}

$body = ConvertTo-JSON @{
    text = $txt
}

irm -uri $uri -Method Post -body $body -ContentType 'application/json'