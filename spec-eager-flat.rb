require 'minitest/autorun'

describe "spec file, eager evaluation, flat describe block" do

  @expensive = begin
                 puts 'executing something expensive'
                 'woah! expensive!'
               end

  def self.expensive
    @expensive
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
