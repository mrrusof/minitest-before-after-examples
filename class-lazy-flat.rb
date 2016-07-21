require 'minitest/autorun'

class ClassLazyFlat < Minitest::Spec

  let(:expensive) do
    @@expensive ||= begin
                      puts 'executing something expensive'
                      'woah! expensive!'
                    end
  end

  Minitest.after_run do
    puts "cleaning expensive value: #{@@expensive}"
  end

  it 'test1' do
    puts "test1: #{expensive}"
  end

  it 'test2' do
    puts "test2: #{expensive}"
  end

end
