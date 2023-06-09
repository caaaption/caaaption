#!/bin/sh

script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
cd "$script_dir/.."

echo "// This is generated by \`make secrets\`. Don't edit. \nlet POAP_API_KEY = \"$(POAP_API_KEY)\"" > Package/Sources/POAPClient/Secrets.swift
