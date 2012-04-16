require 'state_machine'

# Adds a generic implementation for sending messages between users
module HasMessages
  extend ActiveSupport::Concern
  
  included do
    has_many  :messages,
                :as => :sender,
                :class_name => 'Message',
                :conditions => {:hidden_at => nil},
                :order => 'messages.created_at DESC'
    has_many  :received_messages,
                :as => :receiver,
                :class_name => 'MessageRecipient',
                :include => :message,
                :conditions => ['message_recipients.hidden_at IS NULL AND messages.state = ?', 'sent'],
                :order => 'messages.created_at DESC'
  end
  
  # Composed messages that have not yet been sent.  These consists of all
  # messages that are currently in the "unsent" state.
  def unsent_messages
    messages.with_state(:unsent)
  end
  
  # Composed messages that have already been sent.  These consists of all
  # messages that are currently in the "queued" or "sent" states.
  def sent_messages
    messages.with_states(:queued, :sent)
  end

  # Returns the most recent message of each thread
  def last_received_message_per_thread
    MessageRecipient.find_all_by_receiver_id(id, :order => 'id desc', :joins => :message, :conditions => 'message_recipients.hidden_at is null', :group => 'COALESCE(original_message_id,messages.id)')
  end
  
  def conversations
    (messages + received_messages.map(&:message)).compact.uniq
  end

  def original_conversations
    conversations.select{ |message| message.original_message_id == nil }
  end

  def find_conversation_by_id(id)
    conversations.select{ |message| message.id == id.to_i }.first
  end

  def unread_messages
    received_messages.select(&:unread?).map(&:message)
  end
end

require 'has_messages/models/message.rb'
require 'has_messages/models/message_recipient.rb'
