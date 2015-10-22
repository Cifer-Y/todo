defmodule TodoTest do
  use ExUnit.Case
  # doctest Todo.List

  test "new todo list empty" do
    assert Todo.List.new |> inspect == "%Todo.List{auto_id: 1, entries: #HashDict<[]>}"
  end

  test "add one entry" do
    todo_list = Todo.List.new
    add_one = todo_list |> Todo.List.add_entry(%{date: {2013, 3, 3}, title: "333"}) |> inspect
    assert add_one == "%Todo.List{auto_id: 2, entries: #HashDict<[{1, %{date: {2013, 3, 3}, id: 1, title: \"333\"}}]>}"
  end

  test "add entry list" do
    todo_list = Todo.List.new([%{date: {2013, 3, 3}, title: "333"}, %{date: {2013, 3, 3}, title: "444"}])
    result = todo_list |> Todo.List.entries({2013, 3, 3})
    assert result == ["444", "333"]
  end

  test "query an entry" do
    todo_list = Todo.List.new
    |> Todo.List.add_entry(%{date: {2013, 3, 3}, title: "333"})
    |> Todo.List.add_entry(%{date: {2013, 3, 3}, title: "444"})
    result = todo_list |> Todo.List.entries({2013, 3, 3})
    assert result == ["444","333"]
  end

  test "update an entry" do
    todo_list = Todo.List.new
    |> Todo.List.add_entry(%{date: {2013, 3, 3}, title: "333"})
    |> Todo.List.add_entry(%{date: {2013, 3, 3}, title: "444"})
    updated_entry = todo_list |> Todo.List.update_entry(1, fn(entry) -> %{entry | title: entry.title <> "4"}  end)
    result = updated_entry |> Todo.List.entries({2013, 3, 3})
    assert result == ["444", "3334"]
  end

  test "update an entry with a new entry" do
    todo_list = Todo.List.new
    |> Todo.List.add_entry(%{date: {2013, 3, 3}, title: "333"})
    |> Todo.List.add_entry(%{date: {2013, 3, 3}, title: "444"})
    updated = todo_list |> Todo.List.update_entry(%{id: 1, date: {2013,3,3}, title: "555"})
    result = updated |> Todo.List.entries({2013, 3, 3})
    assert result == ["444", "555"]
  end

  test "delete an entry" do
    todo_list = Todo.List.new
    |> Todo.List.add_entry(%{date: {2013, 3, 3}, title: "333"})
    |> Todo.List.add_entry(%{date: {2013, 3, 3}, title: "444"})
    deleted = todo_list |> Todo.List.delete_entry(1)
    result = deleted |> Todo.List.entries({2013, 3, 3})
    assert result == ["444"]
  end
end
