defmodule AccountingSystemWeb.Router do
  use AccountingSystemWeb, :router
  # import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    # plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AccountingSystemWeb do
    pipe_through :browser

    get "/", ListConfigurationController, :index
    get "/home", HomeController, :index
    get "/account", AccountController, :index_fake
    get "/actives", ActivesController, :index
    get "/fiscals", FiscalsController, :index
    get "/reports", ReportsController, :index
    get "/subaccounts", SubAccountsController, :index
    get "/formaccount", FormAccountController, :index
    get "/configuration", ConfigurationController, :index
    get "/listconfiguration", ListConfigurationController, :index
    get "/download_template", DownloadController, :index
    get "/show_xml/:xml_id/:xml_name", ShowXmlController, :show
    get "/periods", PeriodController, :index
    get "/auxiliaries", AuxiliariesController, :index
    get "/form_auxiliaries", FormAuxiliariesController, :index
    # get "/submenu", SubMenuController, :sub_menu
    resources "/accounts", AccountController
    resources "/structures", StructureController
    get "/accounts/:id/new", AccountController, :new
    resources "/auxiliaries", AuxiliaryController
    resources "/policies", PolicyController
    resources "/providers", ProviderController
    resources "/thirdpartyoperations", ThirdPartyOperationController
    resources "/policytypes", PolicyTypeController
    resources "/series", SeriesController
    resources "/policylist", PoliciesController
    resources "/balance", BalanceController
  end

  # Other scopes may use custom stacks.
  # scope "/api", AccountingSystemWeb do
  #   pipe_through :api
  # end
end
