if Rails.env.development?
  User.where(name: 'kakutail-admin').first_or_create(name: 'kakutail-admin',email: "kakutail-admin@localhost", password: 'kakutail-admin', password_confirmation: 'kakutail-admin', confirmed_at: Time.now.utc, role: :admin)
  User.where(name: 'kakutail-organizer').first_or_create(name: 'kakutail-organizer',email: "kakutail-organizer@localhost", password: 'kakutail-organizer', password_confirmation: 'kakutail-organizer', confirmed_at: Time.now.utc, role: :organizer)
  User.where(name: 'kakutail-staff').first_or_create(name: 'kakutail-staff',email: "kakutail-staff@localhost", password: 'kakutail-staff', password_confirmation: 'kakutail-staff', confirmed_at: Time.now.utc, role: :staff)
  User.where(name: 'kakutail-creator').first_or_create(name: 'kakutail-creator',email: "kakutail-creator@localhost", password: 'kakutail-creator', password_confirmation: 'kakutail-creator', confirmed_at: Time.now.utc, role: :creator)
  User.where(name: 'kakutail-unauthorized').first_or_create(name: 'kakutail-unauthorized',email: "kakutail-unauthorized@localhost", password: 'kakutail-unauthorized', password_confirmation: 'kakutail-unauthorized', confirmed_at: Time.now.utc, role: :unauthorized)
end
