defmodule MarsRoverTest do
  use ExUnit.Case
  doctest MarsRover

  test "new creates a gen server and returns a pid" do
    rover = MarsRover.new(3, 3, :N)

    assert is_pid(rover)
  end

  test "coordinates returns the current coordinates" do
    rover = MarsRover.new(3, 3, :N)

    assert {3, 3} == MarsRover.coordinates(rover)
  end

  describe "when facing north" do
    test "moving forward when facing north increases x" do
      rover = MarsRover.new(3, 3, :N)

      MarsRover.move(rover, "f")

      assert {3, 4} == MarsRover.coordinates(rover)
    end

    test "moving too far forward when facing north moves to the south side" do
      rover = MarsRover.new(3, 5, :N)

      MarsRover.move(rover, "f")

      assert {3, 1} == MarsRover.coordinates(rover)
    end

    test "moving backwards when facing north decreases x" do
      rover = MarsRover.new(3, 3, :N)

      MarsRover.move(rover, "b")

      assert {3, 2} == MarsRover.coordinates(rover)
    end

    test "moving too far backward when facing north moves to the north side" do
      rover = MarsRover.new(3, 1, :N)

      MarsRover.move(rover, "b")

      assert {3, 5} == MarsRover.coordinates(rover)
    end

    test "turning left when facing north changes the direction to west" do
      rover = MarsRover.new(3, 3, :N)

      MarsRover.move(rover, "l")

      assert :W == MarsRover.direction(rover)
    end

    test "turning right when facing north changes the direction to east" do
      rover = MarsRover.new(3, 3, :N)

      MarsRover.move(rover, "r")

      assert :E == MarsRover.direction(rover)
    end
  end

  describe "when facing east" do
    test "moving forward when facing east increases x" do
      rover = MarsRover.new(3, 3, :E)

      MarsRover.move(rover, "f")

      assert {4, 3} == MarsRover.coordinates(rover)
    end

    test "moving too far forward when facing east moves to the west side" do
      rover = MarsRover.new(5, 3, :E)

      MarsRover.move(rover, "f")

      assert {1, 3} == MarsRover.coordinates(rover)
    end

    test "moving backwards when facing east decreases x" do
      rover = MarsRover.new(3, 3, :E)

      MarsRover.move(rover, "b")

      assert {2, 3} == MarsRover.coordinates(rover)
    end

    test "moving too far backward when facing east moves to the east side" do
      rover = MarsRover.new(1, 3, :E)

      MarsRover.move(rover, "b")

      assert {5, 3} == MarsRover.coordinates(rover)
    end

    test "turning left when facing east changes the direction to north" do
      rover = MarsRover.new(3, 3, :E)

      MarsRover.move(rover, "l")

      assert :N == MarsRover.direction(rover)
    end

    test "turning right when facing east changes the direction to south" do
      rover = MarsRover.new(3, 3, :E)

      MarsRover.move(rover, "r")

      assert :S == MarsRover.direction(rover)
    end
  end

  describe "when facing south" do
    test "moving forward when facing south decreases y" do
      rover = MarsRover.new(3, 3, :S)

      MarsRover.move(rover, "f")

      assert {3, 2} == MarsRover.coordinates(rover)
    end

    test "moving too far forward when facing south moves to the north" do
      rover = MarsRover.new(3, 1, :S)

      MarsRover.move(rover, "f")

      assert {3, 5} == MarsRover.coordinates(rover)
    end

    test "moving backwards when facing south increases y" do
      rover = MarsRover.new(3, 3, :S)

      MarsRover.move(rover, "b")

      assert {3, 4} == MarsRover.coordinates(rover)
    end

    test "moving too far backward when facing south moves to the south" do
      rover = MarsRover.new(3, 5, :S)

      MarsRover.move(rover, "b")

      assert {3, 1} == MarsRover.coordinates(rover)
    end

    test "turning left when facing south changes the direction to east" do
      rover = MarsRover.new(3, 3, :S)

      MarsRover.move(rover, "l")

      assert :E == MarsRover.direction(rover)
    end

    test "turning right when facing south changes the direction to west" do
      rover = MarsRover.new(3, 3, :S)

      MarsRover.move(rover, "r")

      assert :W == MarsRover.direction(rover)
    end
  end

  describe "when facing west" do
    test "moving forward when facing west decreases x" do
      rover = MarsRover.new(3, 3, :W)

      MarsRover.move(rover, "f")

      assert {2, 3} == MarsRover.coordinates(rover)
    end

    test "moving too far forward when facing west moves to the east side" do
      rover = MarsRover.new(1, 3, :W)

      MarsRover.move(rover, "f")

      assert {5, 3} == MarsRover.coordinates(rover)
    end

    test "moving backwards when facing west increases x" do
      rover = MarsRover.new(3, 3, :W)

      MarsRover.move(rover, "b")

      assert {4, 3} == MarsRover.coordinates(rover)
    end

    test "moving too far backward when facing west moves to the west side" do
      rover = MarsRover.new(5, 3, :W)

      MarsRover.move(rover, "b")

      assert {1, 3} == MarsRover.coordinates(rover)
    end

    test "turning left when facing west changes the direction to south" do
      rover = MarsRover.new(3, 3, :W)

      MarsRover.move(rover, "l")

      assert :S == MarsRover.direction(rover)
    end

    test "turning right when facing west changes the direction to north" do
      rover = MarsRover.new(3, 3, :W)

      MarsRover.move(rover, "r")

      assert :N == MarsRover.direction(rover)
    end
  end
end
