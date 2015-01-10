require 'spec_helper'

describe 'account creation' do
    it 'allows user to create account'
        visit root_path
        click_link 'Create Account'

        fill_in 'Name', with: 'Ben'
        fill_in 'Email', with: 'benocchrane1@me.com'
        fill_in 'Password', with: 'pw'
        fill_in 'Password confirmation', with: 'pw'
        fill_in 'Subdomain', with: 'test_subdomain'

        click_button 'Create Account'

        expect(page).to have_content('Signed up successfully')

end