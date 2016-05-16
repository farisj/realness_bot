require 'twitter'
require 'active_support/inflector'

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

INTRO_PHRASES = [
  "Today I'm serving ",
  "Today, I'm serving up some ",
  "I am serving up some ",
  "Today I'm serving some ",
  "Today I'm serving you some "
]

CLOSING_PHRASES = [
  [" realness."] * 9,
  " eleganza."
].flatten

ADJECTIVE_FREQUENCIES = [1, 1, 1, 1, 2]

sentence = "." * 141

while sentence.length > 140
  noun_file = SUBJECTS.sample

  noun = open("subjects/#{noun_file}.txt").readlines.sample.strip.singularize

  adjectives = [open('selected_adjectives.txt').readlines.sample(ADJECTIVE_FREQUENCIES.sample)].flatten

  phrase = adjectives.join(', ') + " " + noun

  sentence = (INTRO_PHRASES.sample + phrase + CLOSING_PHRASES.sample).gsub("\n", '')
end

client = Twitter::REST::Client.new do |config|
  config.consumer_key = ENV["consumer_key"]
  config.consumer_secret = ENV["consumer_secret"]
  config.access_token = ENV["access_token"]
  config.access_token_secret = ENV["access_token_secret"]
end

client.update(sentence)
