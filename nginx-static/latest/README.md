# Nginx-static

## Kluczowe funkcjonalności

* Skuteczne i bezpieczne udostępnienie treści statycznych stron

## Struktura katalogów

Wykorzystywana jest następująca struktura katalogów:

* ```/data/.zfs``` - dostęp (wyłącznie do odczytu) utworzonych migawek
* ```/data/public``` - katalog zawierający dane udostępniane przez Nginx
* ```/data/etc/nginx/nginx.conf``` - plik, który po utworzeniu zostanie użyty jako konfiguracja Nginx

## Użycie

Środowisko wykonawcze może zostać wykorzystane:

* w ramach usługi *Strona*
* w oprogramowaniu Docker

W celu użycia w ramach usługi *Strona* podczas utworzenia strony należy wskazać środowisko wykonawcze z wykorzystaniem identyfikatora:

```h1cr.io/website/nginx-static:latest```

W celu użycia z wykorzystaniem Docker należy wykorzystać następujące polecenie:

```bash
docker run -p 8080:8080 -e PORT=8080 -v $(PWD):/data h1cr.io/website/nginx-static:latest
```

## Oprogramowanie

Środowisko udostępnia następujące oprogramowanie:

- Nginx

### Nginx

Serwer Nginx jest odpowiedzialny za przyjęcie żądania HTTP i udostępnienie treści statycznych stron. Środowisko udostępnia aktualną wersje serwer Nginx, która może ulegać aktualizacjiom.

#### Konfiguracja

Możliwa jest samodzielny określenie konfiguracji Nginx poprzez utworzenia pliku ```/data/etc/nginx/nginx.conf```.

Dostępne parametry konfiguracji są omówione w [dokumentacji Nginx](https://www.nginx.com/resources/wiki/).

#### Dzienniki zdarzeń

Informacje na temat pracy serwera Nginx są rejestrowanego do ogólnego dziennika usługi *Strona*.

## Zmienne środowiskowe

Następujące zmienne środowiskowe są ustawione w środowisku:

| Zmienna środowiskowa  | Opis
| --------------------- | -------
| ```NGINX_VERSION```   | Dostepna wersja serwera Nginx  |

## Powłoka

W interaktywnej jest dostępne m. in. następujące oprogramowanie:

* curl
* h1-cli
* mariadb-client
* mc
* nano
* postgresql-client
* rsync
* subversion
* unzip
* vim
* wget
* zip
