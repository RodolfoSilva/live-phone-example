defmodule ExampleWeb.ContactLiveTest do
  use ExampleWeb.ConnCase

  import Phoenix.LiveViewTest
  import Example.ContactsFixtures

  @create_attrs %{name: "some name", phone: "+123456789"}
  @update_attrs %{name: "some updated name", phone: "+133456789"}
  @invalid_attrs %{name: nil, phone: nil}

  defp create_contact(_) do
    contact = contact_fixture()
    %{contact: contact}
  end

  describe "Index" do
    setup [:create_contact]

    test "saves new contact", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/contacts")

      index_live
      |> element("a", "New Contact")
      |> render_click()

      assert index_live
             |> form("#contact-form", contact: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#contact-form", contact: @create_attrs)
             |> render_submit()
    end

    test "updates contact in listing", %{conn: conn, contact: contact} do
      {:ok, index_live, _html} = live(conn, ~p"/contacts")

      index_live
      |> element("#contacts-#{contact.id} a", "Edit")
      |> render_click()

      assert index_live
             |> form("#contact-form", contact: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#contact-form", contact: @update_attrs)
             |> render_submit()
    end
  end
end
