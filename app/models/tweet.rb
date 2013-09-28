class Tweet
  include Mongoid::Document
  belongs_to :twitteruser

  field :text, 			:type => String
  field :twitter_id,	:type => Integer
  field :created_at,	:type => Time

  validates :created_at,  :presence => :true
  validates :twitteruser, :presence => :true
  validates :twitter_id,  :presence => :true#, :uniqueness => :true  
end
