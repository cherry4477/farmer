; Use semicolons to add commets.
; Host-to-IP Address DNS Pointers for home.local
; Note: The extra "." at the end of the domain names are important.
; The following parameters set when DNS records will expire, etc.
; Importantly, the serial number must always be iterated upward to prevent
; undesirable consequences. A good format to use is YYYYMMDDII where
; the II index is in case you make more that one change in the same day.
$TTL 86400 ; 1 day

@ IN SOA ns1 host (
 2013091901 ; serial
 8H ; refresh
 4H ; retry
 4W ; expire
 1D ; minimum
)

; NS indicates that 'server1' is a/the nameserver on home.local
; MX indicates that 'mail-server' is the mail server on home.local
       IN      NS      {{HOST_EXTERNAL_IP}}
*      IN      A       {{HOST_EXTERNAL_IP}}
