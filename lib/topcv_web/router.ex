defmodule TopcvWeb.Router do
  use TopcvWeb, :router

  forward("/api", TopcvWeb.Routing.Api)
  forward("/admin", TopcvWeb.Routing.Admin)
  forward("/", TopcvWeb.Routing.Web)
end
