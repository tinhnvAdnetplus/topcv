defmodule TopcvWeb.Routing.Api do
  use TopcvWeb, :router
  import TopcvWeb.AccountAuth

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, html: {TopcvWeb.Layouts, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(:fetch_current_account)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  # Other scopes may use custom stacks.
  # scope "/api", TopcvWeb do
  #   pipe_through(:api)
  # end
end
