# frozen_string_literal: true

module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    settings index: { number_of_shards: 1 } do
      mapping dynamic: false do
        indexes :body, analyzer: 'english'
        indexes :chat_ref
      end
    end

    def self.search(query, ref)
      puts query, ref, "*#{query}*"
      __elasticsearch__.search(
        {
          # query: {
          #   bool: {
          #     must: [
          #       {
          #         multi_match: {
          #           query: query,
          #           fields: [:body],
          #           fuzziness: 'AUTO'
          #         }
          #       },
          #       {
          #         match_phrase: {
          #           chat_ref: {
          #             query: ref
          #           }
          #         }
          #       }
          #     ]
          #   }
          # }

          query: {
            bool: {
              must: [
                {
                  query_string: {
                    query: "*#{query.gsub!(/\A"|"\Z/, '')}*",
                    fields: [:body]
                  }
                },
                {
                  match_phrase: {
                    chat_ref: {
                      query: ref
                    }
                  }
                }
              ]
            }
          }
        }
      )
    end
  end
end
