defmodule Slick.Message do
  use Slick.Web, :model

  schema "messages" do
    field :body, :string
    belongs_to :room, Slick.Room

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:room_id, :body])
    |> validate_required([:room_id, :body])
  end
end
