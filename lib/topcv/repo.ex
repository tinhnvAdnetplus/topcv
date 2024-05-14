defmodule Topcv.Repo do
  use Ecto.Repo,
    otp_app: :topcv,
    adapter: Ecto.Adapters.Postgres
end
