defmodule TodoServerTest do
  use ExUnit.Case

  test "todo server" do
    server_pid = Todo.Server.start
    Todo.Server.add_entry(server_pid, %{date: {2013, 3, 3}, title: "333"})
    Todo.Server.add_entry(server_pid, %{date: {2013, 3, 3}, title: "444"})
    assert [] == Todo.Server.entries(server_pid, {2013, 3, 4})
    result = Todo.Server.entries(server_pid, {2013, 3, 3})
    assert result == [%{date: {2013, 3, 3}, id: 2, title: "444"}, %{date: {2013, 3, 3}, id: 1, title: "333"}]
  end
end
