class StatesController < ApplicationController
  before_filter :recent_items, :require_user
  filter_access_to :all
  layout "application", :except => [:show, :edit]

  # GET /states
  # GET /states.xml
  def index
    @states = State.search(params[:search]).paginate(:page => page, :per_page => per_page).order("name ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @states }
    end
  end

  # GET /states/1
  # GET /states/1.xml
  def show
    @state = State.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @state }
    end
  end

  # GET /states/new
  # GET /states/new.xml
  def new
    @state = State.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @state }
    end
  end

  # GET /states/1/edit
  def edit
    @state = State.find(params[:id])
  end

  # POST /states
  # POST /states.xml
  def create
    @state = State.new(params[:state])

    respond_to do |format|
      if @state.save
        format.html { redirect_to(states_url, :notice => 'State was successfully created.') }
        format.xml  { render :xml => @state, :status => :created, :location => @state }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @state.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /states/1
  # PUT /states/1.xml
  def update
    @state = State.find(params[:id])

    respond_to do |format|
      if @state.update_attributes(params[:state])
        format.html { redirect_to(@state, :notice => 'State was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @state.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /states/1
  # DELETE /states/1.xml
  def destroy
    @state = State.find(params[:id])
    @state.destroy

    respond_to do |format|
      format.html { redirect_to(states_url) }
      format.xml  { head :ok }
    end
  end
  def approve
    @state = State.find(params[:id])
    @state.update_attribute('status', @state.status ? false : true)
    respond_to do |format|
      format.js
    end
  end

  ########################################################
  private
  def recent_items
    @recent = State.recent
  end

end