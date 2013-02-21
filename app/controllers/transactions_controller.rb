class TransactionsController < ApplicationController
  before_filter :recent_items, :require_user
  filter_access_to :all
  layout "application", :except => [:show, :edit]

  def index
    @transactions = Transaction.search(params[:search]).paginate(:page => page, :per_page => per_page) if has_any_role? :sa,:admin, :manager
    @transactions = Transaction.where(:requested_by=>current_user.id).search(params[:search]).paginate(:page => page, :per_page => per_page)  if has_role? (:employee)

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @transactions }
    end
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
    @transaction = Transaction.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @transaction }
    end
  end

  def edit
    @transaction = Transaction.find(params[:id])
  end

  def create
    @transaction = Transaction.new(params[:transaction])
    @transaction.transaction_date= Time.now
    @transaction.requested_by =current_user.id
    respond_to do |format|
      if @transaction.save
        format.html { redirect_to(transactions_path, :notice => 'Request was successfully created.') }
        format.xml { render :xml => @transaction, :status => :created, :location => @transaction }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @transaction.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @transaction = Transaction.find(params[:id])

    respond_to do |format|
      if @transaction.update_attributes(params[:transaction])
        format.html { redirect_to(@transaction, :notice => 'Transaction was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @transaction.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to(transactions_url) }
      format.xml { head :ok }
    end
  end

  def approve
    @transaction = Transaction.find(params[:id])
    @transaction.update_attribute('approve_status', @transaction.approve_status ? false : true)
    @transaction.update_attribute('approved_by',current_user .id)
    respond_to do |format|
      format.js
    end
  end
  def approve_pay
    @transaction = Transaction.find(params[:id])
    @transaction.update_attribute('fund_status', @transaction.fund_status ? false : true)
    @transaction.update_attribute('payment_by',current_user .id)

    respond_to do |format|
      format.js
    end
  end

  ########################################################
  private
  def recent_items
    @recent = Transaction.recent if has_any_role? :admin,:sa,:manager
    @recent = Transaction.recent.where(:requested_by=>current_user.id) if has_role? (:employee)
  end

end
