defmodule Slick.Repo.Migrations.CreateRoom do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :title, :string
      add :description, :string

      timestamps()
    end

  end
end
