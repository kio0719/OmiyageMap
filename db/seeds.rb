user1 = User.create!(
      name: '太郎', 
      email: 'taro@example.com',
      password: 'password',
      password_confirmation: 'password',
      introduction: '太郎と言います。よろしくお願いします。'
)
user1.icon.attach(io: File.open(Rails.root.join('app/assets/images/seed-icon-1.jpg')), filename: 'seed-icon-1.jpg')

user2 = User.create!(
      name: '花子', 
      email: 'hanako@example.com',
      password: 'password',
      password_confirmation: 'password',
      introduction: '花子と言います。よろしくお願いします。'
)
user2.icon.attach(io: File.open(Rails.root.join('app/assets/images/seed-icon-2.jpg')), filename: 'seed-icon-2.jpg')

user3 = User.create!(
      name: '次郎', 
      email: 'jiro@example.com',
      password: 'password',
      password_confirmation: 'password',
      introduction: '次郎と言います。よろしくお願いします。'
)


post1 = Post.create!(
  name: 'イチゴケーキ',
  caption: '美味しい',
  address: '京都タワー',
  user_id: 1,
)
post1.images.attach(
  [io: File.open(Rails.root.join('app/assets/images/seed1-1.jpg')), filename: 'seed1-1.jpg'],
  [io: File.open(Rails.root.join('app/assets/images/seed1-2.jpg')), filename: 'seed1-2.jpg'],
  [io: File.open(Rails.root.join('app/assets/images/seed1-3.jpg')), filename: 'seed1-3.jpg']
)

post2 = Post.create!(
  name: 'ハンバーガー',
  caption: 'ジューシー',
  address: '東京ドーム',
  user_id: 2,
)
post2.images.attach(
  [io: File.open(Rails.root.join('app/assets/images/seed2-1.jpg')), filename: 'seed2-1.jpg'],
  [io: File.open(Rails.root.join('app/assets/images/seed2-2.jpg')), filename: 'seed2-2.jpg'],
  [io: File.open(Rails.root.join('app/assets/images/seed2-3.jpg')), filename: 'seed2-3.jpg'],
  [io: File.open(Rails.root.join('app/assets/images/seed2-4.jpg')), filename: 'seed2-4.jpg'],
  [io: File.open(Rails.root.join('app/assets/images/seed2-5.jpg')), filename: 'seed2-5.jpg']
)

post3 = Post.create!(
  name: '餃子',
  caption: 'もちもち',
  address: '宇都宮城址公園',
  user_id: 3,
)
post3.images.attach(
  [io: File.open(Rails.root.join('app/assets/images/seed3-1.jpg')), filename: 'seed3-1.jpg']
)

post4 = Post.create!(
  name: '和菓子',
  caption: 'ほっこりする',
  address: '伏見稲荷大社',
  user_id: 2,
)
post4.images.attach(
  [io: File.open(Rails.root.join('app/assets/images/seed4-1.jpg')), filename: 'seed4-1.jpg'],
  [io: File.open(Rails.root.join('app/assets/images/seed4-2.jpg')), filename: 'seed4-2.jpg'],
)

post5 = Post.create!(
  name: 'ラーメン',
  caption: '濃厚！',
  address: '博多',
  user_id: 1
)

Like.create!(
  [
    {
      user_id: 1,
      post_id: 2
    },
    {
      user_id: 2,
      post_id: 3
    },
    {
      user_id: 3,
      post_id: 4
    }
  ]
)

Comment.create!(
  [
    {
      comment: '美味しそう！行ってみたい',
      user_id: 1,
      post_id: 2
    },
    {
      comment: '美味しそう！行ってみたい',
      user_id: 1,
      post_id: 4
    },
    {
      comment: 'お腹が減りますね',
      user_id: 2,
      post_id: 3
    },
    {
      comment: 'のんびりしたいです',
      user_id: 3,
      post_id: 4
    },
  ]
)
