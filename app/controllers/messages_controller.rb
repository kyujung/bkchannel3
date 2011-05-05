class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.xml
  def index
    @users = User.where(:nickname => session[:user_nickname]).first
    @message = Message.new
    @messages = Message.where(:receiver => [session[:user_nickname], 'public']).all(:order => 'created_at ASC')
    @seats = Seat.all(:order => 'seatno ASC')
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  # GET /messages/1
  # GET /messages/1.xml
  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.xml
  def create
    txt = params[:message][:body]
    recver = params[:message][:receiver]
    @users = User.where(:nickname => session[:user_nickname]).first
    @message = Message.new(:nickname => session[:user_nickname], :body => txt, 
                           :receiver => recver, :created_at => Time.now)
    
    if ((Message.where(:receiver => [session[:user_nickname], 'public']).all.count) > 4) 
        @message2 = Message.where(:receiver => [session[:user_nickname], 'public']).find(:first)
        @message2.destroy
     end

    respond_to do |format|
      if @message.save
         format.html { redirect_to(messages_url, :notice => 'Message was successfully created.') }
         format.js
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end


  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    
    respond_to do |format|
    format.html { redirect_to(messages_url) }
    format.js
    end
  end
end