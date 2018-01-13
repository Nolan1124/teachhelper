class Teacher < ActiveRecord::Base
    before_save { self.email = email.downcase }
    
    #password长度不小于6个字符
    validates :password, presence: true, length: {minimum: 6}
    #email 确定正确格式
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: {maximum: 255},
            format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false }
    #has_secure_password
end
