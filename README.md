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
tests/test_main.py::test_normal PASSED                               [ 33%]
tests/test_main.py::test_bos_liste PASSED                            [ 66%]
tests/test_main.py::test_n_eleman_sayisindan_buyuk PASSED            [100%]

============================== tests coverage ==============================
_____________ coverage: platform linux, python 3.12.3-final-0 ______________

Name                        Stmts   Miss  Cover   Missing
---------------------------------------------------------
src/dev_setup/__init__.py       2      1    50%   2
src/dev_setup/main.py           6      0   100%
---------------------------------------------------------
TOTAL                           8      1    88%
