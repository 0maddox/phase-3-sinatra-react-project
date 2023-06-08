class Movie < Activerecord::BAse
    has_many :reviews
    has_many :user, through: :reviews 
end