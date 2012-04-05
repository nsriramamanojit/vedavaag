class TransactionsController < ApplicationController
  before_filter :recent_items, :require_user

  def index
    @transactions = Transaction.search(params[:search]).paginate(:page => page, :per_page => per_page)

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @transactions }
    end
  end

  def show
    @transaction = Transaction.find(params[:id])
    @records = Deal.where(:transaction_id => @transaction.id).paginate(:page => page, :per_page => per_page)
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
    @transaction.date = Time.now
    respond_to do |format|
      if @transaction.save
        file = params[:transaction][:attachment]
        book = Spreadsheet.open(file.tempfile)
        sheet1 = book.worksheet 0
        sheet1.each 1 do |row|
          transaction = Deal.create do |tr|
            tr.transaction_id = @transaction.id
            tr.name = row[0]
            tr.account_number = row[1].to_i
            tr.amount = row[3]
            tr.branch_code = "%05d" % row[2]
          end
          transaction.save
        end
        format.html { redirect_to(transactions_path, :notice => 'Transaction was successfully created.') }
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
    @transaction.update_attribute('status', @transaction.status ? false : true)
    respond_to do |format|
      format.js
    end
  end

  def text_report
    @transaction = Transaction.find(params[:id])
    @records = Deal.where(:transaction_id => @transaction.id)
    total = @records.sum(:amount)
    require 'csv'
    outfile = @transaction.name + ".txt"
    csv_data = CSV.generate do |csv|
      csv<<[@transaction.transfer_account, @transaction.transfer_branch_code, Time.now.strftime("%d/%m/%Y"), "%.2f"%total, nil, @transaction.transfer_account, @transaction.name]
      @records.each do |tr|
        csv<<[tr.account_number, tr.branch_code, Time.now.strftime("%d/%m/%Y"), nil, "%.2f"% tr.amount, tr.account_number, @transaction.name]
      end
    end
    send_data csv_data,
              :type => 'text/plain; charset=UTF-8',
              :disposition => "attachment; filename=#{outfile}"
  end

  ########################################################
  private
  def recent_items
    @recent = Transaction.recent
  end

end
