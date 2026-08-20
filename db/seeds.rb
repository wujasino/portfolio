Project.delete_all
Skill.delete_all

projects = [
  {
    name: "Presora",
    tagline: "SaaS mierzący widoczność marek w odpowiedziach dużych modeli językowych",
    description: "Zaprojektowałem i zbudowałem od zera aplikację, która odpytuje równolegle " \
      "sześć modeli LLM (GPT-4o, Claude, Gemini, Perplexity, Mistral, Llama 3), normalizuje ich " \
      "odpowiedzi i przekłada na porównywalny wynik 0–100. Pełny stack: autoryzacja, panel admina, " \
      "subskrypcje przez Stripe, eksport PDF, izolacja danych na poziomie bazy (RLS).",
    stack: ["TypeScript", "React", "Vite", "Node.js", "Supabase", "PostgreSQL", "Stripe", "Anthropic API"],
    url: "https://presora.app",
    repo: "https://github.com/wujasino/presora"
  },
  {
    name: "Testy E2E z pełnym CI",
    tagline: "45 testów end-to-end w Playwright z shardingiem i mockowaniem sieci",
    description: "Zestaw testów end-to-end oparty o Page Object Model, uruchamiany w GitHub Actions " \
      "z podziałem na shardy i mockowanym ruchem sieciowym — pokrywa krytyczne ścieżki aplikacji " \
      "produkcyjnej, nie przykładowy projekt demo.",
    stack: ["Playwright", "TypeScript", "GitHub Actions", "Vitest"],
    url: nil,
    repo: "https://github.com/wujasino"
  },
  {
    name: "Automatyzacje procesów B2B",
    tagline: "Freelance — automatyzacja workflow dla klientów biznesowych",
    description: "Wdrożenia n8n i Make łączące API, webhooki i logikę biznesową klientów — od " \
      "integracji formularzy po automatyczne raportowanie i powiadomienia.",
    stack: ["n8n", "Make", "Webhooks", "REST API"],
    url: nil,
    repo: nil
  }
]

projects.each_with_index do |attrs, index|
  Project.create!(attrs.merge(position: index))
end

skills = {
  "Języki i frontend" => ["TypeScript", "JavaScript", "SQL", "React 18", "Vite", "React Router", "Tailwind", "shadcn/ui", "TanStack Query"],
  "Backend i dane" => ["Node.js", "REST API", "Netlify Functions", "Webhooki", "Supabase", "PostgreSQL", "pgvector", "RLS"],
  "Bezpieczeństwo" => ["JWT", "OAuth", "OTP", "2FA", "CSP", "HSTS", "SPF/DKIM/DMARC", "SSL"],
  "Testy i CI" => ["Playwright", "Vitest", "Testing Library", "GitHub Actions", "CodeQL", "Dependabot"],
  "AI i automatyzacja" => ["Anthropic API", "Claude Code", "n8n", "Make"],
  "Deploy" => ["Netlify", "Vercel", "Git"]
}

skills.each do |category, items|
  items.each_with_index do |name, index|
    Skill.create!(category: category, name: name, position: index)
  end
end

puts "Seeded #{Project.count} projects and #{Skill.count} skills."
