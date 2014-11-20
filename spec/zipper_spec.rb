require 'pry'
describe Zipper do
  it "should find a city and state for a given zip code" do
    zipper = Zipper::Zip.find(11230)
    expect(zipper.city).to eq "Brooklyn"
    expect(zipper.state).to eq "NY"
  end
end
