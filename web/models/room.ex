defmodule Slick.Room do
  use Slick.Web, :model

  schema "rooms" do
    field :title, :string
    field :description, :string

    #add an association between room and messages
    has_many :messages, Slick.Message

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :description])
    |> validate_format(:title, ~r/#./, message: "Must begin with #")
    |> validate_required([:title, :description])
  end
end
