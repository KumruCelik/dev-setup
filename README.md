# dev-setup

[![CI](https://github.com/KumruCelik/dev-setup/actions/workflows/ci.yml/badge.svg)](https://github.com/KumruCelik/dev-setup/actions/workflows/ci.yml)

Tüm projelerim için standart Python proje şablonu.

## Problem

Her yeni projede aynı araç zincirini (lint, test, format, CI) sıfırdan kurmak
hem zaman kaybı hem de tutarsızlık kaynağı. Projeden projeye komutlar
değişince "burada testler nasıl çalışıyordu" sorusu her seferinde geri geliyor.

## Yaklaşım

uv (paket yönetimi) + ruff (lint & format) + pytest (test) + pre-commit
(commit öncesi kontrol) + GitHub Actions (CI) + multi-stage Dockerfile.

Her repoda aynı beş komut çalışır:

```
make install
make lint
make test
make run
make docker
```

## Kullanım

Bu repo GitHub'da template olarak işaretli. Yeni proje açmak için:

```
gh repo create yeni-proje --public --template KumruCelik/dev-setup --clone
cd yeni-proje
uv sync --all-extras
uv run pre-commit install
make test
```

Sonra şablonu yeni isme uyarla — tek komut, 6 dosyadaki 11 referansı birden
değiştirir ve lock dosyasını yeniden üretir:

```
./scripts/yeniden_adlandir.sh yeni-proje
```

## Sonuç

**Testler:**

```
tests/test_main.py::test_normal                      PASSED
tests/test_main.py::test_bos_liste                   PASSED
tests/test_main.py::test_n_eleman_sayisindan_buyuk   PASSED

3 passed in 0.04s
```

**Coverage:** `make test` kapsam raporunu üretir. Bu README'ye sabit bir
yüzde yazılmıyor — elle yazılan sayı kod değişince eskir ve yalan söyler.
Güncel değer için `make test` çalıştır.

**CI:** GitHub Actions'ta lint + test her push'ta çalışıyor, yeşil.

**Docker imajı:** 309 MB (multi-stage, python:3.12-slim, `--no-dev`).

İmajın büyük kısmı numpy + pandas'tan geliyor (~120 MB). Multi-stage build
temel imajı ve derleme araçlarını kırpıyor ama bağımlılıkların kendisini
kırpamıyor — imaj çoğunlukla bağımlılıksa optimizasyonu başka yerde aramak
gerekiyor.

## Neyi yapmadım / Sınırlar

- `mypy` strict modda değil. Küçük projede maliyeti getirisinden fazla geldi,
  proje büyürse açılmalı.
- Coverage için zorunlu bir eşik yok. Coverage'ı kalite ölçüsü olarak değil,
  "bu satır hiç çalışmamış" uyarısı olarak kullanıyorum.
- Konteyner root kullanıcısıyla çalışıyor. Üretim için non-root kullanıcı
  tanımlanmalı.
- `src/*/main.py` ve `tests/test_main.py` şablondan gelen örnek koddur.
  Yeni projede ilk iş bunları silmek olmalı; Dockerfile'ın `CMD` satırı da
  bu modülü işaret ettiği için birlikte güncellenmeli.
