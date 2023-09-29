defmodule PoolboyApp.Test do
  @timeout 3000

  def start() do
    1..20
    |> Enum.map(&async_call_square_root(&1))
    |> Task.await_many(:infinity)

    #    |> Enum.each(&await_and_inspect(&1))
  end

  defp async_call_square_root(i) do
    Task.async(fn ->
      :poolboy.transaction(
        :worker,
        &GenServer.call(&1, {:square_root, i})
      )
    end)
  end

  defp await_and_inspect(task), do: task |> Task.await() |> IO.inspect()
end
