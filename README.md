# BitFlagger

Manipulate bit flags.

## Usage

```elixir
# Let's say we want to remember certain days of week as a single integer
iex> days_of_week = [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]

# The number of bit flags
iex> size = 7

# All the days of the week are 127, no day of the week is the value 0
iex> state = 0b0000000
0

iex> BitFlagger.parse(state, size)
[false, false, false, false, false, false, false]

# Turn on the flags at index 1 (Monday) and 3 (Wednesday)
iex> state = state |> BitFlagger.on(1) |> BitFlagger.on(3)
10

iex> BitFlagger.parse(state, size)
[false, true, false, true, false, false, false]

# Turn off the flag at index 1 (Monday)
iex> state = BitFlagger.off(state, 1)
8

iex> BitFlagger.parse(state, size)
[false, false, false, true, false, false, false]

# We can easily make it human readable
iex> Enum.zip(days_of_week, BitFlagger.parse(state, size))
[
  sunday: false,
  monday: false,
  tuesday: false,
  wednesday: true,
  thursday: false,
  friday: false,
  saturday: false
]
```

## Installation

Add `bit_flagger` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:bit_flagger, "~> 0.1.0"}
  ]
end
```

Documentation can be found at [https://hexdocs.pm/bit_flagger](https://hexdocs.pm/bit_flagger).
