defmodule TimeManagerAPI.TimeManagerDataTest do
  use TimeManagerAPI.DataCase

  alias TimeManagerAPI.TimeManagerData

  describe "users" do
    alias TimeManagerAPI.TimeManagerData.User

    import TimeManagerAPI.TimeManagerDataFixtures

    @invalid_attrs %{email: nil, name: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert TimeManagerData.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert TimeManagerData.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{email: "some email", name: "some name"}

      assert {:ok, %User{} = user} = TimeManagerData.create_user(valid_attrs)
      assert user.email == "some email"
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TimeManagerData.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{email: "some updated email", name: "some updated name"}

      assert {:ok, %User{} = user} = TimeManagerData.update_user(user, update_attrs)
      assert user.email == "some updated email"
      assert user.name == "some updated name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = TimeManagerData.update_user(user, @invalid_attrs)
      assert user == TimeManagerData.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = TimeManagerData.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> TimeManagerData.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = TimeManagerData.change_user(user)
    end
  end

  describe "clocks" do
    alias TimeManagerAPI.TimeManagerData.Clock

    import TimeManagerAPI.TimeManagerDataFixtures

    @invalid_attrs %{status: nil, time: nil}

    test "list_clocks/0 returns all clocks" do
      clock = clock_fixture()
      assert TimeManagerData.list_clocks() == [clock]
    end

    test "get_clock!/1 returns the clock with given id" do
      clock = clock_fixture()
      assert TimeManagerData.get_clock!(clock.id) == clock
    end

    test "create_clock/1 with valid data creates a clock" do
      valid_attrs = %{status: true, time: ~N[2021-10-25 12:00:00]}

      assert {:ok, %Clock{} = clock} = TimeManagerData.create_clock(valid_attrs)
      assert clock.status == true
      assert clock.time == ~N[2021-10-25 12:00:00]
    end

    test "create_clock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TimeManagerData.create_clock(@invalid_attrs)
    end

    test "update_clock/2 with valid data updates the clock" do
      clock = clock_fixture()
      update_attrs = %{status: false, time: ~N[2021-10-26 12:00:00]}

      assert {:ok, %Clock{} = clock} = TimeManagerData.update_clock(clock, update_attrs)
      assert clock.status == false
      assert clock.time == ~N[2021-10-26 12:00:00]
    end

    test "update_clock/2 with invalid data returns error changeset" do
      clock = clock_fixture()
      assert {:error, %Ecto.Changeset{}} = TimeManagerData.update_clock(clock, @invalid_attrs)
      assert clock == TimeManagerData.get_clock!(clock.id)
    end

    test "delete_clock/1 deletes the clock" do
      clock = clock_fixture()
      assert {:ok, %Clock{}} = TimeManagerData.delete_clock(clock)
      assert_raise Ecto.NoResultsError, fn -> TimeManagerData.get_clock!(clock.id) end
    end

    test "change_clock/1 returns a clock changeset" do
      clock = clock_fixture()
      assert %Ecto.Changeset{} = TimeManagerData.change_clock(clock)
    end
  end

  describe "workingtimes" do
    alias TimeManagerAPI.TimeManagerData.WorkingTime

    import TimeManagerAPI.TimeManagerDataFixtures

    @invalid_attrs %{end: nil, start: nil}

    test "list_workingtimes/0 returns all workingtimes" do
      working_time = working_time_fixture()
      assert TimeManagerData.list_workingtimes() == [working_time]
    end

    test "get_working_time!/1 returns the working_time with given id" do
      working_time = working_time_fixture()
      assert TimeManagerData.get_working_time!(working_time.id) == working_time
    end

    test "create_working_time/1 with valid data creates a working_time" do
      valid_attrs = %{end: ~N[2021-10-25 12:02:00], start: ~N[2021-10-25 12:02:00]}

      assert {:ok, %WorkingTime{} = working_time} = TimeManagerData.create_working_time(valid_attrs)
      assert working_time.end == ~N[2021-10-25 12:02:00]
      assert working_time.start == ~N[2021-10-25 12:02:00]
    end

    test "create_working_time/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TimeManagerData.create_working_time(@invalid_attrs)
    end

    test "update_working_time/2 with valid data updates the working_time" do
      working_time = working_time_fixture()
      update_attrs = %{end: ~N[2021-10-26 12:02:00], start: ~N[2021-10-26 12:02:00]}

      assert {:ok, %WorkingTime{} = working_time} = TimeManagerData.update_working_time(working_time, update_attrs)
      assert working_time.end == ~N[2021-10-26 12:02:00]
      assert working_time.start == ~N[2021-10-26 12:02:00]
    end

    test "update_working_time/2 with invalid data returns error changeset" do
      working_time = working_time_fixture()
      assert {:error, %Ecto.Changeset{}} = TimeManagerData.update_working_time(working_time, @invalid_attrs)
      assert working_time == TimeManagerData.get_working_time!(working_time.id)
    end

    test "delete_working_time/1 deletes the working_time" do
      working_time = working_time_fixture()
      assert {:ok, %WorkingTime{}} = TimeManagerData.delete_working_time(working_time)
      assert_raise Ecto.NoResultsError, fn -> TimeManagerData.get_working_time!(working_time.id) end
    end

    test "change_working_time/1 returns a working_time changeset" do
      working_time = working_time_fixture()
      assert %Ecto.Changeset{} = TimeManagerData.change_working_time(working_time)
    end
  end
end
