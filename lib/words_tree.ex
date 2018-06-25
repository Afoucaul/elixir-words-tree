defmodule WordsTree do
  alias GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(WordsTree.Server, :ok, opts)
  end

  def insert(server, word) do
    GenServer.cast(server, {:insert, word})
  end

  def search(server, prefix) do
    GenServer.call(server, {:search, prefix})
  end
end


defmodule WordsTree.Server do
  def init(:ok) do
    {:ok, [{}]}
  end

  def handle_call(_), do: :not_implemented

  def handle_cast({:insert, word}, _from, tree) do
    {:noreply, insert(tree, word)}
  end

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

  def search(roots, prefix) do
    [search_root(roots, prefix)]
    |> build_words(String.slice(prefix, 0..-2))
  end

  def search_root([], _prefix), do: nil

  def search_root([{char, _children, _is_a_word}=root | _rest], <<char>>) do
    root
  end

  def search_root([{char, children, _is_a_word} | _rest], <<char>> <> prefix) do
    search_root(children, prefix)
  end

  def search_root([{_char, _children, _is_a_word} | rest], prefix) do
    search_root(rest, prefix)
  end

  def build_words(root, prefix \\ "")

  def build_words([{char, children, is_a_word} | rest], prefix) do
    if is_a_word do
      [prefix <> <<char>> | build_words(rest, prefix)]
    else
      build_words(rest, prefix)
    end ++ build_words(children, prefix <> <<char>>)
  end

  def build_words([], _prefix), do: []
end
