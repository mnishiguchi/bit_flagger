defmodule BitFlaggerTest do
  use ExUnit.Case
  import BitFlagger
  doctest BitFlagger

  @days_of_week [
    :sunday,
    :monday,
    :tuesday,
    :wednesday,
    :thursday,
    :friday,
    :saturday
  ]

  # All the days of the week are 127, no day of the week is the value 0.
  test "days of week" do
    state = 0b0000000

    assert Enum.zip(@days_of_week, BitFlagger.parse(state, 7)) == [
             sunday: false,
             monday: false,
             tuesday: false,
             wednesday: false,
             thursday: false,
             friday: false,
             saturday: false
           ]

    state = BitFlagger.on(state, 0)
    state = BitFlagger.on(state, 1)
    state = BitFlagger.on(state, 3)

    assert Enum.zip(@days_of_week, BitFlagger.parse(state, 7)) == [
             sunday: true,
             monday: true,
             tuesday: false,
             wednesday: true,
             thursday: false,
             friday: false,
             saturday: false
           ]

    state = BitFlagger.off(state, 1)

    assert Enum.zip(@days_of_week, BitFlagger.parse(state, 7)) == [
             sunday: true,
             monday: false,
             tuesday: false,
             wednesday: true,
             thursday: false,
             friday: false,
             saturday: false
           ]
  end
end
