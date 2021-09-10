defmodule Fly.Utils do
  @moduledoc false

  @doc """
  Generates a random binary value.
  """
  require Logger

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
    {:ok, datetime, 0} = DateTime.from_iso8601(iso_8601_string)
    "#{datetime.month}-#{datetime.day}-#{datetime.year} #{datetime.hour}:#{datetime.minute}"
  end
end
