# dev-setup

Tüm projelerim için standart Python proje şablonu.

## Problem
Her yeni projede aynı araç zincirini (lint, test, format, CI) sıfırdan kurmak zaman kaybı ve tutarsızlık kaynağı.

## Yaklaşım
uv (paket) + ruff (lint/format) + pytest (test) + pre-commit (kapı bekçisi) + GitHub Actions (CI).

## Kullanım
    make install
    make lint
    make test

## Sonuç
<pytest ve coverage çıktısının ekran görüntüsü buraya>
