feature 'Updating a bookmark' do
    scenario 'A user can update a bookmark' do
        bookmark = Bookmark.add_bookmark(url: 'http://www.google.com', title: 'Google')
        visit('/bookmarks')
        expect(page).to have_link('Google', href: 'http://www.google.com')

        first('.bookmark').click_button 'Edit'
        expect(current_path).to eq "/bookmarks/#{bookmark.id}/edit"

        fill_in('url', with: "http://www.gowebme.co.uk")
        fill_in('title', with: "GoWebMe")
        click_button('Submit')

        expect(current_path).to eq '/bookmarks'
        expect(page).not_to have_link('Google', href: 'http://www.google.com')
        expect(page).to have_link('GoWebMe', href: 'http://www.gowebme.co.uk')
    end
end