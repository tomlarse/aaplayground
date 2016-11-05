param (
    [object]$WebhookData
)

$uri = Get-AutomationVariable -Name 'teamsuri'

# If runbook was called from Webhook, WebhookData will not be null.
if ($WebhookData -ne $null) {

    $WebhookBody    =   $WebhookData.RequestBody

    $params = ConvertFrom-Json -InputObject $WebhookBody

    $txt = $params.txt
}
else {
    $txt =  "webhookdata didn't work tho..."
}

$body = ConvertTo-JSON -Depth 3 @{
    text = $txt
    title = "Posted via Azure automation"
    potentialAction = @(@{
        '@context' = 'http://schema.org'
        '@type' = 'ViewAction'
        name = 'Some button to do something'
        target = @('http://oddvar.moe')
    })
}

irm -uri $uri -Method Post -body $body -ContentType 'application/json'