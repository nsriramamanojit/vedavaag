class AccountsController < ApplicationController
  before_filter :recent_items, :require_user
  filter_access_to :all

  def index
    @accounts = Account.search(params[:search]).paginate(:page => page, :per_page => per_page)

  end

  def show
    @account = Account.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @account }
    end
  end

  def new
    @account = Account.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @account }
    end
  end

  def edit
    @account = Account.find(params[:id])
  end

  def create
    @account = Account.new(params[:account])

    respond_to do |format|
      if @account.save
        format.html { redirect_to(@account, :notice => 'Account was successfully created.') }
        format.xml { render :xml => @account, :status => :created, :location => @account }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @account = Account.find(params[:id])

    respond_to do |format|
      if @account.update_attributes(params[:account])
        format.html { redirect_to(@account, :notice => 'Account was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @account = Account.find(params[:id])
    @account.destroy

    respond_to do |format|
      format.html { redirect_to(accounts_url) }
      format.xml { head :ok }
    end
  end

  def approve
    @account = Account.find(params[:id])
    @account.update_attribute('status', @account.status ? false : true)
    respond_to do |format|
      format.js
    end

  end

  def upload
    render
  end

  def csv_import
    require 'csv'
    csv_file = params[:file]
    n=0
    CSV.new(csv_file.tempfile, :col_sep => ",").each do |row|
      transaction = Account.create do |tr|
        tr.name =row[0]
        tr.account_number = row[1]
        tr.bank_name = row[2]
        tr.branch_name = row[3]
      end
     transaction.save
      n = n + 1
    end
    flash[:notice]= "#{n} Accounts are imported successfully."
    respond_to do |format|
      format.html { redirect_to(accounts_path) }
      format.xml { head :ok }
    end
  end
  def export
    @accounts = Account.all
    html = render_to_string :layout => false
    kit = PDFKit.new(html, :page_size => 'A4')
    send_data(kit.to_pdf, :filename => "Account_Statement.pdf", :type => 'application/pdf')

  end

  ########################################################
  private
  def recent_items
    @recent = Account.recent
  end

end
