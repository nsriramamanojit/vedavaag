class UsersController < ApplicationController
  layout "application", :except => [:show, :edit]
  before_filter :recent_items, :require_user
  filter_access_to :all

  def index
    @users = User.search(params[:search]).paginate(:page => page, :per_page => per_page)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    @user.password = params[:user][:login]
    @user.login = params[:user][:login].downcase

    respond_to do |format|
      if @user.save
        format.html { redirect_to(users_path, :notice => 'User was successfully created.') }
        format.xml { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  def profile
    @user = current_user
  end
  def update_profile
     @user = current_user
  end
  def profile_update
    @user = current_user
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(profile_user_path(current_user), :notice => 'Profile Updated Successfully.') }
        format.xml { head :ok }
      else
        format.html { render :action => "profile_update" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  def change_password
    @user = current_user
  end

  def password_change
    @user = current_user
    return flash.now[:error] = "Current password is Wrong/Blank" unless @user.valid_password? params[:old_password]
    if params[:password] == params[:password_confirmation] && !params[:password_confirmation].blank?
      @user.password = params[:password]
      if @user.save
        flash.now[:notice] = "Password Changed Successfully."
        #redirect_to profile_user_path(current_user)
      else
        flash.now[:error]= "Password not changed"
      end
    else
      flash.now[:error] = "New Password mismatch"
      @old_password = params[:old_password]
    end
  end

  ########################################################
  private
  def recent_items
    @recent = User.recent
  end

end
