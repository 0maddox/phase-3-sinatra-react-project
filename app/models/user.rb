class User < Activerecord::BAse
    has_many :reviews
    has_many :movies, through: :reviews 
end
