class AcObject
  def initialize(parsed_json)
    @values = parsed_json.transform_keys(&:to_s)
    @values.keys.each do |key|
      define_singleton_method(key) { wrapped(key) } unless respond_to? key
    end
  end

  def [](key)
    wrapped(key)
  end

  def to_s(*_args)
    JSON.pretty_generate(@values)
  end

  def inspect
    id_string = respond_to?(:id) && !id.nil? ? " id=#{id}" : ''
    "#<#{self.class}:0x#{object_id.to_s(16)}#{id_string}> JSON: " +
      JSON.pretty_generate(@values)
  end

  private

  def wrapped(key)
    deep_wrap(@values[key.to_s])
  end

  def deep_wrap(value)
    case value
    when Hash
      AcObject.new(value)
    when Array
      value.map { deep_wrap(_1) }
    else
      value
    end
  end
end
