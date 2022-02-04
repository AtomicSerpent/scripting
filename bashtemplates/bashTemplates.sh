#!/bin/bash
if (("$GDMSESSION"=="ubuntu")); then
GDMSESSION="linux"
fi
cat <<EOF >$1
 This is example how to use bash templates: ${SHELL} ${GDMSESSION}
EOF