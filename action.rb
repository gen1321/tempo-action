# frozen_string_literal: true

require 'pry'
jira_issue = ENV['GITHUB_HEAD_REF']&.split(' ')&.first
author = ENV['GITHUB_ACTOR']

auth_hash = ARGV.map { |x| x.split('=') }
p auth_hash
author_auth_key = auth_hash[author]
