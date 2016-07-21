require 'minitest/autorun'

describe "spec file, lazy evaluation, nested describe block" do

  def self.expensive
    $expensive ||= begin
                     puts 'executing something expensive'
                     'woah! expensive!'
                   end
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
