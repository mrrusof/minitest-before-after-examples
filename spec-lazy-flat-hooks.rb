require 'minitest/autorun'
require 'minitest/hooks/default'

describe "spec file, lazy evaluation, flat describe block, minitest-hooks" do

  def self.expensive
    @expensive ||= begin
                     puts 'executing something expensive'
                     'woah! expensive!'
                   end
  end

  after(:all) do
    puts "cleaning expensive value: #{self.class.expensive}"
  end

  it 'test1' do
    puts "test1: #{self.class.expensive}"
  end

  it 'test2' do
    puts "test2: #{self.class.expensive}"
  end

end
