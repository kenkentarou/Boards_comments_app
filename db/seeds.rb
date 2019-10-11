11.times do
  Board.create(
      title: Faker::Book.title,
      body: Faker::JapaneseMedia::OnePiece.akuma_no_mi,
      user_id: Faker::Number.digit
  )
end