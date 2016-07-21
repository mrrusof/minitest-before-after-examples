require 'minitest/autorun'
require 'minitest/hooks'

class ClassEagerNestedHooks < Minitest::HooksSpec

  before(:all) do
    puts 'executing something expensive'
    @expensive = 'woah! expensive!'
  end

  after(:all) do
    puts "cleaning expensive value: #{@expensive}"
  end

  describe 'describe1' do
    it 'test1' do
      puts "test1: #{@expensive}"
    end

    it 'test2' do
      puts "test2: #{@expensive}"
    end
  end

  describe 'describe2' do
    it 'test3' do
      puts "test3: #{@expensive}"
    end

    it 'test4' do
      puts "test4: #{@expensive}"
    end
  end

end
