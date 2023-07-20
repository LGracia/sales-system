class OrdersIndex < Chewy::Index
  settings analysis: {
    filter: {
      ngram: {
        type: 'nGram',
        min_gram: 1,
        max_gram: 50,
        token_chars: [ 'letter', 'digit']
      }
    },
    tokenizer: {
      ngram_tokenizer: {
        type: 'nGram',
        min_gram: 1,
        max_gram: 50,
        token_chars: [ 'letter', 'digit', 'punctuation', 'symbol']
      }
    },
    analyzer: {
      ngram: {
        tokenizer: 'ngram_tokenizer',
        filter: ['lowercase', 'asciifolding']
      },
      lowerascii_search: {
        tokenizer: 'whitespace',
        filter: ['lowercase', 'asciifolding']
      }
    }
  }

  index_scope Order.includes(:seller, :customer, :products, :city, :state)
  field :seller, index_analyzer: 'ngram_tokenizer', search_analyzer: 'lowerascii_search', value: ->(order) { order.seller.name }
  field :customer, value: ->(order) { order.customer.email }
  field :created_at
  field :city, value: ->(order) { order.city.name }
  field :state, value: ->(order) { order.state.name }
  field :products, type: 'nested' do
    field :name
    field :code
  end
end
