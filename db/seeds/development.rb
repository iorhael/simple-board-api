# frozen_string_literal: true

# Generate simple users
5.times do |index|
  User.find_or_create_by(email: "user_#{index}@example.com") do |user|
    user.name = Faker::Name.first_name
    user.password = 'password'
  end
end

# Generate admins
3.times do |index|
  User.find_or_create_by(email: "admin_#{index}@example.com") do |user|
    user.name = Faker::Name.first_name
    user.password = 'password'
    user.is_admin = true
  end
end
