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
    .each_with_object({}) { |v, acc| acc[v[0]] = {tempo_auth_token: v[1], jira_account_id: v[2] }}
pr_body = ARGV[1]

p auth_hash
timespent = pr_body.scan(/(time_spent):([0-9])/).last.last.to_i * 60 * 60
user = auth_hash[author]
author_oauth_key = user[:tempo_auth_token]
jira_account_id = user[:jira_account_id]

request_body = {
  "issueKey": jira_issue,
  "timeSpentSeconds": timespent,
  "startDate": Date.today,
  "startTime": Time.now.strftime("%H:%M:%S"),
  "authorAccountId": jira_account_id
}.to_json

puts request_body
begin
  RestClient.post(
    TEMPO_WORKLOGS_ENDPOINT,
    request_body,
    {content_type: 'json', 'Authorization' => "Bearer #{author_oauth_key}"}
  )
rescue RestClient::ExceptionWithResponse => e
  p e.response.body
end
