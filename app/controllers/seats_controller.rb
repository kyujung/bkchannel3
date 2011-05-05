class SeatsController < ApplicationController  
  # GET /seats
  # GET /seats.xml
  def index
    @seats = Seat.all(:order => 'seatno ASC')
    @users = User.where(:nickname => session[:user_nickname]).first

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @seats }
    end
  end


  # GET /seats/1
  # GET /seats/1.xml
  def show
   @seat = Seat.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @seat }
    end
  end

  # GET /seats/new
  # GET /seats/new.xml
  def new
    @seat = Seat.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @seat }
    end
  end

  # GET /seats/1/edit
  def edit
    @seat = Seat.find(params[:id])
  end

  # POST /seats
  # POST /seats.xml
  def create
  
    @seat = Seat.new(params[:seat])

    respond_to do |format|
      if @seat.save
        format.html { redirect_to(@seat, :notice => 'Seat was successfully created.') }
        format.xml  { render :xml => @seat, :status => :created, :location => @seat }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @seat.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /seats/1
  # PUT /seats/1.xml
  def update
    @users = User.where(:nickname => session[:user_nickname]).first
    @seat = Seat.find(params[:id])
    
    if @users
      txt = params[:seat][:seatno]
    else
      txt = params[:seat]
    end
    
    @seat2 = Seat.where(:nickname => session[:user_nickname]).first
    if @seat2
      @seat2.update_attributes(:nickname => 'empty')
    end

    respond_to do |format|
    if @users   
      if @seat.update_attributes(:seatno => txt, :nickname => session[:user_nickname])
        format.html { redirect_to(messages_url, :notice => 'Seat was successfully updated.') }
        format.js
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @seat.errors, :status => :unprocessable_entity }
      end
   else   
      if @seat.update_attributes(params[:seat])
        format.html { redirect_to(messages_url, :notice => 'Seat was successfully updated.') }
        format.js
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @seat.errors, :status => :unprocessable_entity }
      end   
    end 
      
   end
  end

  # DELETE /seats/1
  # DELETE /seats/1.xml
  def destroy
    @seat = Seat.find(params[:id])
    @seat.destroy

    respond_to do |format|
      format.html { redirect_to(seats_url) }
      format.xml  { head :ok }
    end
  end
end
