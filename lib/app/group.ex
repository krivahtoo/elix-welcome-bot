defmodule App.Group do
  use Ecto.Schema

  schema "group" do
    field :group_id,  :integer
    field :title    # :string
    field :options,   :map
  end
end
