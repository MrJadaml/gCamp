require 'rails_helper'

describe "Tasks" do

 it 'verifies fields are not left blank' do
    task = Task.new
    expect(task.valid?).to be(false)
    task.description = 'stuff'
    expect(task.valid?).to be(false)
    task.due_date = '12/12/2020'
    expect(task.valid?).to be(true)
  end

  it 'verifies task date is not set in past' do
     task = Task.new
     task.description = 'stuff'
     expect(task.valid?).to be(false)
     task.due_date = '12/12/2000'
     expect(task.valid?).to be(false)
     task.due_date = '1/1/2020'
     expect(task.valid?).to be(true)
   end

end
