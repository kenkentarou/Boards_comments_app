  # usersテーブルのダミーデータ生成
  puts 'Start inserting seed "users" ...'
  50.times do
    user = User.create!(
        email: Faker::Internet.unique.email,
        last_name: Faker::Name.last_name,
        first_name: Faker::Name.first_name,
        password: 'password',
        password_confirmation: 'password',
        remote_user_image_url: 'https://picsum.photos/350/350/?random'
    )
    puts "\"#{user.decorate.full_name}\" has created!"
  end

  # boardsテーブルのダミーデータ生成
  puts 'Start inserting seed "boards" ...'
  User.limit(50).each do |user|
    board = user.boards.create!(title: Faker::Book.title, body: Faker::Hacker.say_something_smart, remote_board_image_url: 'https://picsum.photos/350/350/?random')
    puts "board#{board.id} has created!"
  end