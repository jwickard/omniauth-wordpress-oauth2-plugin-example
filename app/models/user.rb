class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  def self.find_for_wordpress_oauth2(oauth, signed_in_user=nil)

    #if the user was already signed in / but they navigated through the authorization with wordpress
    if signed_in_user

      #update / synch any information you want from the authentication service.
      if signed_in_user.email.nil? or signed_in_user.email.eql?('')
        signed_in_user.update_attributes(email: oauth['info']['email'])
      end

      return signed_in_user
    else
      #find user by id and provider.
      user = User.find_by_provider_and_uid(oauth['provider'], oauth['uid'])

      #if user isn't in our dabase yet, create it!
      if user.nil?
        user = User.create!(email: oauth['info']['email'], uid: oauth['uid'], provider: oauth['provider'],
                            nickname: oauth['extra']['user_login'], website: oauth['info']['urls']['Website'],
                            display_name: oauth['extra']['display_name'])
      end

      user
    end

  end

  #we don't require a password for our wordpress authenticated users.
  def password_required?
    false
  end
end
