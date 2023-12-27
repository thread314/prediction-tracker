json.extract! report, :id, :reason, :body, :status, :created_at, :updated_at
json.url report_url(report, format: :json)
