class Keyword < ActiveRecord::Base
  has_many :pages
  has_many :results
end
