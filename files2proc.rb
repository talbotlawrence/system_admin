#connect to the remote server
#cd in to the proper directory--------------------
#if any files exist in the directory----------------
#store existing files into an array-----------------
#loop through each of them
#determine how long each file has been sitting in the directory
#if longer than five minutes
#then send an email to talbotlawrence@eftsource.com
#puts "All clear!!"
#puts "These files are old: #{file_list}, #{age_of_file}

class AgeOfFiles

Dir.chdir("/home/talbotlawrence/Desktop/tempin/filestoprocess")
#file_list = Dir.glob('*')

Dir.foreach(".") do |f|
  next if f == '.' or f == '..'
  time_now = Time.now
  original_time = File.mtime(f)
  age_of_file = ((time_now - original_time) / 60).to_i
    if age_of_file >= 5 
      then puts "WARNING: #{f} is #{age_of_file} minutes old---------------------MOVE YOUR ASS!!!!!!"
    else puts "All clear: #{f} is still young at #{age_of_file} minute(s) old!"
  end
end

end
