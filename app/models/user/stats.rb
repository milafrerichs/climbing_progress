class User::Stats
  def initialize(user)
    @user = user
  end

  def climbs
    @climbs ||= User::Stats::Climbs.new(@user)
  end
end
