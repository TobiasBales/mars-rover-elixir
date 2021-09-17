defmodule MarsRover do
  use GenServer

  @impl GenServer
  def init(state) do
    {:ok, state}
  end

  @impl GenServer
  def handle_call(:coordinates, _from, {x, y, _direction} = state) do
    {:reply, {x, y}, state}
  end

  @impl GenServer
  def handle_call(:direction, _from, {_x, _y, direction} = state) do
    {:reply, direction, state}
  end

  @impl GenServer
  def handle_cast({:move, sequence}, state) do
    {:noreply, handle_moves(sequence, state)}
  end

  def new(x, y, direction) do
    {:ok, pid} = GenServer.start_link(MarsRover, {x, y, direction})
    pid
  end

  def move(pid, sequence) do
    GenServer.cast(pid, {:move, sequence})
  end

  def coordinates(pid) do
    GenServer.call(pid, :coordinates)
  end

  def direction(pid) do
    GenServer.call(pid, :direction)
  end

  defp handle_moves("", state), do: state

  # facing north
  defp handle_moves("f" <> moves, {x, y, :N}) when y == 5, do: handle_moves(moves, {x, 1, :N})
  defp handle_moves("f" <> moves, {x, y, :N}), do: handle_moves(moves, {x, y + 1, :N})

  defp handle_moves("b" <> moves, {x, y, :N}) when y == 1, do: handle_moves(moves, {x, 5, :N})
  defp handle_moves("b" <> moves, {x, y, :N}), do: handle_moves(moves, {x, y - 1, :N})

  defp handle_moves("l" <> moves, {x, y, :N}), do: handle_moves(moves, {x, y, :W})

  defp handle_moves("r" <> moves, {x, y, :N}), do: handle_moves(moves, {x, y, :E})

  # facing east
  defp handle_moves("f" <> moves, {x, y, :E}) when x == 5, do: handle_moves(moves, {1, y, :E})
  defp handle_moves("f" <> moves, {x, y, :E}), do: handle_moves(moves, {x + 1, y, :E})

  defp handle_moves("b" <> moves, {x, y, :E}) when x == 1, do: handle_moves(moves, {5, y, :E})
  defp handle_moves("b" <> moves, {x, y, :E}), do: handle_moves(moves, {x - 1, y, :E})

  defp handle_moves("l" <> moves, {x, y, :E}), do: handle_moves(moves, {x, y, :N})

  defp handle_moves("r" <> moves, {x, y, :E}), do: handle_moves(moves, {x, y, :S})

  # facing south
  defp handle_moves("f" <> moves, {x, y, :S}) when y == 1, do: handle_moves(moves, {x, 5, :S})
  defp handle_moves("f" <> moves, {x, y, :S}), do: handle_moves(moves, {x, y - 1, :S})

  defp handle_moves("b" <> moves, {x, y, :S}) when y == 5, do: handle_moves(moves, {x, 1, :S})
  defp handle_moves("b" <> moves, {x, y, :S}), do: handle_moves(moves, {x, y + 1, :S})

  defp handle_moves("l" <> moves, {x, y, :S}), do: handle_moves(moves, {x, y, :E})

  defp handle_moves("r" <> moves, {x, y, :S}), do: handle_moves(moves, {x, y, :W})

  # facing west
  defp handle_moves("f" <> moves, {x, y, :W}) when x == 1, do: handle_moves(moves, {5, y, :W})
  defp handle_moves("f" <> moves, {x, y, :W}), do: handle_moves(moves, {x - 1, y, :W})

  defp handle_moves("b" <> moves, {x, y, :W}) when x == 5, do: handle_moves(moves, {1, y, :W})
  defp handle_moves("b" <> moves, {x, y, :W}), do: handle_moves(moves, {x + 1, y, :W})

  defp handle_moves("l" <> moves, {x, y, :W}), do: handle_moves(moves, {x, y, :S})

  defp handle_moves("r" <> moves, {x, y, :W}), do: handle_moves(moves, {x, y, :N})
end
