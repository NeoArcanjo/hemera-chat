defmodule ChatVueWeb.ChatPeopleChannel do
  use ChatVueWeb, :channel

  @elastic_url "http://localhost:9200"

  @impl true
  def join("chat_people:lobby", payload, socket) do
    IO.puts "Mané brabo demais"
    {:ok, socket}

  end



  def join("chat_people:" <> channel, payload, socket) do
    IO.puts "somente apenas"
    {:ok, socket}

  end


  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (chat_people:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    HTTPoison.start()

    data = %{time: Timex.now("America/Sao_Paulo"),message: payload["body"], name: payload["name"], school_subject: payload["school_type"]}

    IO.inspect(payload)
    IO.puts "ihulllllll"

    case HTTPoison.post(@elastic_url <> "/comments-class/_doc/", data |> Jason.encode!, [{"Content-Type", "application/json"}]) do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        body

      {:ok, %HTTPoison.Response{body: body, status_code: 201}} ->
        body

      {:error, %HTTPoison.Response{status_code: 400}} ->
        IO.puts("Not Found :(")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason

    end


    broadcast socket, "shout", payload
    {:noreply, socket}
  end


end


# PUT comments-class
# PUT comments-class/_mapping
# {
#   "properties": {
#     "school_subject": {"type": "text","fielddata": true},
#     "message": {"type": "text"},
#     "time": {"type": "text", "fielddata": true},
#     "name": {"type": "text"}
#   }
# }
