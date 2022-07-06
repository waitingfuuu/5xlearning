require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = tasks(:one)
  end

  test "should get index" do
    get tasks_url
    assert_response :success
  end

  test "should get new" do
    get new_task_url
    assert_response :success
  end

  test "should create task" do
    assert_difference("Task.count") do
      post tasks_url, params: { task: { task_build_time: @task.task_build_time, task_content: @task.task_content, task_end_time: @task.task_end_time, task_id: @task.task_id, task_priority: @task.task_priority, task_start_time: @task.task_start_time, task_state: @task.task_state, task_tag: @task.task_tag, task_title: @task.task_title, task_user: @task.task_user } }
    end

    assert_redirected_to task_url(Task.last)
  end

  test "should show task" do
    get task_url(@task)
    assert_response :success
  end

  test "should get edit" do
    get edit_task_url(@task)
    assert_response :success
  end

  test "should update task" do
    patch task_url(@task), params: { task: { task_build_time: @task.task_build_time, task_content: @task.task_content, task_end_time: @task.task_end_time, task_id: @task.task_id, task_priority: @task.task_priority, task_start_time: @task.task_start_time, task_state: @task.task_state, task_tag: @task.task_tag, task_title: @task.task_title, task_user: @task.task_user } }
    assert_redirected_to task_url(@task)
  end

  test "should destroy task" do
    assert_difference("Task.count", -1) do
      delete task_url(@task)
    end

    assert_redirected_to tasks_url
  end
end
