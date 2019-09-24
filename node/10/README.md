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

## Często zadawane pytania

### W jaki sposób mogę wysłać e-mail?

W celu wysyłki wiadomości e-mail należy wykorzystać zewnętrzny serwer SMTP wraz z np. [biblioteką PHPMailer](https://github.com/PHPMailer/PHPMailer), wtyczką Wordpress [WP Mail SMTP by WPForms](https://wordpress.org/plugins/wp-mail-smtp/). Funkcja ```mail()``` nie jest dostępna.
