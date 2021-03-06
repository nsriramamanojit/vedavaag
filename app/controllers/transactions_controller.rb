class TransactionsController < ApplicationController
  before_filter :recent_items, :require_user
  filter_access_to :all
  layout "application", :except => [:show]

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
    @transaction.transaction_number = current_user.project.name.upcase+ '/' + '%03d' % current_user.id.to_s + '/' + Time.now.strftime('%m%d%H%M%S').to_s

    respond_to do |format|
      if @transaction.save

        #UserMailer.request_mail(@transaction,current_user).deliver

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

    @transaction.payment_date= Time.now
    @transaction.payment_id =current_user.id
    @transaction.fund_status = true


    respond_to do |format|
      if @transaction.update_attributes(params[:transaction])

        if @transaction.request_amount.to_f > params[:transaction][:paid_amount].to_f
          new_request_amount = @transaction.request_amount.to_f - params[:transaction][:paid_amount].to_f
          @new_request = Transaction.new(:request_amount=>new_request_amount,:transaction_date=>Time.now,:name=>@transaction.name,:description=>@transaction.description)
          @new_request.save
        else
          puts "NO"
        end

        format.html { redirect_to(transactions_path, :notice => 'Request was successfully updated.') }
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
    @transaction.update_attribute('approve_date',Time.now)

    respond_to do |format|
      format.js
    end
  end
  def approve_pay
    @transaction = Transaction.find(params[:id])
    @transaction.update_attribute('fund_status', @transaction.fund_status ? false : true)
    @transaction.update_attribute('payment_by',current_user .id)
    @transaction.update_attribute('payment_date',Time.now)

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
