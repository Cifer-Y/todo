defmodule Todo.Server do
  use GenServer

  # Interface API
  def start(name) do
    {:ok, server_pid} = GenServer.start(__MODULE__, name)
    server_pid
  end

  def add_entry(server_pid, entry) do
    GenServer.cast(server_pid, {:add_entry, entry})
  end

  def entries(server_pid, date) do
    GenServer.call(server_pid, {:entries, date})
  end

  # GenServer code
  def init(name) do
    {:ok, {name, Todo.Database.get(name) || Todo.List.new}}
  end

  def handle_cast({:add_entry, entry}, {name, todo_list}) do
    new_state = Todo.List.add_entry(todo_list, entry)
    Todo.Database.store(name, new_state)
    {:noreply, {name, new_state}}
  end

  def handle_call({:entries, date}, _caller, {name, todo_list}) do
    {:reply, Todo.List.entries(todo_list, date), {name, todo_list}}
  end
end
