require 'spec_helper'

describe 'user authentication' do
    it 'allows sign in with valid credentials' do
        sign_in_user(create(:user))
        
        expect(page).to have_content('Signed in successfully')
    end

    it 'does not allow signin with invalid credentials' do
        sign_in_user(create(:user), password: 'wrong pw')

        expect(page).to have_content('Invalid email or password')
    end

    it 'allows user to sign out' do
        sign_in_user(create(:user))

        visit root_path
        click_link 'Sign out'
        expect(page).to have_content('Signed out successfully')
    end


    def sign_in_user(user, opts={})
        visit new_user_session_path
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Sign in'

    end





end