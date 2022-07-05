json.extract! task, :id, :task_id, :task_user, :task_title, :task_content, :task_tag, :task_build_time, :task_start_time, :task_end_time, :task_priority, :task_state, :created_at, :updated_at
json.url task_url(task, format: :json)
