class User < ActiveRecord::Base
  has_secure_password

  validates :email, :uniqueness => { :case_sensitive => false  }
  validates :password, length: { minimum: 6 }

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email, password)
    email.strip!
    email.downcase!

    user = User.find_by_email(email)

    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end

end
