require 'intercom'

@intercom = Intercom::Client.new(token: "#{ARGV[0]}")

def close_conversations(admin_id)
	puts "Closing your open conversations... be patient!"
	open_conversations = @intercom.conversations.find_all(type: 'admin', id: admin_id, open: true)
	open_conversations.each do |convo|
		@intercom.conversations.reply(:id => convo.id, :type => 'admin', :admin_id => admin_id, :message_type => 'close')
		sleep (0.2)
	end
	puts "It is done!"
end

close_conversations()