class Result < ActiveRecord::Base
  belongs_to :page
  belongs_to :keyword

  scope :having_keyword, ->(args) { eager_load(:keyword).where('keywords.keyword ~* ?', args[:q]).order("results.created_at") }
  scope :adword, ->(args){ where("link ~* ? OR display_url ~* ?", args[:q], args[:q]) }
  scope :paginate, ->(args){ offset(args[:offset].to_i * args[:limit].to_i).limit(args[:limit].to_i) }
end
