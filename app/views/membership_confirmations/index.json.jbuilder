json.array!(@membership_confirmations) do |membership_confirmation|
  json.extract! membership_confirmation, :id, :user_id, :beer_club_id
  json.url membership_confirmation_url(membership_confirmation, format: :json)
end
