defmodule TopcvWeb.Routing.Admin do
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

  scope "/admin", TopcvWeb do
    pipe_through([:browser, :require_authenticated_account])

    live_session :require_authenticated_account,
      on_mount: [{TopcvWeb.AccountAuth, :ensure_authenticated}] do
      get("/", PageController, :home)
      get("/users ", PageController, :home)
    end
  end

  scope "/admin", TopcvWeb do
    pipe_through([:browser, :redirect_if_account_is_authenticated])

    live_session :redirect_if_account_is_authenticated,
      on_mount: [{TopcvWeb.AccountAuth, :redirect_if_account_is_authenticated}] do
      live("/log_in", AccountLoginLive, :new)
    end

    post("/log_in", AccountSessionController, :create)
  end

  scope "/admin", TopcvWeb do
    pipe_through([:browser])

    # delete("/admin/log_out", AccountSessionController, :delete)
  end
end
