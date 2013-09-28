class Twitteruser
  include Mongoid::Document
  has_many :tweets

  TCLIENT = Twitter::Client.new(
    :consumer_key       => "yqmcs6FwwzKJmlYyETgR9g",
    :consumer_secret    => "07xJWwj1Hkbdka4Cvid47koSmS4Z5ijakeY07OrYOKU",
    :oauth_token        => "20767940-IaQsSqukar9Ru8mpulYQtl4v6Hw72iqT7oVMkTipm",
    :oauth_token_secret => "i2m5seEHraGVC0rWfXEaLU97pndh6gBZ9Zj6jQ1I8"
  )

  field :handle,      :type => String
  field :working,     :type => Boolean, :default => false
  field :completed,   :type => Boolean, :default => false

  validates :handle, :presence => true, :uniqueness => true


  def self.parseuser user
    @use = Twitteruser.where(:handle => user)
    
    if @use.count > 0
        @use = @use.first
        @use.working = true
        @use.tweets.destroy_all
        @use.save
    else
        @use = Twitteruser.create(:handle => user, :working => true)
    end

    @use.parsetweets
  end

  def parsetweets
    self.working = true
    self.save!

    lastid = nil

    16.times do |i|         # 3200/200 = 16
        if lastid == nil
            resp = TCLIENT.user_timeline(self.handle, :count => 200)
        else
            resp = TCLIENT.user_timeline(self.handle, :count => 200, :max_id => lastid)            
        end

        if resp.count == 0
            break
        end

        resp.each do |r|
            self.tweets.create(:twitter_id => r.id, :text => r.text, :created_at => r.created_at)
        end

        lastid = resp.last.id - 1
    end

    self.working = false
    self.save!
    self.completed = true
    self.save!
  end
end
