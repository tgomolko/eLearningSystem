module ConversationsHelper
  def mailbox_section(title, current_box, opts = {})
    opts[:class] = opts.fetch(:class, '')
    opts[:class] += 'active' if title.downcase == current_box
    content_tag :li, link_to(title.capitalize, conversations_path(box: title.downcase)), opts
  end

  def get_conversation_messages(conversation)
    conversation.receipts_for(current_user).order("created_at ASC")
  end
end
