class Article < ApplicationRecord
    belongs_to :user
    has_many :comments
    validates :title, presence: true, uniqueness: true 
    validates :body, presence: true, length: { minimum: 20 }
    before_save :set_visit_count

    def update_visit_count
        self.save if self.visit_count.nil?
        self.update(visit_count: self.visit_count + 1)
    end
    private
    def set_visit_count
        self.visit_count ||= 0
    end
end
