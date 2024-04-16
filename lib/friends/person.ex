defmodule Friends.Person do
  use Ecto.Schema

  schema "people" do
    field(:first_name, :string)
    field(:last_name, :string)
    field(:age, :integer)
  end

  def changeset(person, params \\ %{}) do
    person
    |> Ecto.Changeset.cast(params, [:first_name, :last_name, :age])
    |> Ecto.Changeset.validate_required([:first_name, :last_name])
  end

  def insert_person(attrs) do
    changeset = changeset(%Friends.Person{}, attrs)

    case Friends.Repo.insert(changeset) do
      {:ok, person} ->
        IO.puts("Person was successfully created: #{person.first_name} #{person.last_name}")
        {:ok, person}

      {:error, changeset} ->
        IO.puts("Failed to create person. Errors: #{inspect(changeset.errors)}")
        {:error, changeset}
    end
  end
end
