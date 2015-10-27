defmodule Todo.Server do
  def start do
    state = Todo.List.new
    server = spawn(fn -> loop(state) end)
    Process.register server, :server
  end

  def add_entry(entry) do
    send :server, {:add_entry, entry}
  end

  def entries(date) do
    send :server, {:entries, self, date}
    receive do
      {:entries, entries} -> entries
    end
  end

  def loop(state) do
    new_state = receive do
      {:add_entry, entry} ->
        Todo.List.add_entry(state, entry)
      {:entries, caller, date} ->
        entries = Todo.List.entries(state, date)
        send caller, {:entries, entries}
        state
    end
    loop(new_state)
  end
end
