require 'rubygems'
require 'spec'
require 'intranet_reader'


describe "A new IntranetReader" do
  before do
    @my_rss = IntranetReader.new('sample_feed.rss')
  end

  it "should be empty." do
    @my_rss.should be_empty
  end

  it "should not have entries." do
    @my_rss.entries.should be_nil
  end

  it "should not have 'raw'." do
    @my_rss.raw.should be_nil
  end
end


describe "A populated IntranetReader" do
  before do
    @my_rss = IntranetReader.new('sample_feed.rss')
    @my_rss.process
  end

  it "should not be empty." do
    @my_rss.should_not be_empty
  end

  it "should have entries." do
    @my_rss.entries.should_not be_nil
  end

  it "should have 'raw'." do
    @my_rss.raw.should_not be_nil
  end
end
