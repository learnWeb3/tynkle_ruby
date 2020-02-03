# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



category_name_os = ["Dépannage plateforme Windows","Dépannage plateforme Apple","Dépannage plateforme Linux","Dépannage plateforme IOS","Dépannage plateforme Android","Jailbreak débridage dévérouillage de systèmes"]
category_name_software = ["Installation logiciels bureautique","Configuration logiciel bureautique","Installation logiciel professionnel","Configuration logiciel professionnel","Sauvegarde ou Récupération de données"]
category_name_hardware = ["Changer ou installer un périphérique matériel","Changer ou installer un composant interne","Monter un système complet classique","Monter un système complet gaming"]
category_name_network = ["Changer ou installer un périphérique réseau","Configurer un réseau basique","Configurer un réseau avancé","Configurer ou installer un VPN","Configurer ou installer un antivirus"]
category_name_learning = ["Mentoring ou cours ponctuels", "Mentoring ou cours réguliers","Mentoring ou cours individuel","Mentoring ou cours collectif","Missions longues durées", "Missions courtes durées"]




category_description = []

Category.create(name:title, description:descriptive_words)