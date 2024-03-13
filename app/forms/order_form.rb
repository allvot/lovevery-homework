class OrderForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  # ATTRIBUTES
  # ---------------------

  attribute :product_id, :integer
  attribute :shipping_name, :string
  attribute :child_full_name, :string
  attribute :gift, :boolean
  attribute :child_birthdate, :date
  attribute :parent_full_name, :string
  attribute :address, :string
  attribute :zipcode, :string
  attribute :credit_card_number, :string
  attribute :expiration_month, :string
  attribute :expiration_year, :string
  attribute :paid, :boolean

  # VALIDATIONS
  # ---------------------

  validates :product, presence: { message: "must exit" }
  validates :parent_full_name, presence: true, if: :gift?
  validates :address, :zipcode, presence: true, unless: :gift?
  validates :credit_card_number, :expiration_month, :expiration_year, presence: true

  # METHODS
  # ---------------------

  def gift?
    gift.to_b
  end

  def product
    @product ||= Product.find(product_id)
  end

  def product=(product)
    @product = product
    product_id = product&.id
  end
end
