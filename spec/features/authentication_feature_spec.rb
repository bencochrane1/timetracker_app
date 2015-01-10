require 'spec_helper'

describe 'user authentication' do
    let(:user) { build(:user) }
    let!(:account) { build(:account, owner: user) }

    it 'allows sign in with valid credentials' do
        sign_in_user(user, subdomain: account.subdomain)
        expect(page).to have_content('Signed in successfully')
    end

    it 'does not allow signin with invalid credentials' do
        sign_in_user(user, subdomain: account.subdomain, password: 'wrong pw')

        expect(page).to have_content('Invalid email or password')
    end

    it 'does not allow user to sign in unless on subdomain'
        expect { visit new_user_session_path }.to raise_error
    end

    it 'does not allow user from one subdomain to sign into another subdomain'
        user2 = build(:user)
        account2 = create(:account, owner: user2)

        sign_in_user(user2, subdomain: account2.subdomain)
        expect(page).to have_content('Signed in successfully')

        sign_in_user(user2, subdomain: account.subdomain)
        expect(page).to have_content('Invalid email or password')

    end


    it 'allows user to sign out' do
        sign_in_user(user, subdomain: account.subdomain)

        click_link 'Sign out'
        expect(page).to have_content('Signed out successfully')
    end


    def sign_in_user(user, opts={})
        visit new_user_session_url(subdomain: opts[:subdomain])
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Sign in'

    end





end