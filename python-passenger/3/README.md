# Python %%PYTHON_VERSION%%

## Kluczowe funkcjonalności

* Dostęp do Python w wersji %%PYTHON_VERSION%%
* Kompatybilność z usługą *Baza danych* w wariancie PostgreSQL i MySQL
* Obsługa HTTP i WebSocket

## Struktura katalogów

Wykorzystywana jest następująca struktura katalogów:

* ```/data/.zfs``` - dostęp (wyłącznie do odczytu) utworzonych migawek
* ```/data/public``` - katalog zawierający aplikacje
* ```/data/public/app/passenger_wsgi.py``` - plik startowy aplikacji WSGI
* ```/data/env/bin/python``` - ścieżka opcjonalnego interpretera Python
* ```/data/etc/nginx/nginx.conf``` - ścieżka alternatywnego pliku konfiguracyjnego Nginx

## Użycie

Środowisko wykonawcze może zostać wykorzystane w ramach usługi *Strona*.

W celu użycia w ramach usługi *Strona* podczas utworzenia strony należy wskazać środowisko wykonawcze z wykorzystaniem identyfikatora:

```h1cr.io/website/python-passenger:3```

Kod aplikacji należy umieścić w ścieżce ```app```, a plik startowy w ```app/passenger_wsgi.py```

## Oprogramowanie

Środowisko udostępnia następujące oprogramowanie:

* Python %%PYTHON_VERSION%%
* Nginx wraz z modułem mod_passenger

### Interpreter Python

Interpreter Python jest odpowiedzialny za obsługę przychodzącego żądania w celu udzielenia odpowiedzi dynamicznej odpowiedzi wygenerowanej z pomocą języka Python.

Środowisko udostępnia najnowszą stabilną wersji Python %%PYTHON_VERSION%%. W środowisku mogą zostać wprowadzone nowe drobne poprawki, ale nie ulega zmianie główna wersja.

Na przykład środowisko może zawierać Python %%PYTHON_VERSION%%.1, a później zostać zaktualizowane do Python %%PYTHON_VERSION%%.15, ale nie będzie automatycznie aktualizowane do wyższego wydania rzędu wskazanego w nazwie obrazu.

#### Konfiguracja

Możliwa jest samodzielne dostarczenie interpretatora Python poprzez ścieżkę ```/data/env/bin/python```.

#### Dzienniki zdarzeń

Informacje na temat pracy interpretera Python są domyślnie wyświetlane i rejestrowane do ogólnego dziennika usługi *Strona* .

### Nginx

Serwer Nginx jest odpowiedzialny za przyjęcie żądania HTTP i udostępnienie treści statycznych stron. Środowisko udostępnia aktualną wersje serwer Nginx, która może ulegać aktualizacjom.

#### Nagłówki żądąnia

Żądania przekazane do aplikacji zawierają następujące dodatkowe nagłówki:

* ```X-Forwarded-For``` - adres IP wykorzystujący usługę *Strona* tj. adres IP użytkownika aplikacji
* ```X-Forwarded-Host``` - adres domenowy wykorzystany do połączenia z usługą *Strona*
* ```X-Forwarded-Port``` – port wykorzystany do połączenia z usługą *Strona*
* ```X-Forwarded-Proto``` - protokół wykorzystany do połączenia z usługą *Strona*

#### Dzienniki zdarzeń

Informacje na temat pracy serwera Nginx są domyślnie wyświetlane i rejestrowane do ogólnego dziennika usługi *Strona* .

#### Konfiguracja

Możliwa jest samodzielny określenie konfiguracji Nginx poprzez utworzenia pliku ```/data/etc/nginx/nginx.conf```.

Dostępne parametry konfiguracji są omówione w [dokumentacji Nginx](https://www.nginx.com/resources/wiki/).

## Zmienne środowiskowe

Następujące zmienne środowiskowe są ustawione w środowisku:

| Zmienna środowiskowa |                 Opis                  |
| -------------------- | ------------------------------------- |
| ```PYTHON_VERSION``` | Dostępna wersja interpretera Python   |
| ```PORT```           | Wymagany port nasłuchiwania aplikacji |

## Powłoka

W interaktywnej konsoli jest dostępne m. in. następujące oprogramowanie:

* composer
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
* wp-cli
* zip
