defmodule TimeManager.WorkingTimeManagerTest do
  use TimeManager.DataCase

  alias TimeManager.WorkingTimeManager

  describe "workingtimes" do
    alias TimeManager.WorkingTimeManager.WorkingTime

    import TimeManager.WorkingTimeManagerFixtures

    @invalid_attrs %{end: nil, start: nil}

    test "list_workingtimes/0 returns all workingtimes" do
      working_time = working_time_fixture()
      assert WorkingTimeManager.list_workingtimes() == [working_time]
    end

    test "get_working_time!/1 returns the working_time with given id" do
      working_time = working_time_fixture()
      assert WorkingTimeManager.get_working_time!(working_time.id) == working_time
    end

    test "create_working_time/1 with valid data creates a working_time" do
      valid_attrs = %{end: ~N[2021-10-25 10:59:00], start: ~N[2021-10-25 10:59:00]}

      assert {:ok, %WorkingTime{} = working_time} = WorkingTimeManager.create_working_time(valid_attrs)
      assert working_time.end == ~N[2021-10-25 10:59:00]
      assert working_time.start == ~N[2021-10-25 10:59:00]
    end

    test "create_working_time/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = WorkingTimeManager.create_working_time(@invalid_attrs)
    end

    test "update_working_time/2 with valid data updates the working_time" do
      working_time = working_time_fixture()
      update_attrs = %{end: ~N[2021-10-26 10:59:00], start: ~N[2021-10-26 10:59:00]}

      assert {:ok, %WorkingTime{} = working_time} = WorkingTimeManager.update_working_time(working_time, update_attrs)
      assert working_time.end == ~N[2021-10-26 10:59:00]
      assert working_time.start == ~N[2021-10-26 10:59:00]
    end

    test "update_working_time/2 with invalid data returns error changeset" do
      working_time = working_time_fixture()
      assert {:error, %Ecto.Changeset{}} = WorkingTimeManager.update_working_time(working_time, @invalid_attrs)
      assert working_time == WorkingTimeManager.get_working_time!(working_time.id)
    end

    test "delete_working_time/1 deletes the working_time" do
      working_time = working_time_fixture()
      assert {:ok, %WorkingTime{}} = WorkingTimeManager.delete_working_time(working_time)
      assert_raise Ecto.NoResultsError, fn -> WorkingTimeManager.get_working_time!(working_time.id) end
    end

    test "change_working_time/1 returns a working_time changeset" do
      working_time = working_time_fixture()
      assert %Ecto.Changeset{} = WorkingTimeManager.change_working_time(working_time)
    end
  end
end
