defmodule FumigateWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use FumigateWeb, :controller
      use FumigateWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: FumigateWeb

      import Plug.Conn
      import FumigateWeb.Gettext
      alias FumigateWeb.Router.Helpers, as: Routes
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/fumigate_web/templates",
        namespace: FumigateWeb

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 1, get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import FumigateWeb.ErrorHelpers
      import FumigateWeb.ViewHelpers
      import FumigateWeb.Gettext
      alias FumigateWeb.Router.Helpers, as: Routes
      import Scrivener.HTML
      import FumigateWeb.ViewPerfumeHelpers
    end
  end

  def view_perfume do
    quote do

      use Phoenix.HTML

      import FumigateWeb.Gettext
      alias FumigateWeb.Router.Helpers, as: Routes
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import FumigateWeb.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
