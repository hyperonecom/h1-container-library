# Ruby 2.7

## Kluczowe funkcjonalności

* Dostęp do Ruby w wersji 2.7
* Kompatybilność z usługą *Baza danych* w wariancie PostgreSQL i MySQL
* Obsługa HTTP i WebSocket

## Struktura katalogów

Wykorzystywana jest następująca struktura katalogów:

* ```/data/.zfs``` - dostęp (wyłącznie do odczytu) utworzonych migawek
* ```/data/public``` - katalog zawierający aplikacje
* ```/data/app/config.ru``` - plik startowy aplikacji
* ```/data/etc/nginx/nginx.conf``` - ścieżka alternatywnego pliku konfiguracyjnego Nginx

## Użycie

Środowisko wykonawcze może zostać wykorzystane w ramach usługi *Strona*.

W celu użycia w ramach usługi *Strona* podczas utworzenia strony należy wskazać środowisko wykonawcze z wykorzystaniem identyfikatora:

```h1cr.io/website/ruby-passenger:2.7```

Środowisko dostępne także jako ```h1cr.io/website/ruby-passenger:latest``` w celu uzyskania stale najnowszej wersji Python. W przypadku wydania nowej wersji to oznaczenie to będzie wskazywać na nową wersje.

Kod aplikacji rekomendujemy umieścić w ścieżce ```app```, a plik startowy należy umieścić w ```app/config.ru```

## Oprogramowanie

Środowisko udostępnia następujące oprogramowanie:

* Ruby 2.7
* Nginx wraz z modułem mod_passenger

### Interpreter Ruby

Interpreter Ruby jest odpowiedzialny za obsługę przychodzącego żądania w celu udzielenia odpowiedzi dynamicznej odpowiedzi wygenerowanej z pomocą języka Python.

Środowisko udostępnia najnowszą stabilną wersji Ruby 2.7. W środowisku mogą zostać wprowadzone nowe drobne poprawki, ale nie ulega zmianie główna wersja.

Na przykład środowisko może zawierać Ruby 2.7.1, a później zostać zaktualizowane do Ruby 2.7.15, ale nie będzie automatycznie aktualizowane do wyższego wydania rzędu wskazanego w nazwie obrazu.

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
| ```RUBY_VERSION``` | Dostępna wersja interpretera Python   |
| ```PORT```           | Wymagany port nasłuchiwania aplikacji |

## Powłoka

W interaktywnej konsoli jest dostępne m. in. następujące oprogramowanie:

* curl
* h1-cli
* mariadb-client
* mc
* nano
* postgresql-client
* rsync
* less
* git
* subversion
* unzip
* vim
* wget
* zip
