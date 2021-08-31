defmodule BitFlagger do
  @moduledoc """
  A set of functions that manipulate bit flags.
  """

  use Bitwise, only_operators: true

  @doc """
  Converts an integer to a list of boolean values.

  ## Examples

  iex> parse(0b1010, 4)
  [false, true, false, true]

  """
  @spec parse(non_neg_integer, non_neg_integer) :: list(boolean)
  def parse(state, size) when is_integer(state) and is_integer(size) do
    for index <- 0..(size - 1), do: on?(state, index)
  end

  @doc """
  Checks if the flag is turned on at a specified index.

  ## Examples

  iex> on?(0b0010, 1)
  true

  iex> on?(0b0010, 3)
  false

  """
  @spec on?(non_neg_integer, non_neg_integer) :: boolean
  def on?(state, index) when is_integer(state) and is_integer(index) do
    (state >>> index &&& 0x01) == 1
  end

  @doc """
  Checks if the flag is turned off at a specified index.

  ## Examples

  iex> off?(0b0001, 1)
  true

  iex> off?(0b0001, 0)
  false

  """
  @spec off?(non_neg_integer, non_neg_integer) :: boolean
  def off?(state, index), do: !on?(state, index)

  @doc """
  Turns on the flag at a specified index.

  ## Examples

  iex> on(0b0000, 2)
  0b0100

  """
  @spec on(non_neg_integer, non_neg_integer) :: non_neg_integer
  def on(state, index) when is_integer(state) and is_integer(index) do
    state ||| 0x01 <<< index
  end

  @doc """
  Turns off the flag at a specified index.

  ## Examples

  iex> off(0b1111, 2)
  0b1011

  """
  @spec off(non_neg_integer, non_neg_integer) :: non_neg_integer
  def off(state, index) when is_integer(state) and is_integer(index) do
    state &&& ~~~(0x01 <<< index)
  end
end
