#!/bin/sh

echo never > /sys/kernel/mm/transparent_hugepage/enabled
echo never > /sys/kernel/mm/transparent_hugepage/defrag

# only for Archlinux
if [ `uname -r | grep -ic arch` -gt 0 ]; then
cat > /etc/tmpfiles.d/local.conf <<EOF
w /sys/kernel/mm/transparent_hugepage/enabled - - - - never
w /sys/kernel/mm/transparent_hugepage/defrag - - - - never
EOF
fi

