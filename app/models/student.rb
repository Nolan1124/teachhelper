class Student < ActiveRecord::Base
    
    validates :sno, presence: true, length: {maximum: 50}
end
