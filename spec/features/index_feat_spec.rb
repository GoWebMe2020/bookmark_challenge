
feature 'return hello world' do
  scenario 'the page contains hello world' do
    Bookmark.add_bookmark(url: 'http://www.makersacademy.com', title: 'Makers Academy')
    Bookmark.add_bookmark(url: 'http://www.destroyallsoftware.com', title: 'Destroy All Software')
    Bookmark.add_bookmark(url: 'http://www.google.com', title: 'Google')

    visit '/bookmarks'

    expect(page).to have_link('Makers Academy', href: 'http://www.makersacademy.com')
    expect(page).to have_link('Destroy All Software',  href: 'http://www.destroyallsoftware.com')
    expect(page).to have_link('Google', href: 'http://www.google.com')
  end
end