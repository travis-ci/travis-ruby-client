module Travis
  module Client
    module Resource
      class Pagination < Struct.new(:data)
        def count
          data[:count]
        end

        def offset
          data[:offset] || 0
        end

        def last_page?
          data.fetch(:is_last, true)
        end

        def first_page?
          data.fetch(:is_first, true)
        end

        def next_page(opts = {})
          data[:next]&.fetch(opts)
        end

        def prev_page
          data[:next]&.fetch
        end

        def first_page
          data[:next]&.fetch
        end

        def last_page
          data[:next]&.fetch
        end
      end
    end
  end
end
