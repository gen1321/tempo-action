# frozen_string_literal: true

require 'pry'
require 'pry-doc'
require 'rest-client'

TEMPO_WORKLOGS_ENDPOINT = 'https://api.tempo.io/core/3/worklogs'

jira_issue = ENV['GITHUB_HEAD_REF']&.split(' ')&.first
author = ENV['GITHUB_ACTOR']

auth_hash =
  ARGV[0]
  .split(',')
  .map { |x| x.split(':') }
  .each_with_object({}) { |v, acc| acc[v[0]] = v[1] }

p auth_hash

author_oauth_key = auth_hash[author]

request_body = {
  "issueKey": jira_issue,
  "timeSpentSecconds": 1000
}.to_json

puts RestClient.post(
  TEMPO_WORKLOGS_ENDPOINT,
  request_body,
  content_type: 'json', 'Authorization' => "Bearer #{author_oauth_key}"
)
