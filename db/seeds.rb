# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# call to faker gem
require 'faker'

# database destroy all objects 
User.destroy_all
Categorytag.destroy_all
Skill.destroy_all
DeviceCategory.destroy_all

# reset autoincrement for tables to start by id=1

User.connection.execute('ALTER SEQUENCE users_id_seq RESTART WITH 1')
Categorytag.connection.execute('ALTER SEQUENCE categorytags_id_seq RESTART WITH 1')
Skill.connection.execute('ALTER SEQUENCE skills_id_seq RESTART WITH 1')
DeviceCategory.connection.execute('ALTER SEQUENCE device_categories_id_seq RESTART WITH 1')

# Generating SkillGroup known in database as Categorytag Class
category_tag_names = ["os", "software", "hardware", "network", "learning"]
category_tag_names.each do |tag_name|
    Categorytag.create(name:tag_name)
end



category_name_os = ["Dépannage plateforme Windows","Dépannage plateforme Apple","Dépannage plateforme Linux","Dépannage plateforme IOS","Dépannage plateforme Android","Jailbreak débridage dévérouillage de systèmes"]
category_name_software = ["Installation logiciels bureautique","Configuration logiciel bureautique","Installation logiciel professionnel","Configuration logiciel professionnel","Sauvegarde ou Récupération de données"]
category_name_hardware = ["Changer ou installer un périphérique matériel","Changer ou installer un composant interne","Monter un système complet classique","Monter un système complet gaming"]
category_name_network = ["Changer ou installer un périphérique réseau","Configurer un réseau basique","Configurer un réseau avancé","Configurer ou installer un VPN","Configurer ou installer un antivirus"]
category_name_learning = ["Mentoring ou cours ponctuels", "Mentoring ou cours réguliers","Mentoring ou cours individuel","Mentoring ou cours collectif","Missions longues durées", "Missions courtes durées"]




category_description_os = ["Je suis capable d'intervenir sur des appareils équipés du système d'exploitation WINDOWS","Je suis capable d'intervenir sur des appareils équipés du système d'exploitation MAC OS", "Je suis capable d'intervenir sur des appareils équipés du système d'exploitation LINUX", "Je suis capable d'intervenir sur des appareils équipés du système d'exploitation mobile IOS","Je suis capable d'intervenir sur des appareils équipés du système d'exploitation mobile ANDROID", "Je suis capable de d'enlever un vérouillage usine, de débloquer un appareil vérouillé par google smartlock ou de redonner accès à l'utilisateur ayant perdu ou oublié son mot de passe administrateur"]
category_description_software = ["Installation de suite bureautiques, permettant le traitement du language et de l'image, ex: Office, OpenOffice, Photoshop, Adobe PDF, etc...", "Je suis capable de configurer une des suites bureautiques, de renouveller une licence, de paramétrer une interfaces selon les besoins spécifiques de l'utilisateur", "Je suis capable d'installer un logiciel professionnel, de conseiller un client sur le choix d'un logiciel répondant à un besoin spécifique", "Je suis capablke de configurer un logiciel en me rapportant à sa documentation technique sans avoir forcément eut de formation pour le faire, je peut ainsi répondre à une demande de configuration spécifique de la part d'un utilisateur", "Je peux sauvegarder des données sur un support selon le besoin d'un utilisateur ou après diagnostic restaurer des données perdues ou inaccessibles" ]
category_description_hardware = ["Je sais installer ou remplacer un périphérique matériel externe", "Je sais installer ou remplacer un composant interne: processeur, carte mère, etc...", "Je sais monter un appareil complet avec des pièces choisies au préalables", "Je sais monter un appreil complet et suis force de proposition quand au choix des pièces"]
category_description_network = ["Je sais changer ou installer un périphérique réseau: routeur, clef wifi, serveur etc..", "Je sais configurer un réseau basique de type domestique en mettant en place l'ensemble des protection nécessaire à l'utilisateur", "Je sais configurer un réseau basique de type professionnel en mettant en place l'ensemble des protection nécessaire à l'utilisateur", "Je sais installer et configurer un réseau privé virtuel (VPN)", "Je sais installer ou renouveller un antivirus"]
category_description_learning = ["Je suis ouvert à des demandes de formation ponctuelles", "Je suis ouvert à des demandes de formation régulieres", "Je suis ouvert à des demandes de formation individuelles", "Je suis ouvert à des demandes de formation de groupes"]


# Generating  Skills category by category

# OS skills

category_name_os.each_with_index do |name_os, index|
        Skill.create(name:name_os, description:category_description_os[index], categorytag:Categorytag.find(1))
end

# SOFTWARE skills

category_name_software.each_with_index do |name_software, index|
    Skill.create(name:name_software, description:category_description_software[index], categorytag:Categorytag.find(2))
end

# HARDWARE skills

category_name_hardware.each_with_index do |name_hardware, index|
    Skill.create(name:name_hardware, description:category_description_hardware[index], categorytag:Categorytag.find(3))
end

# NETWORK skills

category_name_network.each_with_index do |name_network, index|
    Skill.create(name:name_network, description:category_description_network[index], categorytag:Categorytag.find(4))
end

# LERANING/COURSES skills

category_name_learning.each_with_index do |name_learning, index|
    Skill.create(name:name_learning, description:category_description_learning[index], categorytag:Categorytag.find(5))
end


# DEVICE CATEGORIES 

device_categories = ['ordinateurs de bureau', 'ordinateurs portables', 'téléphones mobiles', 'multimédia', 'consoles', 'réseau et objects connectés']
device_categories_description= ["Ordinateur constitué d'une tour et d'un écran", "Ordinateur dont le poids et la taille permet un transport facile", "téléphones portable tactiles ou non", "Télévision, Hi-Fi, Lecteur-DVD, Lecteur-Blue-Ray...", "Consoles de jeux: Playstation, Xbox, Nintendo etc..", 'Routeurs, modems, serveurs, périphériques réseau']

device_categories.each_with_index do |dev_cat, index|
    DeviceCategory.create(title:dev_cat, description: device_categories_description[index])
end