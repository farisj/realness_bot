require 'twitter'
require_relative 'twitter_keys'
SUBJECTS = %w{
  appliances
  breads_and_pastries
  cars
  common
  condiments
  djia
  famous_movies
  flowers
  fruits
  greek_gods
  herbs_n_spices
  industries
  isms
  menu_items
  monsters
  objects
  occupations
  packaging
  paints
  rooms
  sculpture-materials
  setting
  tv_shows
  vegetables
  venues
}

STRUCTURES = [
  {adj: 2, noun: 1},
  {adj: 1, noun: 2},
]

INTRO_PHRASES = [
  "Today I'm serving ",
  "Today, I'm serving up some ",
  "I am serving up some ",
  "Today I'm serving some ",
  "Today I'm serving you some "
]

CLOSING_PHRASES = [
  " realness.",
  " realness.",
  " realness.",
  " eleganza."
]

ADJECTIVE_FREQUENCIES = [1, 1, 1, 1, 2]

sentence = "." * 141

while sentence.length > 140
  noun_file = SUBJECTS.sample

  noun = open("subjects/#{noun_file}.txt").readlines.sample

  adjectives = [open('selected_adjectives.txt').readlines.sample(ADJECTIVE_FREQUENCIES.sample)].flatten

  phrase = adjectives.join(', ') + " " + noun

  sentence = (INTRO_PHRASES.sample + phrase + CLOSING_PHRASES.sample).gsub("\n", '')
end

client = Twitter::REST::Client.new do |config|
  config.consumer_key = TWITTER_KEYS[:consumer_key]
  config.consumer_secret = TWITTER_KEYS[:consumer_secret]
  config.access_token = TWITTER_KEYS[:access_token]
  config.access_token_secret = TWITTER_KEYS[:access_token_secret]
end

puts TWITTER_KEYS['consumer_key']
client.update(sentence)
