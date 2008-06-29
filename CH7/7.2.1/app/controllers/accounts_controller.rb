class AccountsController < ApplicationController

  QUEUE_NAME = 'ACCOUNTS.CREATED'

  def create
    @account = Account.new(params['account'])
    if @account.save
      # Created, send user back to main page.
      redirect_to root_url
    else
      # Error, show the registration form with error message
      render :action=>'new'
    end
  end

private

  def wmq_account_created(account)
    attributes = account.attributes.slice('first_name', 'last_name', 'company', 'email')
    attributes.update(:application=>request.host)
    xml = attributes.to_xml(:root=>'account')

    config = self.class.wmq_config
    WMQ::QueueManager.connect(config) do |qmgr|
      message = WMQ::Message.new
      message.data = xml
      qmgr.put :q_name=>QUEUE_NAME, :message=>message
      logger.info "WMQ.put: message #{message.descriptor[:msg_id]} in #{QUEUE_NAME}"
    end
  end

end
