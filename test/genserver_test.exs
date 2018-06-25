defmodule WordsTree.GenServerTest do
  use ExUnit.Case, async: false
  doctest WordsTree

  alias WordsTree

  setup do
    server = WordsTree.create
    words = ["a", "b", "ab"]
    tree = [{?a, [{?b, [], true}], true}, {?b, [], true}]
    %{
      server: server,
      words: words,
      tree: tree
    }
  end

  test "tree insertion", %{server: server, words: words, tree: tree} do
    words
    |> Enum.map(&(WordsTree.insert(server, &1)))

    assert WordsTree.get_tree(server) == tree
  end

  test "blocking insertion of a words list", %{server: server, words: words, tree: tree} do
    WordsTree.blocking_insert(server, words)
    assert WordsTree.get_tree(server) == tree
  end
end
