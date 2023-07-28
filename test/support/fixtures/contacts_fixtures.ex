defmodule Example.ContactsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Example.Contacts` context.
  """

  @doc """
  Generate a contact.
  """
  def contact_fixture(attrs \\ %{}) do
    {:ok, contact} =
      attrs
      |> Enum.into(%{
        name: "some name",
        phone: "+123456789"
      })
      |> Example.Contacts.create_contact()

    contact
  end
end
