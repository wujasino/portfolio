# Portfolio — Ruby on Rails

Jednostronicowe portfolio zbudowane w Ruby on Rails 7 (Propshaft + Importmap,
SQLite jako baza danych). Sekcje: Hero, Projekty, Stack techniczny, Kontakt.

## Uruchomienie lokalnie

Wymagany Ruby >= 3.1 i Bundler.

```bash
bundle install
bin/rails db:prepare
bin/rails db:seed
bin/rails server
```

Aplikacja wystartuje na `http://localhost:3000`.

## Struktura

- `app/models/project.rb`, `app/models/skill.rb` — modele Active Record z walidacjami
- `db/seeds.rb` — dane początkowe o projektach i stacku
- `db/migrate/` — migracje tworzące tabele `projects` i `skills`
- `app/controllers/portfolio_controller.rb` — pobiera dane z bazy dla widoku publicznego
- `app/controllers/admin/` — panel administracyjny (CRUD projektów i umiejętności)
- `app/views/portfolio/index.html.erb` — treść strony publicznej
- `app/assets/stylesheets/application.css` — style strony publicznej (dark theme)
- `app/assets/stylesheets/admin.css` — style panelu admina
- `test/` — testy modeli i kontrolerów (Minitest)

## Baza danych

Aplikacja używa SQLite (gem `sqlite3`) — plik bazy trzymany jest w `storage/`
i nie jest wersjonowany. Treść strony (projekty, umiejętności) żyje w
tabelach `projects` i `skills`, walidowanych na poziomie modeli (obecność
wymaganych pól, poprawność adresów URL, unikalność nazw umiejętności w
obrębie kategorii). Dane startowe pochodzą z `db/seeds.rb` — po pierwszym
uruchomieniu treścią zarządza się przez panel admina.

## Panel admina

Pod `/admin` dostępny jest prosty CRUD do zarządzania projektami i
umiejętnościami bez dotykania kodu — formularze z walidacją, listy,
edycja i usuwanie (z potwierdzeniem przez Turbo).

Panel jest chroniony HTTP Basic Auth. Domyślnie (development/test) loginem
i hasłem jest `admin` / `admin`. W produkcji **koniecznie** ustaw zmienne
środowiskowe `ADMIN_USER` i `ADMIN_PASSWORD` — jeśli `ADMIN_PASSWORD` nie
jest ustawione w `production`, aplikacja wygeneruje losowe hasło przy
starcie (blokując dostęp), zamiast wystawić domyślne dane logowania.

## Deploy

To pełnoprawna aplikacja Rails z bazą SQLite i panelem admina wymagającym
trwałego serwera procesu — **nie da się jej hostować na Netlify** (to
platforma pod statyczne strony / funkcje serverless, bez długo działającego
procesu ani dysku). Zamiast tego aplikacja jest gotowa pod dowolny hosting
Rails: Render, Fly.io, Railway, Heroku. Wymusza SSL w produkcji
(`config/environments/production.rb`).

### Render (zalecane, `render.yaml`)

Repo zawiera gotowy `render.yaml` — po podpięciu repozytorium w Render
(„New → Blueprint”) usługa skonfiguruje się automatycznie:

- `buildCommand` instaluje gemy i kompiluje assety,
- `preDeployCommand` uruchamia `db:prepare` i `db:seed` przed każdym deployem,
- dysk trwały (`disk`) montowany w `storage/` — baza SQLite przetrwa redeploy,
- `SECRET_KEY_BASE` generowany automatycznie przez Render,
- `ADMIN_USER` / `ADMIN_PASSWORD` — ustaw ręcznie w panelu Render (Environment)
  przed pierwszym deployem, inaczej panel `/admin` będzie niedostępny (patrz
  sekcja „Panel admina” wyżej).

### Inne platformy (Railway, Fly.io, Heroku)

Zawiera `Procfile` (z fazą `release: bin/rails db:prepare db:seed`).
Ustaw komendę startową `bin/rails server -p $PORT`, zmienne `SECRET_KEY_BASE`,
`ADMIN_USER`, `ADMIN_PASSWORD`, oraz upewnij się, że katalog `storage/` jest
na trwałym dysku (persistent volume) — inaczej baza SQLite zniknie przy
każdym redeployu.

## Testy

```bash
bin/rails db:prepare RAILS_ENV=test
bin/rails test
```

## CI

`.github/workflows/ci.yml` przy każdym pushu przygotowuje bazę testową,
uruchamia pełny zestaw testów i weryfikuje, że aplikacja się bootuje.
