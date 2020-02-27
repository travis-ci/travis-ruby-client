require 'travis/client/resource/entity'
require 'travis/client/resource/pagination'

module Travis
  module Client
    module Resource
      class Collection < Entity
        include Enumerable
        extend Forwardable

        def_delegators :pagination, :count, :offset, :first_page?,
          :last_page?, :first_page, :prev_page, :next_page, :last_page

        def each(&block)
          return enum_for(:each) unless block
          all.each(&block)
          self
        end

        def all
          all = page
          all += next_page(pages: pages - 1).to_a if pages > 1
          all
        end
        alias to_a all

        def size
          count || page.size
        end

        def page
          Array(data[collection_key])
        end

        def collection_key
          @collection_key ||= begin
            session.fetch(href) if data.keys.all? { |key| meta?(key) }
            data.keys.detect { |key| collection?(key) }
          end
        end

        def collection?(key)
          !meta?(key) && self[key].is_a?(Array)
        end

        def meta?(key)
          key.to_s.start_with?('@')
        end

        def paginates?
          !!data[:@pagination]
        end

        def pages
          opts.fetch(:pages, 1)
        end

        def pagination
          @pagination ||= Pagination.new(data[:@pagination] || {})
        end
      end
    end
  end
end
