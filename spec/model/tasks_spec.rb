require 'rails_helper'

feature "Tasks" do

 it 'verifies date of all fields' do
    task = Task.new
    expect(task.valid?).to be(false)
    task.description = 'stuff'
    expect(task.valid?).to be(true)
    task.due_date = '10/10/2000'
    expect(task.valid?).to be(false)
    task.due_date = '12/12/2020'
    expect(task.valid?).to be(true)
  end

end
