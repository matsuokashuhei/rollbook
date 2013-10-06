json.array!(@tasks) do |task|
  json.extract! task, :name, :frequency, :due_date, :status, :note
  json.url task_url(task, format: :json)
end
