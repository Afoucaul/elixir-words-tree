defmodule WordsTreeTest do
  use ExUnit.Case
  doctest WordsTree

  alias WordsTree.Server

  # @tag :skip
  test "basic insertion" do
    assert Server.insert([], "a") == [{?a, [], true}]
  end

  # @tag :skip
  test "insertion in a tree containing a prefix" do
    expected = [
      {
        ?a,
        [{
          ?b, 
          [], 
          true
        }],
        true
      }
    ]
    assert Server.insert([{?a, [], true}], "ab") == expected
  end

  # @tag :skip
  test "insertion in a tree not containing a prefix" do
    expected = [
      {
        ?a,
        [{
          ?b, 
          [], 
          true
        }],
        true
      },
      {?c, [], true}
    ]
    assert Server.insert([{?a, [], true}, {?c, [], true}], "ab") == expected
  end

  test "search root" do
    assert (
    []
    |> Server.insert("a")
    |> Server.insert("ab")
    |> Server.insert("b")
    |> Server.search_root("a")
    ) == {?a, [{?b, [], true}], true}
  end

  test "search words starting by prefix" do
    assert (
    []
    |> Server.insert("a")
    |> Server.insert("ab")
    |> Server.insert("b")
    |> Server.insert("abc")
    |> Server.search("a")
    ) == ["a", "ab", "abc"]
  end
end
