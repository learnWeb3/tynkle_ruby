class Categorytag < ApplicationRecord

    has_many :skills
    has_many :missions

    validates :name, presence: true, uniqueness: true, length: {maximum:50}
    validates :problem_description, presence: true, uniqueness: true, length: {maximum:500}

    after_create :update_image_url

    def update_image_url
        category_tag_names = ["Système", "Logiciel", "Matériel", "Réseau", "Cours-Tutorat"]
        category_tag_images_urls = ["icons/Système.png","icons/Logiciel.png","icons/Matériel.png","icons/Réseau.png","icons/Cours-Tutorat.png"]
        name = self.name
        case name 
        when category_tag_names[0]
            self.update_attributes(image_url:category_tag_images_urls[0])

        when category_tag_names[1]
            self.update_attributes(image_url:category_tag_images_urls[1])

        when category_tag_names[2]
            self.update_attributes(image_url:category_tag_images_urls[2])

        when category_tag_names[3]
            self.update_attributes(image_url:category_tag_images_urls[3])

        when category_tag_names[4]
            self.update_attributes(image_url:category_tag_images_urls[4])

        end
        
    end
    
end
