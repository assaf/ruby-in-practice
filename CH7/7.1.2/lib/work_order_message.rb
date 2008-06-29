class WorkOrderMessage

  attr_accessor :requester, :requested_work, :date_due
  
  def initialize(params)
    raise "Invalid arguments provided." unless params.is_a?(Hash)
    
    @requester = params[:requester]
    @requested_work = params[:requested_work]
    @date_due = params[:date_due]
  end
  
  def unique_id
    "#{@requester.slice(0,5).strip.upcase}-" + 
    "#{@date_due.strftime('%m%d%y')}-#{@requested_work.hash}"
  end
  
  def report!
    puts "Order #{unique_id} received."
    puts "from #{@requester}, due #{@date_due.strftime('%D')}"
    puts "Work requested:"
    puts @requested_work
    puts
  end

end
