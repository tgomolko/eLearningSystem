module ElasticMyAnalyzer
  ES_SETTING = {
    index: {
      number_of_shards: 1
    },
    analysis: {
      filter: {
        my_stopwords: {
          type: 'stop',
          stopwords: 'bmbm'
        },
        mynGram: {
          type: 'ngram',
          min_gram: 3,
          max_gram: 3
        }
      },
      analyzer: {
        my_analyzer: {
          type: 'custom',
          tokenizer: 'standard',
          filter: [
            'lowercase', 'my_stopwords', 'mynGram'
          ]
        }
      }
    }
  }
end
