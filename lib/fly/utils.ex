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
  def get_readable_date(iso8601_string)
    when is_binary(iso8601_string) or is_bitstring(iso8601_string)
    do

    DateTime.from_iso8601(iso8601_string)
      |> case do
        {:ok, datetime, 0}  ->
            output_readable_date(datetime)

        {:error, :invalid_format} ->
          "Not available"

        other ->
          Logger.error("Unexpected result parsing ISO 9601 DateTime string. Result: #{inspect(other)}")

          "Not available"
      end
  end

  def get_readable_date(_iso8601_string) do
    "Not available"
  end

  @doc """
  Converts a DateTime struct to a human readable format.
  """
  def output_readable_date(datetime) do
    try do
      date = DateTime.to_date(datetime)
      time = DateTime.to_time(datetime)
      output_string = "#{date}, #{Time.truncate(time, :second)}"

      output_string
    rescue
      FunctionClauseError ->
        Logger.error("Unexpected result while generating string from ISO 9601 DateTime. Used DateTime: #{datetime}")

        "Not available"
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
