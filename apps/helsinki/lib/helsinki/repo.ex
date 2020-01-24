defmodule AccountingSystem.Repo do
  use Ecto.Repo,
    otp_app: :helsinki,
    adapter: Ecto.Adapters.Postgres
end
