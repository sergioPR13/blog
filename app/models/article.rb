class Article < ApplicationRecord
    include AASM
    
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :has_categories, dependent: :destroy
    has_many :categories, through: :has_categories

    validates :title, presence: true, uniqueness: true 
    validates :body, presence: true, length: { minimum: 20 }
    before_save :set_visit_count
    after_create :save_categories

    has_attached_file :cover, styles: { medium:"1280x720", thumb:"800x600" }
    validates_attachment_content_type :cover, content_type: /\Aimage\/.*\z/

    scope :publicados, ->{ where(state: "published") }
    scope :ultimos, ->{ order("created_at DESC").limit(10) }

    #custome setter
    def categories=(value)
        @categories = value
    end

    def update_visit_count
        self.save if self.visit_count.nil?
        self.update(visit_count: self.visit_count + 1)
    end

    aasm column: "state" do
        state :in_draft, initial: true
        state :published
        event :publish do
            transitions from: :in_draft, to: :published
        end
        event :unpublish do
            transitions from: :published, to: :in_draft
        end
    end

    private
    def save_categories
        @categories.each do |category_id|
            HasCategory.create(category_id: category_id,article_id: self.id)
        end
    end
    def set_visit_count
        self.visit_count ||= 0
    end
end
