
feature '.all_bookmarks' do
    it 'displays all the bookmarks' do
        # connection = PG.connect(dbname: 'bookmark_manager_test')

        # Add test data
        Bookmark.add_bookmark(url: 'http://www.makersacademy.com', title: 'Makers Academy')
        Bookmark.add_bookmark(url: 'http://www.twitter.com', title: 'Twitter')
        Bookmark.add_bookmark(url: 'http://www.google.com', title: 'Google')

        visit '/bookmarks'
        
        expect(page).to have_link('Makers Academy', href: 'http://www.makersacademy.com')
        expect(page).to have_link('Twitter', href: 'http://www.twitter.com')
        expect(page).to have_link('Google', href: 'http://www.google.com')
    end
end