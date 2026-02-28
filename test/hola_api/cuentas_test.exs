defmodule HolaApi.CuentasTest do
  use HolaApi.DataCase

  alias HolaApi.Cuentas

  describe "usuarios" do
    alias HolaApi.Cuentas.Usuario

    import HolaApi.CuentasFixtures

    @invalid_attrs %{username: nil, password_hash: nil}

    test "list_usuarios/0 returns all usuarios" do
      usuario = usuario_fixture()
      assert Cuentas.list_usuarios() == [usuario]
    end

    test "get_usuario!/1 returns the usuario with given id" do
      usuario = usuario_fixture()
      assert Cuentas.get_usuario!(usuario.id) == usuario
    end

    test "create_usuario/1 with valid data creates a usuario" do
      valid_attrs = %{username: "some username", password_hash: "some password_hash"}

      assert {:ok, %Usuario{} = usuario} = Cuentas.create_usuario(valid_attrs)
      assert usuario.username == "some username"
      assert usuario.password_hash == "some password_hash"
    end

    test "create_usuario/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cuentas.create_usuario(@invalid_attrs)
    end

    test "update_usuario/2 with valid data updates the usuario" do
      usuario = usuario_fixture()
      update_attrs = %{username: "some updated username", password_hash: "some updated password_hash"}

      assert {:ok, %Usuario{} = usuario} = Cuentas.update_usuario(usuario, update_attrs)
      assert usuario.username == "some updated username"
      assert usuario.password_hash == "some updated password_hash"
    end

    test "update_usuario/2 with invalid data returns error changeset" do
      usuario = usuario_fixture()
      assert {:error, %Ecto.Changeset{}} = Cuentas.update_usuario(usuario, @invalid_attrs)
      assert usuario == Cuentas.get_usuario!(usuario.id)
    end

    test "delete_usuario/1 deletes the usuario" do
      usuario = usuario_fixture()
      assert {:ok, %Usuario{}} = Cuentas.delete_usuario(usuario)
      assert_raise Ecto.NoResultsError, fn -> Cuentas.get_usuario!(usuario.id) end
    end

    test "change_usuario/1 returns a usuario changeset" do
      usuario = usuario_fixture()
      assert %Ecto.Changeset{} = Cuentas.change_usuario(usuario)
    end
  end
end
