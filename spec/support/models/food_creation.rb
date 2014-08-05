def create_food(attributes ={})
  defaults = {
    name: 'Steak',
    description: 'Savory'
  }
Food.create!(defaults.merge!(attributes))
end