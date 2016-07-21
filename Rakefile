require 'rake'
require 'rake/testtask'

task :default => [:test]

Rake::TestTask.new do |t|
  t.pattern = '*.rb'
end

Dir.glob('*.rb').each do |f|
  Rake::TestTask.new f.to_sym do |t|
    t.pattern = f
  end
end
