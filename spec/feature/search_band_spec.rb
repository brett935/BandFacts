# spec/feature/search_band.rb
require 'rails_helper'

RSpec.describe 'Search a Band', type: :feature do
    describe 'search page loads' do
        it 'shows the right content' do
            visit new_search_path
            expect(page).to have_content('BandFacts')
        end
    end

    describe 'search page' do
        it 'successfully searches for a band' do
            visit new_search_path
            fill_in 'band_name', :with => 'coldplay'
            find('#search_band').click
            expect(page).to have_content('Name:')
            expect(page).to have_content('Biography:')
        end
    end

    describe 'search page' do
        it 'unsuccessful search shows warning message' do
            visit new_search_path
            fill_in 'band_name', :with => 'null'
            find('#search_band').click
            expect(page).to have_content('Search was unsuccessful.')
        end
    end
end