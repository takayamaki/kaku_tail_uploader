if Rails.env.development?
  User.where(name: 'kakutail-admin').first_or_create(name: 'kakutail-admin',email: "kakutail-admin@localhost", password: 'kakutail-admin', password_confirmation: 'kakutail-admin', confirmed_at: Time.now.utc, role: :admin)
  User.where(name: 'kakutail-user').first_or_create(name: 'kakutail-user',email: "kakutail-user@localhost", password: 'kakutail-user', password_confirmation: 'kakutail-user', confirmed_at: Time.now.utc, role: :creator)
end
