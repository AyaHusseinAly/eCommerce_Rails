# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Brand.create([{
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
}
])
Store.create!([{
    name: "Sample Store",
    summary: "This is a sample summary for a store",
    user: User.first
}])
Product.create!([{
    title:'Hoodie',
    description: 'This is a hoodie.',
    img: '1.jpg',
    price: 500,
    quantity: 5,
    brand: Brand.find(1),
    category: Category.find(3),
    store: Store.find(1)

},
{
    title:'Cactus',
    description: 'This is a Cactus.',
    img: '2.jpg',
    price: 100,
    quantity: 3,
    brand: Brand.find(1),
    category: Category.find(1),
    store: Store.find(1)
},
{
    title:'Cactus 2',
    description: 'This is also a Cactus.',
    img: '5.jpg',
    price: 200,
    quantity: 10,
    brand: Brand.find(1),
    category: Category.find(1),
    store: Store.find(1)
},
{
    title:'Clock',
    description: 'This is a clock.',
    img: '6.jpg',
    price: 1000,
    quantity: 5,
    brand: Brand.find(1),
    category: Category.find(2),
    store: Store.find(1)
},
{
    title:'Camera',
    description: 'This is a camera.',
    img: '7.jpg',
    price: 1200,
    quantity: 22,
    brand: Brand.find(1),
    category: Category.find(2),
    store: Store.find(1)
},
{
    title:'Robot',
    description: 'I will haunt your dreams',
    img: '8.jpg',
    price: 1,
    quantity: 10000,
    brand: Brand.find(1),
    category: Category.find(2),
    store: Store.find(1)
},
{
    title:'Methylene',
    description: 'Wanna get poisoned? buy this',
    img: '9.jpg',
    price: 1000,
    quantity: 5,
    brand: Brand.find(1),
    category: Category.find(1),
    store: Store.find(1)
},
{
    title:'Cubes!',
    description: 'Cubes! Cubes! Cubes!',
    img: '10.jpg',
    price: 50,
    quantity: 3,
    brand: Brand.find(1),
    category: Category.find(4),
    store: Store.find(1)
},
{
    title:'Pencil',
    description: 'You need me to write',
    img: '11.jpg',
    price: 5,
    quantity: 100,
    brand: Brand.find(1),
    category: Category.find(5),
    store: Store.find(1)
},
{
    title:'Building',
    description: "It's cheap for a building.. but it might fall on you ¯\_(ツ)_/¯ ",
    img: '12.jpg',
    price: 10000,
    quantity: 1,
    brand: Brand.find(1),
    category: Category.find(5),
    store: Store.find(1)
}])
p "Created #{Category.count} categories and #{Product.count} products"



# class AddInitialProducts < ActiveRecord::Migration[5.0]
#     def up
#       5.times do |i|
#         Product.create(title: "Product ##{i}", description: "A product.",img:"#{i}.jpg",store_id:2,brand_id:2,category_id:4,price:140,quantity:15)
#       end
#     end
   
# end
