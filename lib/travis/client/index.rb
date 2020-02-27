require 'digest/sha1'
require 'fileutils'
require 'json'
require 'memoize'
require 'travis/client/helper'

module Travis
  module Client
    class Index < Struct.new(:session, :opts)
      include Helper::Hash, Memoize

      MISSING = {
        cache: {
          '@type': 'resource',
          actions: [],
          attributes: %w(repository_id size name branch last_modified)
        },
        caches: {
          '@type': 'resource',
          actions: {
            find: [
              {
                '@type': 'template',
                request_method: 'GET',
                uri_template: '/repo/{repository.id}/caches{?branch,caches.branch,caches.match,include,match}'
              },
              {
                '@type': 'template',
                request_method: 'GET',
                uri_template: '/repo/{repository.slug}/caches{?branch,caches.branch,caches.match,include,match}'
              }
            ],
            'delete': [
              {
                '@type': 'template',
                request_method: 'DELETE',
                uri_template: '/repo/{repository.id}/caches'
              },
              {
                '@type': 'template',
                request_method: 'DELETE',
                uri_template: '/repo/{repository.slug}/caches'
              }
            ]
          },
          attributes: [
            'caches',
          ],
          representations: {
            standard: [
              'branch',
              'match'
            ]
          }
        },
        pending: {
          '@type': 'state',
          attributes: %w(state_change resource_type request build job)
        },
        stage: {
          '@type': 'resource',
          actions: [],
          attributes: %w(id name number state started_at finished_at)
        },
        tag: {
          '@type': 'resource',
          actions: [],
          attributes: %w(name last_build_id)
        },
        warning: {
          '@type': 'message',
          actions: [],
          attributes: %w(message warning_type)
        }
      }

      def config
        data[:config]
      end

      def hash
        @hash ||= "Ix#{Digest::SHA1.hexdigest(read)[0..5]}"
      end

      def resources
        data[:resources].merge(MISSING)
      end

      def errors
        data[:errors]
      end

      def refresh
        store(JSON.dump(fetch))
      end

      private

        def data
          symbolize(JSON.parse(read))
        end
        memoize :data

        def exists?
          File.exists?(path)
        end

        def read
          refresh unless exists?
          File.read(path)
        end
        memoize :read

        def fetch
          session.request(:GET, '/', {}, load: false)
        end

        def store(data)
          FileUtils.mkdir_p(File.dirname(path))
          File.write(path, data)
        end

        def path
          @path ||= "#{opts.fetch(:path)}/index/#{filename}.json"
        end

        def filename
          session.endpoint.host.to_s.gsub(/\W/, '_').gsub(/__+/, '_')
        end
    end
  end
end
