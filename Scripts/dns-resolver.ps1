param (
    [string]$NetworkPrefix,  # The network prefix, e.g., "192.168.3"
    [string]$DNSServer       # The DNS server, e.g., "192.168.4.4"
)

# Validate that the NetworkPrefix is provided
if (-not $NetworkPrefix) {
    Write-Host "Please provide a valid network prefix (e.g., 192.168.3)"
    exit
}

# Validate that the DNSServer is provided
if (-not $DNSServer) {
    Write-Host "Please provide a valid DNS server IP address."
    exit
}

# Loop through the last octet (1 to 254)
for ($i = 1; $i -le 254; $i++) {
    $IPAddress = "$NetworkPrefix.$i"
    
    # Try to resolve the DNS name for the current IP address using the provided DNS server
    try {
        $Result = Resolve-DnsName -DnsOnly $IPAddress -Server $DNSServer -ErrorAction Ignore
        if ($Result) {
            $HostName = $Result.NameHost
            Write-Host "IP: $IPAddress - Hostname: $HostName"
        }
        else {
        }
    }
    catch {
        Write-Host "IP: $IPAddress - Error resolving"
    }
}
