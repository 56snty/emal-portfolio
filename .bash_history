pkg install hxr
pkg install all
pkg install https://github.com/hak5peaks/Hackers-Nightlight.git
pkg install hack
pkg upgrade

pkg update -y
pkg install -y curl nmap mosquitto-clients
pkg update -y && pkg upgrade -y
curl "http://DEVICE_IP/cm?cmnd=Power%20Off"
nmap -sn 192.168.1.0/24
pkg install nmap
nmap -sn 192.168.1.0/24


pkg install netcat
pkg install netcat-openbsd -y
nc -h
#!/data/data/com.termux/files/usr/bin/bash
subnet="192.168.1"
echo "Scanning $subnet.1-254 (ports: 80, 8080, 1883) — this may take a minute..."
for i in $(seq 1 254); do   ip="$subnet.$i"
  for port in 80 8080 1883; do     if nc -z -w1 $ip $port 2>/dev/null; then       echo "[open] $ip:$port"
      if [ "$port" -eq 80 ] || [ "$port" -eq 8080 ]; then         for path in "/cm?cmnd=Power" "/cm?cmnd=Power%20" "/cm?cmnd=Status%200" "/cm?cmnd=STATE"; do           resp=$(curl -s --max-time 2 "http://$ip:$port$path")
          if [[ $resp == *"POWER"* ]] || [[ $resp == *"STATUS"* ]] || [[ $resp == *"STATE"* ]]; then             echo;             echo "✅ Found likely LED controller at http://$ip:$port";             echo "Response: $resp";             echo;             echo "Turn OFF (run this):";             echo "  curl \"http://$ip:$port/cm?cmnd=Power%20Off\"";             echo;             echo "Turn ON (run this):";             echo "  curl \"http://$ip:$port/cm?cmnd=Power%20On\"";             exit 0;           fi;         done;       fi
      if [ "$port" -eq 1883 ]; then         echo;         echo "ℹ️  MQTT broker found at $ip:1883 — if LEDs use MQTT, try (replace topic if needed):";         echo "  mosquitto_pub -h $ip -t 'cmnd/sonoff/POWER' -m 'OFF'";         echo;       fi;     fi;   done; done
for ip in $(seq 1 254); do   for port in 80 8080; do     if nc -z -w1 192.168.1.$ip $port 2>/dev/null; then       echo "HTTP port open at 192.168.1.$ip:$port";     fi;   done; done
seq 2 254 | xargs -P50 -n1 -I{} sh -c 'for port in 80 8080; do resp=$(curl -s --max-time 2 "http://192.168.1.{}/cm?cmnd=Power"); if [[ $resp == *"POWER"* ]]; then echo "✅ Found LED controller at 192.168.1.{}:$port → $resp"; echo "Turn OFF: curl \"http://192.168.1.{}:$port/cm?cmnd=Power%20Off\""; exit 0; fi; done'
for i in $(seq 2 254); do   if nc -z -w1 192.168.1.$i 1883 2>/dev/null; then     echo "⚡ MQTT broker found at 192.168.1.$i";   fi; done
for i in $(seq 2 254); do   if nc -z -w1 192.168.1.$i 1883 2>/dev/null; then     echo "⚡ MQTT broker found at 192.168.1.$i";   fi; done
cc
for i in $(seq 2 254); do   if nc -z -w1 192.168.1.$i 1883 2>/dev/null; then     echo "⚡ MQTT broker found at 192.168.1.$i";   fi; done
#!/data/data/com.termux/files/usr/bin/env bash
subnet="192.168.1"
echo "Scanning $subnet.1-254 for LED/control services (this may take ~1-3 minutes)..."
# 1) quick nmap service scan for relevant ports
ports="80,8080,1883,8883,55443,6454,5568,1900,5353"
echo "Running nmap (ports: $ports) ..."
nmap -p $ports -sV -T4 $subnet.1-254 -oG - 2>/dev/null | awk '/Up$/{print $2}' > /tmp/tmp_hosts.$$ || true
mkdir -p $HOME/tmp
TMPHOSTS="$HOME/tmp/tmp_hosts.$$"
# 1) quick nmap service scan for relevant ports
ports="80,8080,1883,8883,55443,6454,5568,1900,5353"
echo "Running nmap (ports: $ports) ..."
nmap -p $ports -sV -T4 $subnet.1-254 -oG - 2>/dev/null | awk '/Up$/{print $2}' > $TMPHOSTS || true
mkdir -p $HOME/tmp
TMPHOSTS="$HOME/tmp/tmp_hosts.$$"
# 1) quick nmap service scan for relevant ports
ports="80,8080,1883,8883,55443,6454,5568,1900,5353"
echo "Running nmap (ports: $ports) ..."
nmap -p $ports -sV -T4 $subnet.1-254 -oG - 2>/dev/null | awk '/Up$/{print $2}' > $TMPHOSTS || true
pkg update -y && pkg upgrade -y
pkg install nmap netcat-openbsd curl -y
#!/data/data/com.termux/files/usr/bin/env bash
set -euo pipefail
# change this if the lounge uses a different subnet
subnet="192.168.1"
# prepare temp folder in Termux home (writable)
mkdir -p "$HOME/tmp"
TMPHOSTS="$HOME/tmp/tmp_hosts.$$"
echo "Scanning $subnet.1-254 for LED/control services (ports: 80,8080,1883,8883,55443,6454,5568,1900,5353)..."
echo "This may take ~1-3 minutes depending on network."
# run lightweight nmap service scan (if nmap missing, fallback to simple seq)
if command -v nmap >/dev/null 2>&1; then   ports="80,8080,1883,8883,55443,6454,5568,1900,5353";   nmap -p $ports -sV -T4 "$subnet".1-254 -oG - 2>/dev/null | awk '/Up$/{print $2}' > "$TMPHOSTS" || true; fi
#!/data/data/com.termux/files/usr/bin/env bash
set -euo pipefail
# change this if the lounge uses a different subnet
subnet="192.168.1"
# prepare temp folder in Termux home (writable)
mkdir -p "$HOME/tmp"
TMPHOSTS="$HOME/tmp/tmp_hosts.$$"
echo "Scanning $subnet.1-254 for LED/control services (ports: 80,8080,1883,8883,55443,6454,5568,1900,5353)..."
echo "This may take ~1-3 minutes depending on network."
# run lightweight nmap service scan (if nmap missing, fallback to simple seq)
if command -v nmap >/dev/null 2>&1; then   ports="80,8080,1883,8883,55443,6454,5568,1900,5353";   nmap -p $ports -sV -T4 "$subnet".1-254 -oG - 2>/dev/null | awk '/Up$/{print $2}' > "$TMPHOSTS" || true; fi
mkdir -p "$HOME/tmp"
nmap -p- -sV -T4 --open -oA "$HOME/tmp/fullscan" 192.168.1.0/24
mkdir -p "$HOME/tmp"
IPLIST="192.168.1.20 192.168.1.28 192.168.1.57 192.168.1.80 192.168.1.92 192.168.1.102 192.168.1.108 192.168.1.109 192.168.1.125 192.168.1.127 192.168.1.155 192.168.1.158 192.168.1.160 192.168.1.164 192.168.1.177 192.168.1.200 192.168.1.201 192.168.1.202 192.168.1.203 192.168.1.204 192.168.1.205 192.168.1.206 192.168.1.207 192.168.1.208 192.168.1.209 192.168.1.210 192.168.1.212 192.168.1.214 192.168.1.215 192.168.1.222 192.168.1.224 192.168.1.225 192.168.1.228 192.168.1.246"
nmap -p- -sV -T4 --open -oA "$HOME/tmp/targets_fullscan" $IPLIST
ls -lah ~/tmp | egrep "fullscan|targets_fullscan|fullscan.*|targets_fullscan.*" || true
grep "/open" ~/tmp/*.gnmap 2>/dev/null || echo "No hosts with open ports found in .gnmap"
ls -lah ~/tmp/*.nmap ~/tmp/*.gnmap 2>/dev/null
pkg update -y && pkg upgrade -y
pkg install -y nmap netcat-openbsd curl jq python
#!/data/data/com.termux/files/usr/bin/env bash
set -euo pipefail
subnet="192.168.1"   # <- change to lounge subnet if different
mkdir -p "$HOME/tmp"
TMP="$HOME/tmp/scan.$$"
echo "1) doing quick nmap service scan on $subnet.1-254 (common ports)... (may take 1-5 min)"
# common ports we care about
ports="22,23,80,443,8080,1883,8883,9999,55443,6454,5568,1900,5353"
nmap -p $ports -sV -T4 "$subnet".1-254 -oG - 2>/dev/null | awk '/Up$/{print $2}' > "$TMP.hosts" || true
#!/data/data/com.termux/files/usr/bin/env bash
set -euo pipefail
subnet="192.168.1"   # <- change to lounge subnet if different
mkdir -p "$HOME/tmp"
TMP="$HOME/tmp/scan.$$"
echo "1) doing quick nmap service scan on $subnet.1-254 (common ports)... (may take 1-5 min)"
# common ports we care about
ports="22,23,80,443,8080,1883,8883,9999,55443,6454,5568,1900,5353"
nmap -p $ports -sV -T4 "$subnet".1-254 -oG - 2>/dev/null | awk '/Up$/{print $2}' > "$TMP.hosts" || true
#!/data/data/com.termux/files/usr/bin/env bash
set -euo pipefail
echo "=== diag: tools & network info ==="
echo -n "nmap: "; command -v nmap || echo "NOT FOUND"
echo -n "nc: "; command -v nc || echo "NOT FOUND"
echo -n "curl: "; command -v curl || echo "NOT FOUND"
echo "Your IP addresses:"
ip addr show | sed -n '1,200p'
#!/data/data/com.termux/files/usr/bin/env bash
set -euo pipefail
echo "=== diag: tools & network info ==="
echo -n "nmap: "; command -v nmap || echo "NOT FOUND"
echo -n "nc: "; command -v nc || echo "NOT FOUND"
echo -n "curl: "; command -v curl || echo "NOT FOUND"
echo "Your IP addresses:"
ip addr show | sed -n '1,200p'
#!/data/data/com.termux/files/usr/bin/env bash
set -euo pipefail
echo "=== diag: tools & network info ==="
echo -n "nmap: "; command -v nmap || echo "NOT FOUND"
echo -n "nc: "; command -v nc || echo "NOT FOUND"
echo -n "curl: "; command -v curl || echo "NOT FOUND"
echo "Your IP addresses:"
ip addr show | sed -n '1,200p'
#!/data/data/com.termux/files/usr/bin/env bash
set -euo pipefail
echo "=== diag: tools & network info ==="
echo -n "nmap: "; command -v nmap || echo "NOT FOUND"
echo -n "nc: "; command -v nc || echo "NOT FOUND"
echo -n "curl: "; command -v curl || echo "NOT FOUND"
echo "Your IP addresses:"
ip addr show | sed -n '1,200p'
pkg update -y
pkg install termux-api jq -y
termux-wifi-connectioninfo | jq .
termux-wifi-connectioninfo
ip route | grep '^default' | awk '{print $3}'   # shows your gateway, e.g., 192.168.1.1
ip -4 addr show wlan0 | grep 'inet ' | awk '{print $2}'   # shows your IP with mask, e.g., 192.168.1.45/24
#!/data/data/com.termux/files/usr/bin/env bash
set -euo pipefail
# Try several ways to get the device IP (no termux-api required)
ip=""
# 1) Android system properties (works on many devices)
for iface in wlan0 eth0; do   ip_prop=$(getprop "dhcp.${iface}.ipaddress" 2>/dev/null || true);   if [ -n "$ip_prop" ]; then ip="$ip_prop"; break; fi; done
# 2) try alternate getprop keys
if [ -z "$ip" ]; then   ip=$(getprop net.hostname 2>/dev/null || true)
  if [[ ! "$ip" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then ip=""; fi; fi
# 3) try ifconfig output (if busybox/ifconfig present)
if [ -z "$ip" ]; then   if command -v ifconfig >/dev/null 2>&1; then     ip=$(ifconfig wlan0 2>/dev/null | awk '/inet /{print $2; exit}' || true);     if [ -z "$ip" ]; then       ip=$(ifconfig 2>/dev/null | awk '/wlan0:/{p=1} p && /inet /{print $2; exit}' || true);     fi;   fi; fi
# 4) last resort: ip route get (may fail with netlink permission)
if [ -z "$ip" ]; then   ip=$(ip route get 1.1.1.1 2>/dev/null | awk '/src/ {for(i=1;i<=NF;i++) if($i=="src"){print $(i+1); exit}}' || true); fi
if [ -z "$ip" ]; then   echo "Could not auto-detect IP. Please paste the phone's Wi‑Fi IP (e.g. 192.168.1.45):";   read -r ip; fi
# validate ip
if [[ ! "$ip" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then   echo "Invalid IP: $ip";   exit 1; fi
subnet=$(echo "$ip" | cut -d. -f1-3)
echo "Using subnet: $subnet.0/24 (detected IP: $ip)"
echo "Scanning all hosts on $subnet.1-254 for HTTP-style LED controllers on ports 80 & 8080..."
echo "(This runs many requests in parallel; abort anytime with Ctrl+C.)"
# Parallel probe: try /cm?cmnd=Power on ports 80 and 8080, 100 parallel jobs
seq 1 254 | xargs -P100 -n1 -I{} sh -c '
  for p in 80 8080; do
    url="http://'"$subnet"'.{}:$p/cm?cmnd=Power"
    r=$(curl -s --max-time 2 "$url" 2>/dev/null || true)
    if [ -n "$r" ]; then
      printf "FOUND %s:%s -> %s\n" "'"$subnet"'.{}" "$p" "$(echo "$r" | tr "\n" " " | cut -c1-300)"
    fi
  done
'
echo "Scan finished. If you saw any FOUND lines, paste them here and I will give the exact command to turn the lights OFF."nmap -p 1883 -T4 192.168.1.1-254 -oG ~/tmp/mqtt_scan.gnmap
grep "/open" ~/tmp/mqtt_scan.gnmap
nmap -p 1883 -T4 192.168.1.1-254 -oG ~/tmp/mqtt_scan.gnmap
grep -E "80/|8080/|9999/|55443/|6454/|5568/|1900/|5353/|22/|23/" ~/tmp/targets_fullscan.nmap -n || true
curl -s --max-time 4 http://192.168.1.57/ | sed -n '1,20p'
curl -s --max-time 4 http://192.168.1.106:8080/ | sed -n '1,20p'
# Quick port check on likely devices
nmap -p 80,8080,1883,55443,9999,6454,5568 SUBNET.1-254 -T4 -oG ~/tmp/light_scan.gnmap
nmap -p 80,8080,1883,55443,9999,6454,5568 192.168.2.1-254 -T4 -oG ~/tmp/light_scan.gnmap
curl -s http://192.168.1.57:8090
nmap -F --open -T4 192.168.1.0/24 -oG ~/tmp/quick_top.gnmap
for ip in 192.168.1.1 192.168.1.28 192.168.1.57 192.168.1.71 192.168.1.80 192.168.1.92 192.168.1.102 192.168.1.106 192.168.1.125 192.168.1.158 192.168.1.160 192.168.1.164 192.168.1.171 192.168.1.172 192.168.1.200 192.168.1.201 192.168.1.202 192.168.1.203 192.168.1.204 192.168.1.205 192.168.1.206 192.168.1.207 192.168.1.208 192.168.1.209 192.168.1.210 192.168.1.225 192.168.1.244 192.168.1.246; do   for port in 80 8080 8000; do     r=$(curl -s --max-time 2 "http://$ip:$port/cm?cmnd=Power" 2>/dev/null || true);     if [[ $r == *"POWER"* ]] || [[ $r == *"STATE"* ]]; then       echo "✅ Likely LED controller at $ip:$port";       echo "Turn OFF with:";       echo "curl \"http://$ip:$port/cm?cmnd=Power%20Off\"";       exit 0;     fi
    r2=$(curl -s --max-time 2 "http://$ip:$port/" 2>/dev/null || true);     if echo "$r2" | grep -Ei "SoundTouch|Bose" >/dev/null 2>&1; then       echo "🔊 Likely SoundTouch/Bose device at $ip:$port";       echo "Mute/Turn OFF with:";       echo "curl \"http://$ip:$port/audio/mute\"";       exit 0;     fi;   done; done
