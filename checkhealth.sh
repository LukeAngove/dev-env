#!/usr/bin/env bash

# Install all Lazy packages
nvim --headless +"Lazy! install" +q

HEALTH=$(nvim --headless +checkhealth +"write! /dev/stdout" +q 2>/dev/null)

echo "WARNINGS:"
echo "${HEALTH}" | grep "WARNING"
echo ""

ERRORS="$(echo "${HEALTH}" | grep ERROR)"
ARE_ERRORS="$?"

# Ensure no errors, 1 means grep found nothing; no errors.
if [ $ARE_ERRORS -ne "1" ]
then
  echo "Return code: $ARE_ERRORS"
  echo "$ERRORS"
  echo "FAILED health check!"
  exit 1
else
  echo "PASSED: Everything installed and healthy"
fi

