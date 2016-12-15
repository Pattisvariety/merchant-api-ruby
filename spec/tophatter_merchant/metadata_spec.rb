require 'spec_helper'

# rspec spec/tophatter_merchant/metadata_spec.rb
describe TophatterMerchant::Metadata do
  it 'returns metadata' do
    metadata = TophatterMerchant::Metadata.all
    expect(metadata.keys.include?('categories')).to be true
    expect(metadata.keys.include?('conditions')).to be true
    expect(metadata.keys.include?('sizes')).to be true
    expect(metadata.keys.include?('colors')).to be true
    expect(metadata.keys.include?('countries')).to be true
    expect(metadata.keys.include?('states')).to be true
    expect(metadata.keys.include?('provinces')).to be true
    expect(metadata.keys.include?('territories')).to be true
    expect(metadata.keys.include?('carriers')).to be true
    expect(metadata.keys.include?('brands')).to be true
    expect(metadata.keys.include?('materials')).to be true
    expect(metadata.keys.include?('gemstones')).to be true
  end

  it 'returns conditions' do
    conditions = TophatterMerchant::Metadata.conditions
    expect(conditions.include?('New')).to be true
    expect(conditions.include?('New with Tags')).to be true
    expect(conditions.include?('New with Defects')).to be true
    expect(conditions.include?('Used')).to be true
    expect(conditions.include?('Refurbished')).to be true
  end

  it 'returns gemstones' do
    gemstones = TophatterMerchant::Metadata.gemstones
    expect(gemstones['Gemstones'].include?('Diamond')).to be true
    expect(gemstones['Gemstones'].include?('Ruby')).to be true
    expect(gemstones['Gemstones'].include?("Micheal Jackson's Hair Diamond")).to be false
  end
end
