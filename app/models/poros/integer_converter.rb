class IntegerConverter
  def self.convert(value)
    length = value.digits.length
    index = length - 2

    to_string = value.to_s
    to_string.insert(index, '.').to_f
  end
end
