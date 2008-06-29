class WorkOrdersController < ApplicationController

  def create
    @work_order = WorkOrder.new(params[:work_order])
    @work_order.save!
    
    mq = ReliableMsg::Queue.new('orders_queue')
    message = WorkOrderMessage.new(params[:work_order])
    mq.put message
    
    flash[:notice] = "Work order submitted."
    redirect_to(work_orders_path)
  rescue ActiveRecord::RecordInvalid
    render :action => 'new'
  end

end
