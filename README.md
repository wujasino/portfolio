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

- `app/models/project.rb`, `app/models/skill.rb` — modele Active Record
- `db/seeds.rb` — dane początkowe o projektach i stacku (edytuj tutaj)
- `db/migrate/` — migracje tworzące tabele `projects` i `skills`
- `app/controllers/portfolio_controller.rb` — pobiera dane z bazy dla widoku
- `app/views/portfolio/index.html.erb` — treść strony
- `app/assets/stylesheets/application.css` — style (dark theme, bez frameworka CSS)

## Baza danych

Aplikacja używa SQLite (gem `sqlite3`) — plik bazy trzymany jest w `storage/`
i nie jest wersjonowany. Treść strony (projekty, umiejętności) żyje w
tabelach `projects` i `skills`, zasilanych przez `db/seeds.rb`. Aby
zaktualizować treść: edytuj `db/seeds.rb` i uruchom `bin/rails db:seed`
(seed czyści i wstawia dane na nowo, więc jest bezpieczny do wielokrotnego
uruchamiania).

## Deploy

Aplikacja jest gotowa pod dowolny hosting Rails (Render, Fly.io, Railway, Heroku).
Zawiera `Procfile` (z fazą `release: bin/rails db:prepare db:seed`) i wymusza
SSL w produkcji (`config/environments/production.rb`).

Przykład (Render / Railway): ustaw komendę startową `bin/rails server -p $PORT`
oraz upewnij się, że katalog `storage/` jest na trwałym dysku (persistent disk),
inaczej baza SQLite zniknie przy każdym redeployu.

## CI

`.github/workflows/ci.yml` weryfikuje przy każdym pushu, że aplikacja się bootuje.
