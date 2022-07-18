require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:user_parties) }
  it { should have_many(:parties).through(:user_parties) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:password_digest)}
  it { should have_secure_password }

  it 'has secure password' do 
    user = User.create(name: 'Bob', email: 'bob@email.com', password: 'bobspassword', password_confirmation: 'bobspassword')

    expect(user).to_not have_attribute(:password)
    expect(user.password_digest).to_not eq('bobspassword')
  end 
end
