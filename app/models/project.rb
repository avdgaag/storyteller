class Project < ActiveRecord::Base
  attr_accessible :description, :owner_id, :title
  belongs_to :owner, class_name: 'User'
  has_many :stories, dependent: :destroy
  has_many :epics, dependent: :destroy
  has_many :collaborations, dependent: :destroy
  has_many :invitations, dependent: :destroy
  validates :title, :owner, presence: :true

  scope :for_user, ->(id) do
    joins('left join collaborations on project_id = projects.id').
      where('owner_id = :id or collaborations.user_id = :id', id: id)
  end
end
