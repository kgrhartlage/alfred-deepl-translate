require 'json'

CODES = {
  'bg' => 'Bulgarian',
  'zh' => 'Chinese',
  'cs' => 'Czech',
  'da' => 'Danish',
  'nl' => 'Dutch',
  'en' => 'English',
  'et' => 'Estonian',
  'fi' => 'Finnish',
  'fr' => 'French',
  'de' => 'German',
  'el' => 'Greek',
  'hu' => 'Hungarian',
  'it' => 'Italian',
  'ja' => 'Japanese',
  'lv' => 'Latvian',
  'lt' => 'Lithuanian',
  'pl' => 'Polish',
  'pt' => 'Portuguese',
  'ro' => 'Romanian',
  'ru' => 'Russian',
  'sk' => 'Slovak',
  'sl' => 'Slovenian',
  'es' => 'Spanish',
  'sv' => 'Swedish'
}.freeze

url = 'https://www.deepl.com/en/translator#'
max = 70
input = ARGV[0].to_s.strip
query = input.empty? ? `pbpaste` : input
truncated_query = query.length > max ? "#{query[0...max]}..." : query

from, target = ENV['lang'].split('-')

items =
  if CODES[from].nil? || CODES[target].nil? || from == target
    [{
      title: 'Invalid language settings',
      subtitle: "set your workflow environment variable in the format 'en-de'",
      valid: false
    }]
  else
    [{
      title: "#{CODES[from]} ⮕ #{CODES[target]}",
      subtitle: "translate '#{truncated_query}' to #{CODES[target]}",
      arg: "#{from}/#{target}/#{query}",
      quicklookurl: "#{url}#{from}/#{target}/#{query}"
    },
     {
       title: "#{CODES[target]} ⮕ #{CODES[from]}",
       subtitle: "translate '#{truncated_query}' to #{CODES[from]}",
       arg: "#{target}/#{from}/#{query}",
       quicklookurl: "#{url}#{target}/#{from}/#{query}"
     }]
  end

puts({
  items: items
}.to_json)
