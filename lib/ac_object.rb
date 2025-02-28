class AcObject
  def initialize(parsed_json)
    @values = parsed_json
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
    maybe_hash = @values[key.to_s]
    case maybe_hash
    when Hash
      AcObject.new(maybe_hash)
    when Array
      deep_wrap(maybe_hash)
    else
      maybe_hash
    end
  end

  def deep_wrap(array)
    array.map do |item|
      case item
      when Hash
        AcObject.new(item)
      when Array
        deep_wrap(item)
      else
        item
      end
    end
  end
end
