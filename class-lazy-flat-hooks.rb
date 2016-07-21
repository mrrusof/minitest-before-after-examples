require 'minitest/autorun'
require 'minitest/hooks/default'

class ClassLazyFlatHooks < Minitest::HooksSpec

  let(:expensive) do
    @@expensive ||= begin
                     puts 'executing something expensive'
                     'woah! expensive!'
                   end
  end

  after(:all) do
    puts "cleaning expensive value: #{@@expensive}"
    puts "cleaning expensive value: #{expensive}"
  end

  it 'test1' do
    puts "test1: #{expensive}"
  end

  it 'test2' do
    puts "test2: #{expensive}"
  end

end
