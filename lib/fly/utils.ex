defmodule Fly.Utils do
  @moduledoc false

  @doc """
  Generates a random binary value.
  """
  require Logger
  require HTTPoison

  @spec random_value() :: binary()
  def random_value() do
    :crypto.strong_rand_bytes(20) |> Base.encode32(case: :lower)
  end

  @doc """
  Convert the data to camel case keys.
  """
  def to_camel(data) do
    # convert the keys in the args to be "camelCase" as expected by the server.
    data
    |> Recase.Enumerable.stringify_keys()
    |> Recase.Enumerable.convert_keys(&Recase.to_camel/1)
  end

  @doc """
  Stringify the keys in the data. Deeply converted.
  """
  def stringify(data) do
    Recase.Enumerable.stringify_keys(data)
  end

  @doc """
  Converts a ISO 8601 date string to a human readable format.
  """
  def readable_date(iso_8601_string) do
    DateTime.from_iso8601(iso_8601_string)
      |> case do
      {:ok, datetime, 0}  ->
        "#{DateTime.to_date(datetime)}, #{Time.truncate(DateTime.to_time(datetime), :second)}"

      {:error, :invalid_format} ->
        "Not available"
      other ->

        Logger.error("Unexpected result parsing ISO 9601 DateTime string. Result: #{inspect(other)}")
    end
  end

  @doc """
  Requests an URL and pipes the response to handler functions,
  returning the status code.
  """
  def verify_response_status_code(url) do
    try do
      HTTPoison.get(url, [], [])
        |> handle_response()
    rescue
      CaseClauseError -> "Error while requesting image URL."
    end
  end

  def handle_response({:ok, response}) do
    response.status_code
  end

  def handle_response({:error, _response}) do
    nil
  end
end
