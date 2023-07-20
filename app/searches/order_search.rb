# frozen_string_literal: true

# OrderSearch
# class OrderSearch
#   DEFAULT_PER_PAGE = 100
#   DEFAULT_PAGE = 0

#   def initialize(per_page, page, seller, customer,
#                  start_date, end_date, product_code, city, state)
#     @per_page = per_page || DEFAULT_PER_PAGE
#     @page = page || DEFAULT_PAGE
#     @seller = seller
#     @customer = customer
#     @start_date = start_date
#     @end_date = end_date
#     @product_code = product_code
#     @city = city
#     @state = state
#   end

#   def search
#     [pagination, lower_limit, upper_limit,
#      city_match, state_match, seller_match,
#      customer_match].compact.reduce(:merge)
#   end

#   private

#   def orders_index
#     OrdersIndex
#   end

#   def pagination
#     orders_index.limit(@per_page).offset(@page * @per_page)
#   end

#   def lower_limit
#     orders_index.filter(range: { created_at: { gte: @start_date } }) if @start_date
#   end

#   def upper_limit
#     orders_index.filter(range: { created_at: { lte: @end_date } }) if @end_date
#   end

#   def product_code_match
#     orders_index.query(fuzzy: { products: { code: @product_code }}) if @product_code
#   end

#   def city_match
#     orders_index.query(match_phrase_prefix: { city: @city }) if @city
#   end

#   def state_match
#     orders_index.query(match_phrase_prefix: { state: @state }) if @state
#   end

#   def seller_match
#     orders_index.query(match_phrase_prefix: { seller: @seller }) if @seller
#   end

#   def customer_match
#     orders_index.query(match_phrase_prefix: { customer: @customer }) if @customer
#   end
# end

# OrderSearch
class OrderSearch
  DEFAULT_PER_PAGE = 100
  DEFAULT_PAGE = 0

  def initialize(per_page, page, seller, customer,
                 start_date, end_date, product_code, city, state)
    @per_page = per_page || DEFAULT_PER_PAGE
    @page = page || DEFAULT_PAGE
    @seller = seller
    @customer = customer
    @start_date = start_date
    @end_date = end_date
    @product_code = product_code
    @city = city
    @state = state
    @conditions = @params = []
  end

  def search
    date_limits
    city_match
    state_match
    seller_match
    customer_match

    return orders, @per_page, @page
  end

  private

  def orders
    Order.includes(
      :products, :seller, :customer, :city, :state
    ).references(
      :products, :seller, :customer, :city, :state
    ).where(@conditions.join(' AND '), *@params).limit(@per_page).offset(@page * @per_page)
  end

  def date_limits
    if @start_date && @end_date
      @conditions << 'created_at BETWEEN ? AND ?'
      @params << Date.parse(@start_date).beginning_of_day
      @params << Date.parse(@end_date).end_of_day
    elsif @start_date && @end_date.nil?
      @conditions << 'created_at > ?'
      @params << Date.parse(@start_date).beginning_of_day
    elsif @start_date.nil? && @end_date
      @conditions << 'created_at < ?'
      @params << Date.parse(@end_date).end_of_day
    end
  end

  def product_code_match
    if @product_code
      @conditions << 'products.code LIKE ?'
      @params << "%#{@product_code}%"
    end
  end

  def city_match
    if @city
      @conditions << 'city.name LIKE ?'
      @params << "%#{@city}%"
    end
  end

  def state_match
    if @state
      @conditions << 'state.name LIKE ?'
      @params << "%#{@state}%"
    end
  end

  def seller_match
    if @seller
      @conditions << 'seller.name LIKE ?'
      @params << "%#{@seller}%"
    end
  end

  def customer_match
    if @customer
      @conditions << 'customer.email LIKE ?'
      @params << "%#{@customer}%"
    end
  end
end
