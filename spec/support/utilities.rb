def sign_in_as!(user)
	visit '/users/sign_in'
	fill_in "Email", with: user.email 
	fill_in "Password", with: user.password 
	click_button "Sign in"
	expect(page).to have_content("Signed in successfully.")
end


def assert_no_link_for(text) 
	page.should_not(have_css("a", text: text),
		"Expected not to see the #{text.inspect} link, but did.")
end

def assert_link_for(text) 
	page.should(have_css("a", text: text),
		"Expected to see the #{text.inspect} link, but did not.")
end