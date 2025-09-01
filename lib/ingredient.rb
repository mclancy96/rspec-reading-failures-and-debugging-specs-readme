class Ingredient
  attr_reader :name, :quantity, :unit

  def initialize(name, quantity, unit)
    @name = name
    @quantity = quantity
    @unit = unit
  end

  def ==(other)
    other.is_a?(Ingredient) &&
      name == other.name &&
      quantity == other.quantity &&
      unit == other.unit
  end
end
