# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Fumigate.Repo.insert!(%Fumigate.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Fumigate.Fragrance

for country <- [ 
  "United States",
  "France",
  "Italy",
  "United Kingdom",
  "Germany",
  "Spain",
  "Russia",
  "United Arab Emirates",
  "Switzerland",
  "Brazil",
  "Netherlands",
  "Canada",
  "Japan",
  "Australia",
  "England",
  "Sweden",
  "China",
  "Poland",
  "Greece",
  "Austria",
  "Portugal",
  "Mexico",
  "Saudi Arabia",
  "Turkey",
  "Denmark",
  "India",
  "Argentina",
  "Belgium",
  "Israel",
  "Bulgaria",
  "Ireland",
  "Korea",
  "Norway",
  "Philippines",
  "Thailand",
  "Croatia",
  "Kuwait",
  "South Africa",
  "Bahrain",
  "Egypt",
  "Monaco",
  "New Zealand",
  "Chile",
  "Czech Republic",
  "Latvia",
  "Lithuania",
  "Malaysia",
  "Morocco",
  "Oman",
  "Peru",
  "Romania",
  "Serbia",
  "Ukraine",
  "Vietnam",
  "Belarus",
  "Bermuda",
  "Cuba",
  "Finland",
  "Iran",
  "Lebanon",
  "Qatar",
  "Uzbekistan",
  "Aruba",
  "Cayman Islands",
  "Colombia",
  "Dominican Republic",
  "Ecuador",
  "Ghana",
  "Hong Kong",
  "Ibiza",
  "Iceland",
  "Indonesia",
  "Liberia",
  "Luxembourg",
  "Malta",
  "Pakistan",
  "Puerto Rico",
  "Singapore",
  "Slovakia",
  "St. Barts",
  "Tahiti",
  ] do
  Fragrance.create_country(country)
end

for company_type <- ["niche designer", "celebrity brand"] do
  Fragrance.create_company_type(company_type)
end

for main_activity <- [ "Fragrances",
                       "Cosmetics",
                       "Celebrity",
                       "Jewelry", 
                       "Design",
                       "Sport Fashion", 
                       "Fashion" 
] do
    Fragrance.create_company_main_activity(main_activity)
end

{:ok, _user} = Fumigate.Accounts.create_user(%{
    username: "writer",
    email: "writer@example.com",
    password: "easy1234",
    permissions: %{default: [:read_users, :write_users]}

})

{:ok, _user} = Fumigate.Accounts.create_user(%{
    username: "reader",
    email: "reader@example.com",
    password: "easy1234",
    permissions: %{default: [:read_users]}

})

{:ok, _user} = Fumigate.Accounts.create_user(%{
    username: "rubbish",
    email: "rubbish@example.com",
    password: "easy1234",
    permissions: %{default: []}

})

