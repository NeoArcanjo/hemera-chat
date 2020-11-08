defmodule ChatVueWeb.PageController do
  use ChatVueWeb, :controller

  def index(conn, _params) do

    message = []

    render(conn, "index.html",  %{messages: message})
  end

  def choice(conn, %{"class" => %{"choice_channel" => channel} }) do
    channel |> IO.inspect()

    IO.puts "mane asdasdsadjsadjasjdioasdiajsdojasdoasdjoasj"
    # :timer.sleep(10_000)

    message = []

    render(conn, "index.html", %{messages: message})
  end
end
