require 'minitest/autorun'

describe "spec file, lazy evaluation, flat describe block" do

  def self.expensive
    @expensive ||= begin
                     puts 'executing something expensive'
                     'woah! expensive!'
                   end
  end

  Minitest.after_run do
    puts "cleaning expensive value: #{@expensive}"
    puts "cleaning expensive value: #{expensive}"
    puts "cleaning expensive value: #{self.expensive}"
  end

  it 'test1' do
    puts "test1: #{self.class.expensive}"
  end

  it 'test2' do
    puts "test2: #{self.class.expensive}"
  end

end
