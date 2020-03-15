# frozen_string_literal: true

require 'pry'
jira_issue = ENV['GITHUB_HEAD_REF']&.split(' ')&.first
author = ENV['GITHUB_ACTOR']

auth_hash =
  ARGV[0].split(',').map { |x| x.split(":")}
    .reduce({}) { |acc, v| acc[v[0]] = v[1]; acc }
p auth_hash
author_auth_key = auth_hash[author]
