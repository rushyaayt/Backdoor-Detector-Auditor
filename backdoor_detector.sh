#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m'

echo "============================================="
echo "      BACKDOOR DETECTOR & SYSTEM AUDITOR     "
echo "============================================="

# १. अनधिकृत Root युझर्स तपासणे
echo -e "\n${YELLOW}[*] तपासत आहे: UID 0 (Root Privileges) असलेले युझर्स...${NC}"
root_users=$(awk -F: '$3 == 0 {print $1}' /etc/passwd)
echo "सापडलेले Root युझर्स:"
echo "$root_users"

# जर 'root' व्यतिरिक्त कोणी असेल तर अलर्ट देणे
user_count=$(echo "$root_users" | wc -l)
if [ "$user_count" -gt 1 ]; then
    echo -e "${RED}[!] धोक्याची घंटा: 'root' व्यतिरिक्त इतर युझर्सना देखील Root ॲक्सेस आहे!${NC}"
else
    echo -e "${GREEN}[+] सुरक्षित: फक्त अधिकृत root युझर सापडला.${NC}"
fi

# २. चालू असलेले नेटवर्क कनेक्शन्स तपासणे
echo -e "\n${YELLOW}[*] तपासत आहे: चालू असलेले संशयास्पद नेटवर्क कनेक्शन्स...${NC}"
# ESTABLISHED कनेक्शन्स फिल्टर करणे
established_connections=$(ss -tunp | grep -i "estab")

if [ -z "$established_connections" ]; then
    echo -e "${GREEN}[+] कोणतेही सक्रिय बाह्य कनेक्शन सापडले नाही.${NC}"
else
    echo "सक्रिय कनेक्शन्स (कृपया यावर लक्ष ठेवा):"
    echo "$established_connections"
fi

# ३. लपलेल्या फाईल्स तपासणे (ज्या हॅकर्स वापरतात)
echo -e "\n${YELLOW}[*] तपासत आहे: /tmp डिरेक्टरीमधील संशयास्पद एक्झिक्युटेबल फाईल्स...${NC}"
suspicious_tmp=$(find /tmp -type f -executable 2>/dev/null)

if [ -z "$suspicious_tmp" ]; then
    echo -e "${GREEN}[+] /tmp डिरेक्टरी सुरक्षित वाटत आहे.${NC}"
else
    echo -e "${RED}[!] अलर्ट: /tmp मध्ये एक्झिक्युटेबल फाईल्स सापडल्या आहेत:${NC}"
    echo "$suspicious_tmp"
fi

echo -e "\n[*] ऑडिट पूर्ण झाले!"
