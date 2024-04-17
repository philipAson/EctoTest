defmodule Friends.Person do
  require Ecto.Query
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

  def get_person(name) do
    person = Friends.Person |> Ecto.Query.where(first_name: ^name)
    IO.inspect(person)
  end

  def update_first_age do
    person = Friends.Person |> Ecto.Query.first |> Friends.Repo.one
    IO.puts("Updating #{person.first_name}'s age to 29, he was #{person.age} years old")
    changeset  = Friends.Person.changeset(person, %{first_name: ""})
    Friends.Repo.update(changeset)
  end

  def get_all_people do
    Friends.Person |> Friends.Repo.all
  end

  def delete_person(id) do
    person = Friends.Repo.get(Friends.Person, id)
    IO.puts("Deleting #{person.first_name} #{person.last_name}")
    Friends.Repo.delete(person)
  end
end
