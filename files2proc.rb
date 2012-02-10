class AgeOfFiles
require 'fileutils'
require 'net/smtp'

Dir.chdir("/path/to/Directory")  
#point attention at the "filestoprocess" directory (above)

Dir.foreach(".") do |f|                                     #step through each file=f       
  next if f == '.' or f == '..'                             #unwanted directories
  time_now = Time.now
  original_time = File.mtime(f)                             #modified times of each file
  age_of_file = ((time_now - original_time) / 60).to_i      #age in minutes, to_i=no decimal
    if age_of_file >= 5
      then FileUtils.copy(f, "/home/talbot/backup"); 
        FileUtils.move(f, "/home/talbot/Desktop");     #drop into production
          puts "Dropped #{f} back into production and backed it up on /home/talbot/backup/" 
      else puts "All clear: #{f} is still young at #{age_of_file} minute(s) old!"
    end
  end
msg = <<EOF
Subject: URGENT--Files stranded
Message
EOF

smtp = Net::SMTP.new("mail.domain.net", 25)
smtp.start		#previous two lines opens a connection to mail server
smtp.sendmail msg, 'talbot@mail.com', 'talbot@mail.com'
end
