defmodule ChatVueWeb.PageController do
  use ChatVueWeb, :controller

  @elastic_url "https://4c5d5f97cdaa422191a5023d7c6a65ae.us-east-1.aws.found.io:9243"
  # @client_id Application.get_env(:fluxo_ideal, :client_id)
  # @client_secret Application.get_env(:fluxo_ideal, :client_secret)

  def index(conn, params) do

    type = params["aula"] <>"/"<> params["professor"]

    school_type = post()


    school_type = Enum.map(school_type,fn item ->
      new_item = item["_source"]

      if new_item["school_subject"] == type do
         %{
          body: new_item["message"],
          name:  new_item["name"],
          school_subject: new_item["school_subject"],
          time: transform_date(new_item["time"]),
          prof_bool: new_item["prof"],
          remetent_prof: new_item["remetent_prof"]
          }
      end
    end)
    |> Enum.reject( fn item -> item == nil end)


    message = Enum.map(school_type, fn item ->
        if item.prof_bool == false, do: item
    end)
    |> Enum.reject( fn item -> item == nil end)


    message_prof = Enum.map(school_type, fn item ->
      if item.prof_bool == true, do: item
    end)
    |> Enum.reject( fn item -> item == nil end)

    IO.inspect(trat(message))
    IO.inspect(trat(message_prof))

    # :timer.sleep(100_0 00)
    render(conn, "index.html",  %{messages: message,message_prof: message_prof })
  end

  def choice(conn, %{"class" => %{"choice_channel" => channel} }) do
    channel |> IO.inspect()


    message = []

    render(conn, "index.html", %{messages: message})
  end

  def post() do
    case HTTPoison.get(@elastic_url <> "/comments-class/_search?size=10000", [{"Content-Type", "application/json"} ,{"Authorization", "Basic ZWxhc3RpYzpZMnd6YmZrUE9JMzRTek9Ea29sN2t3NDY="}] ) do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        body = body|> Jason.decode!
        body["hits"]["hits"]

      {:ok, %HTTPoison.Response{body: body, status_code: 201}} ->
        body

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not Found :(")
        []

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end

  end

  def trat(item) do
    if item == nil, do: [],else: item
  end

  def transform_date(time) do

    time
    |> NaiveDateTime.from_iso8601!
    |> format_date("{WDfull} {D} {Mfull} {YYYY} {h24}:{0m}:{0s}")
    |> translate_datetime()
  end

  defp translate_datetime(val) do

    date = String.split(val)

    [el1, el2, el3, el4, el5] = date


    # el1 = Timex.Translator.translate("pt", "weekdays", el1)
    el3 = Timex.Translator.translate("pt", "months", el3)

    "#{el2} #{el3} #{el4}"

  end


  def format_date(
        naive_date,
        format \\ "{YYYY}-{M}-{D} {h24}:{m}:{s}",
        to_timestamp \\ "America/Sao_Paulo",
        original_timestamp \\ "America/Sao_Paulo"
      ) do
    new_date =
      Timex.Timezone.convert(Timex.to_datetime(naive_date, original_timestamp), to_timestamp)

    {:ok, date} = Timex.format(new_date, format)
    date
  end


end
