require 'intercom'

@intercom = Intercom::Client.new(token: "#{ARGV[0]}")

def unanswered_messages_count
	unanswered_messages = []
	open_convo_list = @intercom.conversations.find_all(:open => true)
	open_convo_list.each do |convo|
		single_convo = @intercom.conversations.find(:id => "#{convo.id}")
		if !single_convo.conversation_parts.empty?	
			author = single_convo.conversation_parts.last.author.class
		  unanswered_messages << single_convo.id if author == Intercom::User || author == Intercom::Contact || author == Intercom::Bot
		else 
			unanswered_messages << single_convo.id
		end
	end
	count = unanswered_messages.length
	count == 0 ? (puts "You have no unanswered conversations!") : (puts "You have #{count} unanswered conversations! Here is a list of ID's of the unanswered conversations:\n")
	 unanswered_messages.each{ |id| puts id }
end

unanswered_messages_count
