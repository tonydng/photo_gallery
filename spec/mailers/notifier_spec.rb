require 'spec_helper'

describe Notifier do 
	context "comment_updated" do 
		let!(:owner) { Factory(:confirmed_user) }
		let!(:gallery) { Factory(:gallery, user: owner) }
		let!(:photo) { Factory(:photo, gallery: gallery, user: owner) }
		let!(:commenter) { Factory(:confirmed_user) }
		let(:comment) do 
			Comment.new({
				commentable: photo,
				user: commenter,
				content: "test comment"
			}, without_protection: true)
		end

		let(:email) do 
			Notifier.comment_updated(comment, owner)
		end 

		it "sends out an email notification about a new comment" do 
			expect(email.to).to include(owner.email)
			title = "#{photo.name} for #{gallery.name} has been updated."
			expect(email.body).to include(title)
			expect(email.body).to include("#{comment.user} wrote:")
			expect(email.body).to include(comment.content)
		end

		it "correctly sets the Reply-To" do 
			address = "tonydng+#{gallery.id}+#{photo.id}@gmail.com"
			expect(email.reply_to).to eql([address])
		end
	end
end