json.array!(@leads) do |lead|
  json.extract! lead, :id, :first_name, :last_name, :email, :phone, :sales_force_id, :user_id, :company
  json.url lead_url(lead, format: :json)
end
