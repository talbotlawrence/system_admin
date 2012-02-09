class AgeOfFiles
require 'fileutils'

Dir.chdir("/home/talbotlawrence/Desktop/tempin/filestoprocess")  
#point attention at the "filestoprocess" directory (above)

Dir.foreach(".") do |f|                                     #step through each file=f       
  next if f == '.' or f == '..'                             #unwanted directories
  time_now = Time.now
  original_time = File.mtime(f)                             #modified times of each file
  age_of_file = ((time_now - original_time) / 60).to_i      #age in minutes, to_i=no decimal
    if age_of_file >= 5
      then FileUtils.copy(f, "/home/talbotlawrence/Desktop/tempin/backup"); 
        FileUtils.move(f, "/home/talbotlawrence/Desktop/tempin");     #drop into production
          puts "Dropped #{f} back into production and backed it up on /home/talbotlawrence/Desktop/tempin/backup/"
      else puts "All clear: #{f} is still young at #{age_of_file} minute(s) old!"
    end
  end
end
#    if age_of_file >= 5 
#      then puts "WARNING: #{f} is #{age_of_file} minutes old---------------------MOVE YOUR ASS!!!!!!"
#    else puts "All clear: #{f} is still young at #{age_of_file} minute(s) old!"
#  end
#end
