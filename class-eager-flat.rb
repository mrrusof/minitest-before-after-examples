require 'minitest/autorun'

class ClassEagerFlat < Minitest::Spec

  @@expensive = begin
                  puts 'executing something expensive'
                  'woah! expensive!'
                end

  Minitest.after_run do
    puts "cleaning expensive value: #{@@expensive}"
  end

  it 'test1' do
    puts "test1: #{@@expensive}"
  end

  it 'test2' do
    puts "test2: #{@@expensive}"
  end

end
