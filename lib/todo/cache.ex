defmodule Todo.Cache do
  use GenServer

  # Interface API
  def start do
    GenServer.start(__MODULE__, nil, name: :cache)
  end

  def serve_process(todo_list_name) do
    GenServer.call(:cache, {:serve_process, todo_list_name})
  end

  # Genser callback
  def init(_) do
    Todo.Database.start("./presist")
    {:ok, HashDict.new}
  end

  def handle_call({:serve_process, todo_list_name}, _caller, todo_servers) do
    case todo_servers |> HashDict.fetch(todo_list_name) do
      {:ok, server_pid} ->
        {:reply, server_pid, todo_servers}
      :error ->
        new_server_pid = Todo.Server.start
        {:reply, new_server_pid, HashDict.put(todo_servers, todo_list_name, new_server_pid)}
    end
  end
end
