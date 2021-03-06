require 'csv'
require 'date'
require 'bigdecimal'
require 'sales_engine/database'
require 'sales_engine/merchant'
require 'sales_engine/customer'
require 'sales_engine/item'
require 'sales_engine/invoice'
require 'sales_engine/invoice_item'
require 'sales_engine/transaction'

module SalesEngine

  CSV_OPTIONS         = {:headers => true, :header_converters => :symbol}
  MERCHANT_DATA       = "data/merchants.csv"
  CUSTOMER_DATA       = "data/customers.csv"
  ITEM_DATA           = "data/items.csv"
  INVOICE_DATA        = "data/invoices.csv"
  INVOICE_ITEMS_DATA  = "data/invoice_items.csv"
  TRANSACTION_DATA    = "data/transactions.csv"

  def self.startup
    load_customers
    load_items
    load_transactions
    load_invoice_items
    load_merchants
    load_invoices
  end

  def self.load_merchants
    merch_file = CSV.open(MERCHANT_DATA, CSV_OPTIONS)
    Database.instance.merchants = merch_file.collect { |m| Merchant.new(m) }
    puts "Merchants loaded."
  end

  def self.load_customers
    cust_file = CSV.open(CUSTOMER_DATA, CSV_OPTIONS)
    Database.instance.customers = cust_file.collect { |c| Customer.new(c) }
    puts "Customers loaded."
  end

  def self.load_items
    items_file = CSV.open(ITEM_DATA, CSV_OPTIONS)
    Database.instance.items = items_file.collect { |i| Item.new(i) }
    puts "Items loaded."
  end

  def self.load_invoices
    inv_file = CSV.open(INVOICE_DATA, CSV_OPTIONS)
    Database.instance.invoices = inv_file.collect { |i| Invoice.new(i) }
    puts "Invoices loaded."
  end

  def self.load_invoice_items
    ii_file = CSV.open(INVOICE_ITEMS_DATA, CSV_OPTIONS)
    Database.instance.invoice_items = ii_file.collect { |i| InvoiceItem.new(i) }
    puts "Invoice items loaded."
  end

  def self.load_transactions
    t_file = CSV.open(TRANSACTION_DATA, CSV_OPTIONS)
    Database.instance.transactions = t_file.collect { |t| Transaction.new(t) }
    puts "Transactions loaded."
  end
end