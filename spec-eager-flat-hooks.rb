require 'minitest/autorun'
require 'minitest/hooks/default'

describe "spec file, eager evaluation, flat describe block, minitest-hooks" do

  before(:all) do
    puts 'executing something expensive'
    @expensive = 'woah! expensive!'
  end

  after(:all) do
    puts "cleaning expensive value: #{@expensive}"
  end

  it 'test1' do
    puts "test1: #{@expensive}"
  end

  it 'test2' do
    puts "test2: #{@expensive}"
  end

end
