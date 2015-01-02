require 'chef'
require 'uri'
require 'net/http'

module Couchdb
  module Helpers
    ## Options can be body, port, secure, and verify_ssl
    def query_couchdb(urn, verb, host = '127.0.0.1', options = {})
      secure = options[:secure] || false
      port = options[:port] || 5984
      verify_ssl = options[:verify_ssl] || false
      body = options[:body] || {}

      ## Wait for couchdb to become ready
      unless wait_for_couchdb(host, port)
        fail "couchdb port: #{port} not open for host: #{host}"
      end

      scheme = secure ? 'https' : 'http'
      url = "#{scheme}://#{host}"
      uri = URI.join(url, urn)
      Chef::Log.debug("query_couchdb built uri: #{uri}")

      http = Net::HTTP.new(uri.host, port)
      http.use_ssl = secure
      unless verify_ssl
        Chef::Log.debug('verify_ssl is false setting verify to none')
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end

      if body.empty?
        http.send_request(verb.upcase, uri.request_uri)
      else
        http.send_request(verb.upcase,
                          uri.request_uri,
                          JSON.generate(body),
                          'Content-Type' => 'application/json')
      end
    end

    ## Wraps query_couchdb and passes get verb
    def couchdb_get(urn, host = '127.0.0.1', options = {})
      query_couchdb(urn, 'GET', host, options)
    end

    ## Wraps query_couchdb and passes put verb
    def couchdb_put(urn, host = '127.0.0.1', options = {})
      query_couchdb(urn, 'PUT', host, options)
    end

    ## Wraps query_couchdb and passes delete verb
    def couchdb_delete(urn, host = '127.0.0.1', options = {})
      query_couchdb(urn, 'DELETE', host, options)
    end

    ## Wraps query_couchdb and passes post verb
    def couchdb_post(urn, host = '127.0.0.1', options = {})
      query_couchdb(urn, 'POST', host, options)
    end

    ## Checks for open port, used for retry
    ## Wait 5 seconds for port to be open
    def wait_for_couchdb(host, port)
      5.times do
        begin
          Timeout::timeout(1) do
            begin
              s = TCPSocket.new(host, port)
              s.close
              return true
            rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
            end
          end
        rescue Timeout::Error
        end
        sleep 1
      end
      return false
    end

  end
end
