defmodule TimeManager.UserManagerTest do
  use TimeManager.DataCase

  alias TimeManager.UserManager

  describe "users" do
    alias TimeManager.UserManager.User

    import TimeManager.UserManagerFixtures

    @invalid_attrs %{}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert UserManager.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert UserManager.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{}

      assert {:ok, %User{} = user} = UserManager.create_user(valid_attrs)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserManager.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{}

      assert {:ok, %User{} = user} = UserManager.update_user(user, update_attrs)
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = UserManager.update_user(user, @invalid_attrs)
      assert user == UserManager.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = UserManager.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> UserManager.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = UserManager.change_user(user)
    end
  end
end
