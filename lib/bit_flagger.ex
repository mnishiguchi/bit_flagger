defmodule BitFlagger do
  @moduledoc """
  A set of functions that manipulate bit flags.
  """

  use Bitwise, only_operators: true

  @type state :: non_neg_integer | binary
  @type index :: non_neg_integer

  @doc """
  Converts state to a list of boolean values.

  ## Examples

      iex> parse(0b1010, 4)
      [false, true, false, true]

      iex> parse(<<0b1010>>, 4)
      [false, true, false, true]

  """
  @spec parse(state, pos_integer) :: list(boolean)
  def parse(state, size) when (is_integer(state) or is_binary(state)) and is_integer(size) do
    for index <- 0..(size - 1), do: on?(state, index)
  end

  @doc """
  Checks if the flag is turned on at a specified index.

  ## Examples

      iex> on?(0b0010, 1)
      true

      iex> on?(0b0010, 3)
      false

      iex> on?(<<0b0010>>, 1)
      true

      iex> on?(<<0b0010>>, 3)
      false

  """
  @spec on?(state, index) :: boolean
  def on?(state, index) when is_integer(state) and is_integer(index) do
    (state >>> index &&& 0x01) == 1
  end

  def on?(state, index) when is_binary(state) do
    state
    |> :binary.decode_unsigned()
    |> on?(index)
  end

  @doc """
  Checks if the flag is turned off at a specified index.

  ## Examples

      iex> off?(0b0001, 1)
      true

      iex> off?(0b0001, 0)
      false

      iex> off?(<<0b0001>>, 1)
      true

      iex> off?(<<0b0001>>, 0)
      false

  """
  @spec off?(state, index) :: boolean
  def off?(state, index), do: !on?(state, index)

  @doc """
  Turns on the flag at a specified index.

  ## Examples

      iex> on(0b0000, 2)
      0b0100

      iex> on(<<0b0000>>, 2)
      <<0b0100>>

  """
  @spec on(state, index) :: state
  def on(state, index) when is_integer(state) and is_integer(index) do
    state ||| 0x01 <<< index
  end

  def on(state, index) when is_binary(state) do
    state
    |> :binary.decode_unsigned()
    |> on(index)
    |> :binary.encode_unsigned()
  end

  @doc """
  Turns off the flag at a specified index.

  ## Examples

      iex> off(0b1111, 2)
      0b1011

      iex> off(<<0b1111>>, 2)
      <<0b1011>>

  """
  @spec off(state, index) :: state
  def off(state, index) when is_integer(state) and is_integer(index) do
    state &&& ~~~(0x01 <<< index)
  end

  def off(state, index) when is_binary(state) do
    state
    |> :binary.decode_unsigned()
    |> off(index)
    |> :binary.encode_unsigned()
  end
end
