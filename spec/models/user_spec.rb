require 'rails_helper'

describe "Users" do

   it 'verifies email is unique' do
      User.create!(email: 'bob@mail.com',
                   first_name: 'bob',
                   last_name: 'thing',
                   password: 'password'
                  )

      user = User.new(email: 'bob@mail.com')
      user.valid?
      expect(user.errors[:email].present?).to eq(true)

      guy = User.new(email: 'some@mail.com')
      guy.valid?
      expect(guy.errors[:email].present?).to eq(false)
    end

end
