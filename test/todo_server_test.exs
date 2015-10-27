defmodule TodoServerTest do
  use ExUnit.Case

  test "todo server" do
    Todo.Server.start
    Todo.Server.add_entry(%{date: {2013, 3, 3}, title: "333"})
    Todo.Server.add_entry(%{date: {2013, 3, 3}, title: "444"})
    assert [] == Todo.Server.entries({2013, 3, 4})
    assert ["444", "333"] == Todo.Server.entries({2013, 3, 3})
  end
end
