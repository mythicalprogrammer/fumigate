defmodule FumigateWeb.ViewHelpers do
  @moduledoc """
  """

  def country_name(%{country: %{name: name}}), do: name
  def country_name(_), do: "Unknown" 

  def main_activity(%{company_main_activity: %{main_activity: main_activity}}), do: main_activity 
  def main_activity(_), do: "Unknown" 
end
