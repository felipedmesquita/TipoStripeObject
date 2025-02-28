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

  private

  def wrapped(key)
    maybe_hash = @values[key.to_s]
    case maybe_hash
    when Hash
      AcObject.new(maybe_hash)
    when Array
      maybe_hash.map { AcObject.new(_1) }
    else
      maybe_hash
    end
  end
end
