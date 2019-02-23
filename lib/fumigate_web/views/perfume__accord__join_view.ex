defmodule FumigateWeb.Perfume_Accord_JoinView do
  use FumigateWeb, :view

  def accord_select_options(accords) do
    for accord <- accords, do: {accord.accord_name, accord.id}
  end

  def perfume_select_options(perfumes) do
    for perfume <- perfumes, do: {perfume.perfume_name, perfume.id}
  end
end
