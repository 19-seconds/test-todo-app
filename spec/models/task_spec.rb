require 'rails_helper'

RSpec.describe Task, type: :model do
  describe '#toggle_complete!' do 
    it "should switch complete to false if it began as true" do
      task = Task.create(complete: true)
      task.toggle_complete!
      expect(task.complete).to eq(false)
    end

    it "should switch complete to true if it began as false" do 
      task = Task.create(complete: false)
      task.toggle_complete!
      expect(task.complete).to eq(true)
    end
  end

  describe '#overdue?' do 
    it 'should return true if deadline is earlier than now' do
      deadline = Time.now - 1.hour 
      task = Task.create(deadline:deadline)
      expect(task.overdue?).to eq(true)
    end

    it 'should return false if deadline is earlier than now' do
      deadline = Time.now + 1.hour 
      task = Task.create(deadline:deadline)
      expect(task.overdue?).to eq(false)
    end
  end

  describe '#increment_priority!' do 
    it 'should return plus on if less than 10' do 
      task = Task.create(priority: 2)
      task.increment_priority!
      expect(task.priority).to eq(3)
    end

     it 'shouldn\'t increment above 10' do 
      task = Task.create(priority: 10)
      task.increment_priority!
      expect(task.priority).to eq(10)
    end
  end

  describe '#snooze_hour!' do 
    it 'should add an hour to the current deadline' do 
      deadline = DateTime.new(2017, 3, 7)
      task = Task.create(deadline: deadline)
      task.snooze_hour!
      expect(task.deadline).to eq(deadline + 1.hour)
    end
  end
end
