defmodule Parallel do
  def pmap(collection, fun) do
    collection
    |> Enum.map(fn (elem) ->
      Task.async fn -> fun.(elem) end end)
    |> Enum.map(fn (task) ->
      Task.await task
    end)
  end
end

result = Parallel.pmap((0..10), fn(x) -> x * x end)

IO.inspect(result)