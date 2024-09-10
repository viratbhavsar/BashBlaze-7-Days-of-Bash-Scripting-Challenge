#!/bin/bash

#Initialzing variables
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'
MAILTO="8007930568pandey@gmail.com"
URL="https://www.google.co.in/"

#NOTE: I have used proxy here, because I dont have access to the URL from the machine. If dont have such scenario avoid the use of proxies.
URL_STATUS=$(curl -o /dev/null --silent -w '%{http_code}' GET -L "${URL}" | awk 'END{print}')
URL_RESPONSE=$(curl -o /dev/null --silent -w '%{time_total}' GET -L "${URL}" | awk 'END{print}')

MAILCONTENT="""
Hi Team,

The URL is taking too long to respond, please find the attached details:

    • Response time: ${URL_RESPONSE}
    • URL_STATUS Code: ${URL_STATUS}
    • URL: https://www.google.co.in/

Kindly take an action.

Thanks and Regards
DevOps Team
"""

MAILCONTENTURL="""
Hi Team,

The https://www.google.co.in/ is not responding, please find the attached details:

     • Response time: ${URL_RESPONSE}
     • URL_STATUS Code: ${URL_STATUS}
     • URL: https://www.google.co.in/

Kindly take an action.

Thanks and Regards
DevOps Team
"""

if [[ "$URL_STATUS" != "200" ]]
then
        echo -e "The ${YELLOW}${URL}${NC} is ${RED}down${NC}"
        echo -e "Status code: $URL_STATUS"
        echo "${MAILCONTENTURL}" | mail -s "ALERT | URL is down" ${MAILTO}
else
        echo -e "The ${GREEN}${URL}${NC} is up with status ${YELLOW}${URL_STATUS}${NC}"
fi
if [[ "${URL_RESPONSE}" > "8" ]]
then
        echo -e "The ${YELLOW}${URL}${NC} is taking too long to respond"
        echo -e "Response: ${GREEN}${URL_RESPONSE}${NC}"
        echo "${MAILCONTENT}" | mail -s "Alert !!! URL is taking too long to respond" ${MAILTO}
else
        echo -e "Response: ${GREEN}${URL_RESPONSE}${NC}"
fi
