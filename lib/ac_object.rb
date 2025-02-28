class AcObject
  def initialize(parsed_json)
    @values = parsed_json
  end

  def [](key)
    wrapped(key)
  end

  private

  def method_missing(method)
    if respond_to_missing?(method)
      wrapped(method)
    else
      super
    end
  end

  def respond_to_missing?(method, include_private = false)
    @values.key?(method.to_s)
  end

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
