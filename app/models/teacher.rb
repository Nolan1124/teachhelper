class Teacher < ActiveRecord::Base
    #t_id 唯一
    validates :t_id, presence: true, uniqueness: true
    #password长度不小于6个字符
    validates :password, presence: true, length: {minimum: 6}
    #email 确定正确格式
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :eamil, presence: true, length: {maximum: 255},
            format: {with: VALID_EMAIL_REGEX}
end
