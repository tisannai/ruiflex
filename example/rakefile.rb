require 'rake'

unit = File.basename( Dir.pwd )
comp = "gcc -Wall -std=c11 -g"

task :default => [unit]

task :clean do
    sh "rm -f #{unit}"
    sh "rm -f n_flex.c"
    sh "rm -f n_flex.h"
    sh "rm -f n_flex.l"
end


c_files = [ "main", "n_flex" ]
c_file_names = c_files.map{|i| "#{i}.c"}


file unit => c_file_names do
    sh "#{comp} #{c_file_names.join(' ')} -o #{unit}"
end

file "n_flex.c" => ["n_flex.rb"] do
    sh "../../ruiflex -t -f n_flex.rb"
end

