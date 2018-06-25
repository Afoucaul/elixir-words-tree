defmodule WordsTree.GenServerTest do
  use ExUnit.Case, async: false
  doctest WordsTree

  alias WordsTree

  setup do
    server = WordsTree.create
    %{
      server: server
    }
  end

  test "tree insertion", %{server: server} do
    words = ["a", "b", "ab"]

    words
    |> Enum.map(&(WordsTree.insert(server, &1)))

    WordsTree.get_tree(server)
    |> IO.inspect
  end
end
