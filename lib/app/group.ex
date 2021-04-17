defmodule App.Group do
  use Ecto.Schema

  schema "group" do
    field(:group_id, :integer)
    # :string
    field(:title)
    field(:options, :map)
  end
end
