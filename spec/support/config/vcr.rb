# frozen_string_literal: true

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/cassettes'

  c.default_cassette_options = { match_requests_on: %i[host path method] }

  c.hook_into :webmock

  c.filter_sensitive_data('<API_TOKEN>') do |interaction|
    interaction.request.parsed_uri.query.split('&').first.split('=').second
  end
end
