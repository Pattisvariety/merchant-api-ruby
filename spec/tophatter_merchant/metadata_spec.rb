require 'spec_helper'

# rspec spec/tophatter_merchant/metadata_spec.rb
describe TophatterMerchant::Metadata do
  describe '.metadata' do
    it 'returns metadata', :vcr do
      result = TophatterMerchant::Metadata.all
      expect(result.keys.include?('categories')).to be(true)
      expect(result.keys.include?('conditions')).to be(true)
      expect(result.keys.include?('brands')).to be(true)
      expect(result.keys.include?('materials')).to be(true)
      expect(result.keys.include?('sizes')).to be(true)
      expect(result.keys.include?('colors')).to be(true)
      expect(result.keys.include?('countries')).to be(true)
      expect(result.keys.include?('country_codes')).to be(true)
      expect(result.keys.include?('states')).to be(true)
      expect(result.keys.include?('provinces')).to be(true)
      expect(result.keys.include?('territories')).to be(true)
      expect(result.keys.include?('carriers')).to be(true)
    end
  end

  describe '.categories' do
    it 'returns categories', :vcr do
      result = TophatterMerchant::Metadata.categories
      expect(result.include?('Apparel | Swim | Tops')).to be(true)
    end
  end

  describe '.conditions' do
    it 'returns conditions', :vcr do
      result = TophatterMerchant::Metadata.conditions
      expect(result.include?('New')).to be(true)
      expect(result.include?('New with Tags')).to be(true)
      expect(result.include?('New with Defects')).to be(true)
      expect(result.include?('Used')).to be(true)
      expect(result.include?('Refurbished')).to be(true)
    end
  end

  # describe '.brands' do
  #   it 'returns brands', :vcr do
  #     result = TophatterMerchant::Metadata.brands
  #     expect(result.key?('Home')).to be(true)
  #     expect(result['Home'].include?('Ninja')).to be(true)
  #   end
  # end

  describe '.materials' do
    it 'returns materials', :vcr do
      result = TophatterMerchant::Metadata.materials
      expect(result.key?('Gemstones')).to be(true)
      expect(result['Gemstones'].include?('Star Ruby')).to be(true)
    end
  end

  describe '.sizes' do
    it 'returns sizes', :vcr do
      result = TophatterMerchant::Metadata.sizes
      expect(result.key?('Accessories')).to be(true)
      expect(result['Accessories'].include?('Small')).to be(true)
    end
  end

  describe '.colors' do
    it 'returns colors', :vcr do
      result = TophatterMerchant::Metadata.colors
      expect(result.include?('Red')).to be(true)
    end
  end

  describe '.countries' do
    it 'returns countries', :vcr do
      result = TophatterMerchant::Metadata.countries
      expect(result.include?('United States')).to be(true)
    end
  end

  describe '.country_codes' do
    it 'returns country codes', :vcr do
      result = TophatterMerchant::Metadata.country_codes
      expect(result.key?('United States')).to be(true)
      expect(result['United States']).to eq('USA')
    end
  end

  describe '.states' do
    it 'returns states', :vcr do
      result = TophatterMerchant::Metadata.states
      expect(result.key?('California')).to be(true)
      expect(result['California']).to eq('CA')
    end
  end

  describe '.provinces' do
    it 'returns provinces', :vcr do
      result = TophatterMerchant::Metadata.provinces
      expect(result.key?('Alberta')).to be(true)
      expect(result['Alberta']).to eq('AB')
    end
  end

  describe '.territories' do
    it 'returns territories', :vcr do
      result = TophatterMerchant::Metadata.territories
      expect(result.key?('New South Wales')).to be(true)
      expect(result['New South Wales']).to eq('NSW')
    end
  end

  describe '.carriers' do
    it 'returns carriers', :vcr do
      result = TophatterMerchant::Metadata.carriers
      expect(result.key?('USPS')).to be(true)
    end
  end
end
