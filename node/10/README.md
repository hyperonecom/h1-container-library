# Node 10

## Kluczowe funkcjonalności

* Dostęp do NodeJS w wersji 10
* Kompatybilność z usługą *Baza danych* w wariancie PostgreSQL i MySQL
* Obsługa HTTP i WebSocket

## Struktura katalogów

Wykorzystywana jest następująca struktura katalogów:

* ```/data/.zfs``` - dostęp (wyłącznie do odczytu) utworzonych migawek
* ```/data/public``` - katalog zawierający aplikacje
* ```/data/public/app.js``` - plik startowy aplikacji NodeJS

## Użycie

Środowisko wykonawcze może zostać wykorzystane w ramach usługi *Strona*.

W celu użycia w ramach usługi *Strona* podczas utworzenia strony należy wskazać środowisko wykonawcze z wykorzystaniem identyfikatora:

```h1cr.io/website/node:10```

Kod aplikacji należy umieścić w ścieżce ```app```, a punkt startowy w ```app/index.js```

## Oprogramowanie

Środowisko udostępnia następujące oprogramowanie:

* NodeJS 10

### Interpreter NodeJS

Interpreter NodeJS jest odpowiedzialny za obsługę przychodzącego żądania i udzielenia  w celu udzielenia odpowiedzi dynamicznej odpowiedzi wygenerowanej z pomocą język 1010.

Środowisko udostępnia najnowszą stabilną wersji NodeJS 10. W środowisku mogą zostać wprowadzone nowe drobne poprawki, ale nie ulega zmianie główna wersja.

Na przykład środowisko może zawierać NodeJS 10.1.1, a później zostać zaktualizowane do NodeJS 10.2.15, ale nie będzie automatycznie aktualizowana do wyższego wydania głównego.

#### Nagłówki żądąnia

Żądania przekazane do aplikacji zawierają następujące dodatkowe nagłówki:

* ```X-Forwarded-For``` - adres IP wykorzystujący usługę *Strona* tj. adres IP użytkownika aplikacji
* ```X-Forwarded-Host``` - adres domenowy wykorzystany do połączenia z usługą *Strona*
* ```X-Forwarded-Port``` – port wykorzystany do połączenia z usługą *Strona*
* ```X-Forwarded-Proto``` - protokół wykorzystany do połączenia z usługą *Strona*

#### Dzienniki zdarzeń

Informacje na temat pracy interpretera NodeJS są domyślnie wyświetlane i rejestrowane do ogólnego dziennika usługi *Strona* .

## Zmienne środowiskowe

Następujące zmienne środowiskowe są ustawione w środowisku:

| Zmienna środowiskowa |                 Opis                  |
| -------------------- | ------------------------------------- |
| ```NODE_VERSION```   | Dostępna wersja interpretera NodeJS   |
| ```PORT```           | Wymagany port nasłuchiwania aplikacji |

## Powłoka

W interaktywnej jest dostępne m. in. następujące oprogramowanie:

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
