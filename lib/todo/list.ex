defmodule Todo.List do
  @doc """
  build a new empty todo list

      iex> Todo.List.new
      #HashDict<[]>
  """
  def new, do: HashDict.new

  @doc """
  add an entry to todo list

      iex> Todo.List.new |> Todo.List.add_entry(%{date: {2013, 3, 3}, title: "333"})
      #HashDict<[{{2013, 3, 3}, ["333"]}]>
  """
  def add_entry(list, %{date: date, title: title}) do
    HashDict.update(
      list,
      date,
      [title],
      fn(titles) -> [title | titles] end
    )
  end

  @doc """
  get entry with date

      iex> todo_list = Todo.List.new |> Todo.List.add_entry(%{date: {2013, 3, 3}, title: "333"})
      ...> todo_list = todo_list |> Todo.List.add_entry(%{date: {2013, 3, 3}, title: "444"})
      ...> Todo.List.entries(todo_list, {2013, 3, 3})
      ["333", "444"]
      ...> Todo.List.entries(todo_list, {2013, 3, 4})
      []
  """
  def entries(list, date) do
    HashDict.get(list, date, [])
    "hello"
  end
end
