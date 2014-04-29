
# Check if mail has landed in spam folder
# an unfinished test of some idea I had

require 'mail'

class MailProvider

	# hmmm...

end

class Gmail < MailProvider

	def self.setup(name,password)
		Mail.defaults do
		  retriever_method :imap, :address    => "imap.gmail.com",
		                          :port       => 993,
		                          :user_name  => name,
		                          :password   => password,
		                          :enable_ssl => true
		end
	end


	def self.check(subject)
		begin
			spam  = Mail.find(:mailbox => '[Gmail]/Spam', :keys => "SUBJECT \""+subject+"\"")
			inbox = Mail.find(:mailbox => 'INBOX', 		  :keys => "SUBJECT \""+subject+"\"")
		rescue
			raise 'Unable to Access Mailbox (Gmail/IMAP) for ['+subject+']'
		end

		raise 'Unique Mail Expected for ['+subject+']' if (spam+inbox).length > 1

		return :not_recieved if spam.empty? && inbox.empty?
		return :inbox 		 if !inbox.empty?
		return :spam  		 if !spam.empty?
	end

end

# Example Use
Gmail.setup('email@gmail.com','password')
puts Gmail.check('doesnt exist') # -> :not_recieved
