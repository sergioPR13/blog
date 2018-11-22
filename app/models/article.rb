class Article < ApplicationRecord
    belongs_to :user
    has_many :comments
    validates :title, presence: true, uniqueness: true 
    validates :body, presence: true, length: { minimum: 20 }
    before_save :set_visit_count

    has_attached_file :cover, styles: { medium:"1280x720", thumb:"800x600" }
    validates_attachment_content_type :cover, content_type: /\Aimage\/.*\z/

    def update_visit_count
        self.save if self.visit_count.nil?
        self.update(visit_count: self.visit_count + 1)
    end
    private
    def set_visit_count
        self.visit_count ||= 0
    end
end
