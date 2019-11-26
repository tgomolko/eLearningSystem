class ConversationsController < ApplicationController
  before_action :authenticate_user!, :get_mailbox
  before_action :get_conversation, except: [:index, :empty_trash]
  before_action :get_box, only: :index

  def index
    if @box.eql? "inbox"
      @conversations = @mailbox.inbox
    elsif @box.eql? "sent"
      @conversations = @mailbox.sentbox
    else
      @conversations = @mailbox.trash
    end
    @conversations = @conversations.paginate(page: params[:page], per_page: 5)
  end

  def show ; end

  def reply
    current_user.reply_to_conversation(@conversation, params[:body])
    redirect_to conversation_path(@conversation), notice: t(:reply_sent)
  end

  def destroy
    @conversation.move_to_trash(current_user)
    redirect_to conversations_path, notice: t(:moved_to_trash)
  end

  def restore
    @conversation.untrash(current_user)
    redirect_to conversations_path, notice: t(:conversation_restored)
  end

  def empty_trash
    @mailbox.trash.each do |conversation|
      conversation.receipts_for(current_user).update_all(deleted: true)
    end
    redirect_to conversations_path, notice: t(:trash_cleaned)
  end

  def mark_as_read
    @conversation.mark_as_read(current_user)
    redirect_to conversations_path, notice: t(:mark_as_read)
  end

  private

  def get_mailbox
    @mailbox ||= current_user.mailbox
  end

  def get_conversation
    @conversation = @mailbox.conversations.find(params[:id])
  end

  def get_box
    if params[:box].blank? or !["inbox","sent","trash"].include?(params[:box])
      params[:box] = 'inbox'
    end
    @box = params[:box]
  end
end
