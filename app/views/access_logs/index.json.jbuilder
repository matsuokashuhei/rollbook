json.array!(@access_logs) do |access_log|
  json.extract! access_log, :user_id, :ip, :remote_ip, :request_method, :fullpath
  json.url access_log_url(access_log, format: :json)
end
