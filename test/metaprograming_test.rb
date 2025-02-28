require 'tldr'
require_relative '../lib/ac_object'

class MetaprogramingTest < TLDR
  def test_access_options
    item = AcObject.new(meli_hash)
    assert_equal 'MLB', item.site_id
    assert_equal 'MLB', item[:site_id]
    assert_equal 'MLB', item['site_id']
  end

  def test_nesting
    item = AcObject.new(meli_hash)
    first_picture_size = item.pictures.first.size
    assert_equal '500x422', first_picture_size
  end

  def test_no_overides
    troublesome_keys = AcObject.new({ 'class' => 'no dot' })
    assert_equal 'no dot', troublesome_keys[:class]
    assert_equal AcObject, troublesome_keys.class
  end

  def test_input_with_symbol_keys
    skip 'would need active_support, for now parsed json is always text'
    why = AcObject.new({ not_a_string: true })
    assert_equal true, why.not_a_string
  end

  def meli_hash
    {
      'id' => 'MLB1578157865',
      'site_id' => 'MLB',
      'title' => 'Kit C/100 Envelope Embalagem Segurança Envio Correio 20x32',
      'seller_id' => 161_497_576,
      'category_id' => 'MLB270586',
      'official_store_id' => nil,
      'price' => 58.47,
      'base_price' => 58.47,
      'original_price' => nil,
      'currency_id' => 'BRL',
      'initial_quantity' => 1644,
      'sale_terms' => [],
      'buying_mode' => 'buy_it_now',
      'listing_type_id' => 'gold_special',
      'condition' => 'new',
      'permalink' => 'https://produto.mercadolivre.com.br/MLB-1578157865-kit-c100-envelope-embalagem-seguranca-envio-correio-20x32-_JM',
      'thumbnail_id' => '757425-MLB80428682692_112024',
      'thumbnail' => 'http://http2.mlstatic.com/D_757425-MLB80428682692_112024-I.jpg',
      'pictures' => [{ 'id' => '757425-MLB80428682692_112024',
                       'url' => 'http://http2.mlstatic.com/D_757425-MLB80428682692_112024-O.jpg', 'secure_url' => 'https://http2.mlstatic.com/D_757425-MLB80428682692_112024-O.jpg', 'size' => '500x422', 'max_size' => '1200x1014', 'quality' => '' }]
    }
  end
end
