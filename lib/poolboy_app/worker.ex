defmodule PoolboyApp.Worker do
  use GenServer
  require Logger

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_) do
    Logger.debug("Starting worker #{inspect(self())}...")
    {:ok, nil}
  end

  def handle_call({:square_root, x}, _from, state) do
    start = start_time()
    Process.sleep(1000)
#    if rem(x, 2) == 0 do
      sqrt = :math.sqrt(x)

      Logger.info(
        "process #{inspect(self())} calculate square root of #{x} = #{sqrt} in #{duration_time(start)}ms..."
      )

      {:reply, sqrt, state}
#    else
#      {:stop, :odd_number, state}
#    end
  end

  #
  #  def terminate(:odd_number, state) do
  #    Logger.warning(
  #      "Terminating worker #{inspect(self())} - reason: #{inspect(reason)}, state: #{inspect(state)}"
  #    )
  #  end

  defp start_time(), do: System.monotonic_time()

  defp duration_time(start),
    do: (System.monotonic_time() - start) |> monotonic_time_to_milliseconds()

  defp monotonic_time_to_milliseconds(monotonic_time) do
    monotonic_time |> System.convert_time_unit(:native, :millisecond)
  end
end
