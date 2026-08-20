# Portfolio — Ruby on Rails

Jednostronicowe portfolio zbudowane w Ruby on Rails 7 (Propshaft + Importmap,
bez bazy danych). Sekcje: Hero, Projekty, Stack techniczny, Kontakt.

## Uruchomienie lokalnie

Wymagany Ruby >= 3.1 i Bundler.

```bash
bundle install
bin/rails server
```

Aplikacja wystartuje na `http://localhost:3000`.

## Struktura

- `app/controllers/portfolio_controller.rb` — dane o projektach i stacku (edytuj tutaj)
- `app/views/portfolio/index.html.erb` — treść strony
- `app/assets/stylesheets/application.css` — style (dark theme, bez frameworka CSS)

## Deploy

Aplikacja jest gotowa pod dowolny hosting Rails (Render, Fly.io, Railway, Heroku).
Zawiera `Procfile` i wymusza SSL w produkcji (`config/environments/production.rb`).

Przykład (Render / Railway): ustaw komendę startową `bin/rails server -p $PORT`.

## CI

`.github/workflows/ci.yml` weryfikuje przy każdym pushu, że aplikacja się bootuje.
