defmodule TodoDatabaseTest do
  use ExUnit.Case

  test "todo database" do
    Todo.Database.start("./presist")
    Todo.Database.store("database_test", :database_test)
    assert :database_test == Todo.Database.get("database_test")
  end
end
