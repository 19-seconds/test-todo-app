require 'rails_helper'

RSpec.describe List, type: :model do
  describe '#complete_all_tasks!' do
    it 'should mark all tasks from the list as complete' do
      list = List.create(name: "Chores")
      Task.create(complete: false, list_id: list.id, name: "Take out trash")
      Task.create(complete: false, list_id: list.id, name: "Mow the lawn")
      list.complete_all_tasks!
      list.tasks.each do |task|
        expect(task.complete).to eq(true)
      end
    end
  end

  describe '#snooze_all_tasks!' do
    it 'should delay all deadlines by one hour' do
      list = List.create(name: "Chores")
      deadline_one = Time.new(1999, 12, 31)
      deadline_two = Time.new(2018, 6, 30)
      Task.create(deadline: deadline_one, list_id: list.id, name: "Take out trash")
      Task.create(deadline: deadline_two, list_id: list.id, name: "Mow the lawn")
      list.snooze_all_tasks!
      expect(list.tasks.first.deadline).to eq(deadline_one + 1.hour)
      expect(list.tasks.second.deadline).to eq(deadline_two + 1.hour)
    end
  end

  describe '#incomplete_tasks' do
    it 'return all tasks that are complete equal to false' do
      list = List.create(name: "Chores")
      Task.create(complete: false, list_id: list.id, name: "Take out trash")
      Task.create(complete: false, list_id: list.id, name: "Mow the lawn")
      Task.create(complete: true, list_id: list.id, name: "Feed the cat")
      incomplete_tasks = list.incomplete_tasks
      incomplete_tasks.each do |task|
        expect(task.complete).to eq(false)
      end
      expect(incomplete_tasks.length).to eq(2) 
    end
  end

  describe '#total_duration' do
    it "should give the sum of all task\'s duration" do
      list = List.create(name: "Chores")
      Task.create(duration: 50, list_id: list.id)
      Task.create(duration: 100, list_id: list.id)
      expect(list.total_duration).to eq(150)
    end
  end
end
