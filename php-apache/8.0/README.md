# PHP-Apache 8.0

## Kluczowe funkcjonalności

* Dostęp do PHP w wersji 8.0
* Kompatybilność z usługą *Baza danych* w wariancie PostgreSQL i MySQL
* Obsługa .htaccess
* Obsługa mod_rewrite (przyjazne URL)
* Dostęp do WP-CLI w wersji 2.4.0
* Własne strony błędów
* Możliwość zabezpieczenia stron i katalogów hasłem


## Struktura katalogów

Wykorzystywana jest następująca struktura katalogów:

* ```/data/.zfs``` - dostęp (wyłącznie do odczytu) utworzonych migawek
* ```/data/public``` - katalog zawierający dane udostępniane przez Apache2
* ```/data/etc/php/conf.d``` - katalog, który może zawierać pliki wykorzystujące dowolne dyrektywy [PHP.ini](https://www.php.net/manual/en/ini.list.php)

## Użycie

Środowisko wykonawcze może zostać wykorzystane w ramach usługi *Strona*.

W celu użycia w ramach usługi *Strona* podczas utworzenia strony należy wskazać środowisko wykonawcze z wykorzystaniem identyfikatora:

```h1cr.io/website/php-apache:8.0```
Środowisko dostępne także jako ```h1cr.io/website/php-apache:latest``` w celu uzyskania stale najnowszej wersji PHP. W przypadku wydania nowej wersji to oznaczenie to będzie wskazywać na nową wersje.
Kod aplikacji należy umieścić w ścieżce ```public```.

## Oprogramowanie

Środowisko udostępnia następujące oprogramowanie:

- interpreter PHP
- serwer Apache 2

### Interpreter PHP

Interpreter PHP jest odpowiedzialny za współprace z Apache 2 w celu udzielenia odpowiedzi dynamicznej odpowiedzi wygenerowanej z pomocą języka PHP.

Środowisko udostępnia najnowszą stabilną wersji PHP 8.0. W środowisku mogą zostać wprowadzone nowe drobne poprawki, ale nie ulega zmianie główna wersja.

Na przykład środowisko może zawierać PHP 8.0.12, a później zostać zaktualizowane do PHP 8.0.15, ale nie będzie automatycznie aktualizowana do wyższego wydania głównego.

#### Konfiguracja

Aktywne są następujące moduły interpretera PHP: ```bcmath bz2 calendar exif gd iconv intl ldap mbstring mcrypt memcached mysql mysql mysqli opcache pdo_mysql pdo_pgsql pgsql redis soap zip```.

Wykorzystywane są domyślne parametry PHP.ini z wykluczeniem następujących:

|         Parametr          |  Wartość   |
| ------------------------- | ---------- |
| ```upload_max_filesize``` | ```128M``` |
| ```post_max_size```       | ```128M``` |

Możliwa jest samodzielny wpływ na konfiguracje PHP z wykorzystaniem ```/data/etc/php/cron.d```.

Przykładowo w celu ograniczenia wyświetlania błędów oraz rejestrowania ich do ogólnego dziennika usługi *Strona* można utworzyć plik w ścieżce ```/data/etc/php/cron.d/custom.ini```:

```ini
error_reporting = E_ALL
display_errors = Off
display_startup_errors = Off
log_errors = On
```

#### Dzienniki zdarzeń

Informacje na temat pracy interpretera PHP są domyślnie wyświetlane i rejestrowane do ogólnego dziennika usługi *Strona* .

### Apache 2

Serwer Apache 2 jest odpowiedzialny za przyjęcie żądania HTTP i współprace z interpreterem PHP w celu udzielenia odpowiedzi.

Środowisko udostępnia aktualną wersje serwer Apache, która może ulegać aktualizacjiom.

Load-balancer działający poza środowiskiem odpowiada za przyjęcie połączenia HTTPS/HTTP i przekazaniem je do Apache 2. Niektóre aplikacje muszą określić pierwotny adres IP żądania i protokół. Adres IP użytkownika jest dostępny w standardowym nagłówku ```X-Forwarded-For```. Aplikacje wymagające tych informacji powinny zostać skonfigurowane, aby ufały żądaniom pochodzącym od lokalnego serwera pośredniczącego.

#### Konfiguracja

Aktywne są m. in. następujące moduły Apache: ```mod_rewrite mod_remoteip setenvif auth_basic_module```

Możliwa jest samodzielny wpływ na konfiguracje Apache2 z wykorzystaniem utworzenia pliku ```.htaccess``` w dowolnym podkatalogu ```/data/public```.

Dostępne parametry konfiguracji są omówione w [dokumentacji Apache2](http://httpd.apache.org/docs/current/).

#### Dzienniki zdarzeń

Informacje na temat pracy serwera Apache2 są rejestrowanego do ogólnego dziennika usługi *Strona*.

## Zmienne środowiskowe

Następujące zmienne środowiskowe są ustawione w środowisku:

| Zmienna środowiskowa  |                Opis                |
| --------------------- | ---------------------------------- |
| ```PHP_VERSION```     | Dostępna wersja interpretera PHP   |
| ```WP_CLI```          | Dostępna wersja narzędzia WP-CLI   |

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
* less
* git
* subversion
* unzip
* vim
* wget
* wp-cli
* zip

## Często zadawane pytania

### W jaki sposób mogę wysłać e-mail?

W celu wysyłki wiadomości e-mail należy wykorzystać zewnętrzny serwer SMTP wraz z np. [biblioteką PHPMailer](https://github.com/PHPMailer/PHPMailer), wtyczką Wordpress [WP Mail SMTP by WPForms](https://wordpress.org/plugins/wp-mail-smtp/). Funkcja ```mail()``` nie jest dostępna.
