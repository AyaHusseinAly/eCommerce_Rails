class ProductSerializer < ActiveModel::Serializer
  attributes :id,:title,:description,:img,:category,:brand,:store
end
