defmodule TodoCacheTest do
  use ExUnit.Case

  test "todo cache test" do
    Todo.Cache.start
    bob_list = Todo.Cache.serve_process(:bob_list)
    Todo.Server.add_entry(bob_list, %{date: {2013, 3, 3}, title: "333"})
    result = Todo.Server.entries(bob_list, {2013, 3, 3})
    assert result == [%{date: {2013, 3, 3}, id: 1, title: "333"}]

    cifer_list = Todo.Cache.serve_process(:cifer_list)
    Todo.Server.add_entry(cifer_list, %{date: {2013, 3, 3}, title: "444"})
    result = Todo.Server.entries(cifer_list, {2013, 3, 3})
    assert result == [%{date: {2013, 3, 3}, id: 1, title: "444"}]
  end
end
