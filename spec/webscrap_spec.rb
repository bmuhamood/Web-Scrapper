require './lib/webscrap.rb'

describe Scraper do
  before(:all) do
    @scraper = Scraper.new('rick%20and%20morty', 2)
    @scraper.data
  end

  describe '.initialize' do
    it 'Check url builder in initialize method' do
      expect(@scraper.instance_variable_get(:@url)).to eq('https://katcr.to/usearch/rick%20and%20morty/2/')
    end
    it 'Check that url is built dynamicly and that urls are not equal' do
      new_session = Scraper.new('modern%20family', 2)
      expect(@scraper.instance_variable_get(:@url)).to_not eq(new_session.instance_variable_get(:@url))
    end
  end
end
