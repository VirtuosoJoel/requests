class RequestsController < ApplicationController
  
   respond_to :html
  
  def index
    @requests = Request.where( :closed => false )
    respond_to do |format|
      format.html
    end
  end

  def show
    @requests = Request.where( :closed => false )
    render :partial => 'refresh'
  end

  def new
    @request = Request.new
    @request.name = session[:name] if session[:name] 
    render :partial => 'form', :locals => {:request => @request}
  end
  
  def create
    @request = Request.new(params[:request])
    respond_to do |format|
      if @request.save
        session[:name] = params[:name]
        format.js
      else
        format.js { render :partial => 'error' }
      end
    end
  end
  
  def update
    @request = Request.find(params[:id])
    already_closed = @request[:closed]
    respond_to do |format|
      if @request.update_attributes(params[:request])
        #@request.send_complete_email unless already_closed
        format.js
      else
        format.js { render :partial => 'error' }
      end
    end
  end

  def destroy
    @request = Request.find(params[:id])
    respond_to do |format|
      if @request.destroy
        format.js
      else
        format.js { render :partial => 'error' }
      end
    end
  end
  
  def by_date
    date = Date.new( params[:year].to_i, params[:month].to_i, params[:day].to_i )
    @records = Request.where( "DATE(updated_at) = DATE(?)", date ).where( closed: true )
    respond_with( @records )
  end
  
end
