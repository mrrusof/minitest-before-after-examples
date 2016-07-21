require 'minitest/autorun'

describe "spec file, eager evaluation, nested describe block" do

  $expensive = begin
                 puts 'executing something expensive'
                 'woah! expensive!'
               end

  def self.expensive
    $expensive
  end

  Minitest.after_run do
    puts "cleaning expensive value: #{$expensive}"
    puts "cleaning expensive value: #{expensive}"
    puts "cleaning expensive value: #{self.expensive}"
  end

  describe 'describe1' do
    it 'test1' do
      puts "test1: #{self.class.expensive}"
    end

    it 'test2' do
      puts "test2: #{self.class.expensive}"
    end
  end

  describe 'describe2' do
    it 'test3' do
      puts "test3: #{self.class.expensive}"
    end

    it 'test4' do
      puts "test4: #{self.class.expensive}"
    end
  end

end
