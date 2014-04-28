
# Small Script to Send a timed E-mail with ruby

require 'net/smtp'

## Wait =)
hour   = 0
minute = 33

while (Time.now.min<minute && Time.now.hour!=hour)
	puts "#{Time.now.hour}:#{Time.now.min}"
	sleep 60
end
## And Go ^^

msg = "Subject: title\n\n

content... blah blah blah
"

smtp = Net::SMTP.new 'smtp.gmail.com', 587
smtp.enable_starttls

reciever = "reciever@email.com"

smtp.start("Tes", "name@gmail.com", "password", :login) do # adjust
	smtp.send_message(msg, "name@gmail.com", reciever)
end

puts "Message Sent =)"
