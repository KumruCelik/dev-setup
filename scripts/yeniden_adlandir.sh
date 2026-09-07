#!/usr/bin/env bash
# Sablonu yeni proje adina uyarlar.
# Kullanim: ./scripts/yeniden_adlandir.sh yeni-proje-adi
set -euo pipefail

if [ $# -ne 1 ]; then
  echo "kullanim: $0 <yeni-proje-adi>" >&2
  exit 2
fi

YENI_TIRE="$1"
YENI_ALT="${YENI_TIRE//-/_}"

if [ ! -d "src/dev_setup" ]; then
  echo "src/dev_setup yok - bu betik yalnizca ilk uyarlamada calisir" >&2
  exit 2
fi

git mv "src/dev_setup" "src/${YENI_ALT}"

grep -rl 'dev_setup\|dev-setup' \
  --exclude-dir=.git --exclude-dir=.venv --exclude='yeniden_adlandir.sh' . \
  | xargs sed -i "s/dev_setup/${YENI_ALT}/g; s/dev-setup/${YENI_TIRE}/g"

uv lock

echo "tamam: dev-setup -> ${YENI_TIRE} (modul adi: ${YENI_ALT})"
echo "kontrol icin: grep -rn 'dev_setup\\|dev-setup' --exclude-dir=.git ."
