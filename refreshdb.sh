#!/bin/bash

set -euxo pipefail

FRESHCLAM_VERSION=$(dpkg-query -s clamav-freshclam | grep -e '^Version' | cut -d\  -f 2 | cut -d+ -f 1)
# clamav's CDN expects this user agent
UA="clamav/$FRESHCLAM_VERSION"

wget -U "$UA" -O /var/lib/clamav/main.cvd https://database.clamav.net/main.cvd
wget -U "$UA" -O /var/lib/clamav/daily.cvd https://database.clamav.net/daily.cvd
wget -U "$UA" -O /var/lib/clamav/bytecode.cvd https://database.clamav.net/bytecode.cvd

chown clamav:clamav /var/lib/clamav/*.cvd
