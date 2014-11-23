require 'rails_helper'
describe 'Comments' do
  it 'should exist' do
    Comment.create!(copy: 'Things and stuff')
  end

end
