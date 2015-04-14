class Page < ActiveRecord::Base
  has_many :results
  belongs_to :keyword
end
