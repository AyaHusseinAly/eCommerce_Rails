# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#delete all previous records and reset pk
WishingListItem.destroy_all
ShoppingCardItem.destroy_all
RateReview.destroy_all
OrderDetail.destroy_all
Product.destroy_all
Order.destroy_all
Store.destroy_all
User.destroy_all
Brand.destroy_all
Category.destroy_all
AdminUser.destroy_all
# ActiveRecord::Base.connection.reset_pk_sequence!(Product.table_name)
# ActiveRecord::Base.connection.reset_pk_sequence!(Store.table_name)
# ActiveRecord::Base.connection.reset_pk_sequence!(Brand.table_name)
# ActiveRecord::Base.connection.reset_pk_sequence!(Category.table_name)
# ActiveRecord::Base.connection.reset_pk_sequence!(User.table_name)
# ActiveRecord::Base.connection.reset_pk_sequence!(AdminUser.table_name)
# ActiveRecord::Base.connection.reset_pk_sequence!(OrderDetail.table_name)
# ActiveRecord::Base.connection.reset_pk_sequence!(RateReview.table_name)
# ActiveRecord::Base.connection.reset_pk_sequence!(ShoppingCardItem.table_name)
# ActiveRecord::Base.connection.reset_pk_sequence!(WishingListItem.table_name)





Brand.create!([{
    name: "Sample Brand"
}])
Category.create!([{
    name: "Herbs"
},
{
    name: "Electronics"
},
{
    name: "Sports"
},
{
    name: "Backpacks"
},
{
    name: "Women's Clothes"
},{
    name:"Others"
}
])
# user=User.create!(
#     name:"User",
#     email:"user@example.com",
#     password:"Password123",
#     password_confirmation: 'Password123'
# )
# user.avatar.attach(io: File.open('app/assets/images/default_profile.jpg'), filename: 'default_profile.jpg', content_type: 'image/png')

AdminUser.create!(name:"admin",email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
AdminUser.create!(name:"seller",email: 'seller@example.com', password: 'password', password_confirmation: 'password',role: 'seller') if Rails.env.development?
# User.create!(name:"seller",email: 'seller@example.com', password: 'Password123', password_confirmation: 'Password123',role: 'seller') 

Store.create!([{
    name: "Sample Store",
    summary: "This is a sample summary for a store",
    admin_user: AdminUser.find_by(role:"seller")
}
])
Product.create!([{
    title:'Hoodie',
    description: 'This is a hoodie.',
    price: 500,
    quantity: 5,
    brand: Brand.find_by(name:"Sample Brand"),
    category: Category.find_by(name:"Sports"),
    store: Store.find_by(name:'Sample Store')

},
{
    title:'Cactus',
    description: 'This is a Cactus.',
    price: 100,
    quantity: 3,
    brand: Brand.find_by(name:"Sample Brand"),
    category: Category.find_by(name:"Herbs"),
    store: Store.find_by(name:'Sample Store')
},
{
    title:'Cactus 2',
    description: 'This is also a Cactus.',
    price: 200,
    quantity: 10,
    brand: Brand.find_by(name:"Sample Brand"),
    category: Category.find_by(name:"Herbs"),
    store: Store.find_by(name:'Sample Store')
},
{
    title:'Clock',
    description: 'This is a clock.',
    price: 1000,
    quantity: 5,
    brand: Brand.find_by(name:"Sample Brand"),
    category: Category.find_by(name:'Electronics'),
    store: Store.find_by(name:'Sample Store')
},
{
    title:'Camera',
    description: 'This is a camera.',
    price: 1200,
    quantity: 22,
    brand: Brand.find_by(name:"Sample Brand"),
    category: Category.find_by(name:'Electronics'),
    store: Store.find_by(name:'Sample Store')
},
{
    title:'Robot',
    description: 'I will haunt your dreams',
    price: 1,
    quantity: 10000,
    brand: Brand.find_by(name:"Sample Brand"),
    category: Category.find_by(name:'Electronics'),
    store: Store.find_by(name:'Sample Store')
},
{
    title:'Methylene',
    description: 'Wanna get poisoned? buy this',
    price: 1000,
    quantity: 5,
    brand: Brand.find_by(name:"Sample Brand"),
    category: Category.find_by(name:"Herbs"),
    store: Store.find_by(name:'Sample Store')
},
{
    title:'Cubes!',
    description: 'Cubes! Cubes! Cubes!',
    price: 50,
    quantity: 3,
    brand: Brand.find_by(name:"Sample Brand"),
    category: Category.find_by(name:"Backpacks"),
    store: Store.find_by(name:'Sample Store')
},
{
    title:'Pencil',
    description: 'You need me to write',
    price: 5,
    quantity: 100,
    brand: Brand.find_by(name:"Sample Brand"),
    category: Category.find_by(name:"Women's Clothes"),
    store: Store.find_by(name:'Sample Store')
},
{
    title:'Building',
    description: "It's cheap for a building.. but it might fall on you ¯\_(ツ)_/¯ ",
    price: 10000,
    quantity: 1,
    brand: Brand.find_by(name:"Sample Brand"),
    category: Category.find_by(name:"Women's Clothes"),
    store: Store.find_by(name:'Sample Store')
}])
count=0
# Product.all.each do |product|
#     product.img.attach(io: File.open("public/img/products/#{count+=1}.jpg"), filename: "#{count}.jpg", content_type: 'image/png')
# end

