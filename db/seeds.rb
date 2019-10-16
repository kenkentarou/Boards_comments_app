10.times do |n|
  # usersテーブルのダミーデータ生成
  id = n+1
  email = Faker::Internet.email
  last_name = Faker::Name.last_name
  first_name = Faker::Name.first_name
  password = "pass"

  User.create!(id: id,
               email: email,
               last_name: last_name,
               first_name: first_name,
               password: password,
               password_confirmation: password
  )

  # boardsテーブルのダミーデータ生成
  title = Faker::Book.title
  body = Faker::JapaneseMedia::OnePiece.akuma_no_mi
  user_id = User.find((n+1).to_s)

  Board.create!(id: id,
                title: title,
                body: body,
                user: user_id
  )
end