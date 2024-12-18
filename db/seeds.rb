herd = Herd.create!(name: "Alpha Herd")
Animal.create!(name: "Deer1", status: "active", herd: herd)
Animal.create!(name: "Goat2", status: "active", herd: herd)
