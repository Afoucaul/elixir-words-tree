defmodule WordsTree do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(WordsTree.Server, :ok, opts)
  end

  def insert(tree, word) do
  end

  def lookup(tree, prefix) do
  end
end


defmodule WordsTree.Server do
  def init(:ok) do
    {:ok, {}}
  end

  def handle_call({:insert, word}, _from, tree) do
  end

  def handle_call(_), do: :not_implemented
  def handle_cast(_), do: :not_implemented

  def insert(roots, word)

  def insert([], <<char>>) do
    [{char, [], true}]
  end

  def insert([], <<char>> <> word) do
    [{
      char, 
      insert([], word), 
      false}]
  end

  def insert([{char, children, _is_a_word} | rest], <<char>>) do
    [{char, children, true} | rest]
  end

  def insert([{char, children, is_a_word} | rest], <<char>> <> word) do
    [
      {
        char, 
        insert(children, word), 
        is_a_word
      } 
      | rest
    ]
  end

  def insert([tree | rest], word) do
    [tree | insert(rest, word)]
  end
end
