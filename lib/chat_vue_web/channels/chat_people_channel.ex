defmodule ChatVueWeb.ChatPeopleChannel do
  use ChatVueWeb, :channel

  @elastic_url "https://4c5d5f97cdaa422191a5023d7c6a65ae.us-east-1.aws.found.io:9243"
  @client_id Application.get_env(:fluxo_ideal, :client_id)
  @client_secret Application.get_env(:fluxo_ideal, :client_secret)

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

    data = %{time: Timex.now("America/Sao_Paulo"),message: payload["body"], name: payload["name"], school_subject: payload["school_type"], prof: payload["prof_bool"],remetent_prof: payload["remetent_prof"]}

    # spawn(ChatVueWeb.ChatPeopleChannel, :spawn_estics,[data])
    ChatVueWeb.ChatPeopleChannel.spawn_estics(data) |> IO.inspect

    broadcast socket, "shout", payload
    {:noreply, socket}
  end


  def spawn_estics(data) do

    case HTTPoison.post(@elastic_url <> "/comments-class/_doc/", data |> Jason.encode!, [{"Content-Type", "application/json"},{"Authorization", "Basic ZWxhc3RpYzpZMnd6YmZrUE9JMzRTek9Ea29sN2t3NDY="}]) do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        body

      {:ok, %HTTPoison.Response{body: body, status_code: 201}} ->
        body

      {:ok, %HTTPoison.Response{status_code: 400}} ->
        IO.puts("Not Found :(")

      {:ok, %HTTPoison.Response{status_code: 401,body: body}} ->
        IO.puts("Not Found :(")
        body |> Jason.decode!


      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason

    end

  end

end
