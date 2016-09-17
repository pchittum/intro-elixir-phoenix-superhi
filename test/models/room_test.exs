defmodule Slick.RoomTest do
  use Slick.ModelCase

  alias Slick.Room

  @valid_attrs %{description: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Room.changeset(%Room{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Room.changeset(%Room{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset for hashtag in title" do
    changeset = Room.changeset(%Room{}, %{ title: "general"})
    refute changeset.valid?

    changeset = Room.changeset(%Room{}, %{ title: "#general"})
    assert changeset.valid?

    changeset = Room.changeset(%Room{}, %{ title: "#"})
    refute changeset.valid?
  end
end
