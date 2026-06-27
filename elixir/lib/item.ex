defmodule Item do
  @type t :: %__MODULE__{
          name: String.t() | nil,
          sell_in: integer() | nil,
          quality: integer() | nil
        }

  defstruct name: nil, sell_in: nil, quality: nil
end
