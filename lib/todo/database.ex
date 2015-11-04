defmodule Todo.Database do
  use GenServer

  def start(db_folder) do
    GenServer.start(__MODULE__, db_folder, name: :database)
  end

  def store(key, value) do
    GenServer.cast(:database, {:store, key, value})
  end

  def get(key) do
    GenServer.call(:database,  {:get, key})
  end

  # GenServer callbacks
  def init(db_folder) do
    File.mkdir_p(db_folder)
    {:ok, db_folder}
  end

  def handle_cast({:store, key, value}, db_folder) do
    data = value |> :erlang.term_to_binary
    "#{db_folder}/#{key}" |> File.write(data)
    {:noreply, db_folder}
  end

  def handle_call({:get, key}, _caller, db_folder) do
    data =
      case File.read("#{db_folder}/#{key}") do
        {:ok, contents} ->
          :erlang.binary_to_term(contents)
        _ -> nil
      end
    {:reply, data, db_folder}
  end
end
