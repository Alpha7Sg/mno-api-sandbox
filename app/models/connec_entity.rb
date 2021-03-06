# == Schema Information
#
# Table name: connec_entities
#
#  id          :integer          not null, primary key
#  uid         :string(255)
#  document    :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  group_id    :string(255)
#  entity_name :string(255)
#

class ConnecEntity < ActiveRecord::Base
  attr_accessible :group_id, :entity_name, :document
  
  #============================================
  # Validation rules
  #============================================
  validates :group_id, presence: true
  validates :entity_name, presence: true
  
  #============================================
  # Callbacks
  #============================================
  before_create :generate_uid
  
  #============================================
  # Associations
  #============================================
  belongs_to :group, foreign_key: :uid
  
  #============================================
  # Special fields
  #============================================
  serialize :document, Hash
  
  private
    def generate_uid
      self.uid ||= UUID.new.generate
    end
end
