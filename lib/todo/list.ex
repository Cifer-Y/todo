defmodule Todo.List do
  defstruct auto_id: 1, entries: HashDict.new

  def new, do: %__MODULE__{}
  def new(entries) do
    Enum.reduce(
      entries,
      %__MODULE__{},
      fn(entry, acc) ->
        acc |> add_entry(entry)
      end
    )
  end

  def add_entry(
        %__MODULE__{auto_id: auto_id, entries: entries} = todo_list,
        entry
      ) do
    entry = Map.put(entry, :id, auto_id)
    new_entries = HashDict.put(entries, auto_id, entry)
    %__MODULE__{todo_list | entries: new_entries, auto_id: auto_id + 1}
  end

  def entries(%__MODULE__{entries: entries}, date) do
    entries
    |> Enum.filter(fn({_, entry}) -> entry.date == date end)
    |> Enum.map(fn({_, entry}) -> entry.title end)
  end

  def update_entry(%__MODULE__{entries: entries} = todo_list, entry_id, update_fn) do
    case entries[entry_id] do
      nil -> todo_list
      old_entry ->
        old_id = old_entry.id
        new_entry = %{id: ^old_id} = update_fn.(old_entry)
        new_entries = HashDict.put(entries, old_entry.id, new_entry)
        %__MODULE__{todo_list | entries: new_entries}
    end
  end
  def update_entry(todo_list, %{} = new_entry) do
    update_entry(todo_list, new_entry.id, fn(_) -> new_entry end)
  end

  def delete_entry(todo_list, id) do
    %__MODULE__{todo_list | entries: HashDict.delete(todo_list.entries, id)}
  end
end
