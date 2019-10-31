defmodule Etypes do
  @moduledoc """
  Demo for Etypes project.
  For `test.sh` to work, make sure to label your bugs with comment `# bug`.
  """

  alias Etypes.Types, as: T

  @spec brokenByDesign(t) :: T.comaybe(t) when t: any()
  def brokenByDesign(_x), do: "Dialyzer doesn't do type inference!"

  # bug
  @spec brokenMaybe(t) :: T.comaybe(t) when t: non_neg_integer()
  def brokenMaybe(_x), do: "We should be as specific as possible!"

  # bug
  @spec brokenArgument(t) :: T.comaybe(t) when t: non_neg_integer()
  def brokenArgument(x), do: x

  @spec green(t) :: T.comaybe(t) when t: non_neg_integer()
  def green(x) do
    case x do
      42 -> {:error, "Does not compute"}
      _  -> x
    end
  end

  # bug
  @spec hello() :: T.comaybe(t) when t: non_neg_integer()
  def hello() do
    brokenByDesign(1)
    brokenMaybe(2)
    brokenArgument(-3)
    green(4)
    green(42)
  end

end
