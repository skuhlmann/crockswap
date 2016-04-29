#Containers
Container.delete_all
Container.create(name: "Tupperware", size: "6oz")
Container.create(name: "Tupperware", size: "12oz")
Container.create(name: "Pyrex", size: "12oz")
Container.create(name: "Pyrex", size: "6oz")

#Dietary Restictions
DietRestriction.delete_all
DietRestriction.create(name: "Gluten-free")
DietRestriction.create(name: "Vegetarian")
DietRestriction.create(name: "Vegan")
