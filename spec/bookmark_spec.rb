require 'bookmark'
require 'database_helper'

describe Bookmark do
    
    describe '.add_bookmark' do

        it 'does not create a new bookmark if the URL is not valid' do
            bookmark = Bookmark.add_bookmark(url: 'not a real bookmark', title: 'not a real bookmark')
            expect(bookmark).not_to be_a Bookmark
        end

        it 'adds a new bookmark' do
            bookmark = Bookmark.add_bookmark(url: 'http://www.testbookmark.co.uk', title: 'Test Bookmark')
            persisted_data = persisted_data(id: bookmark.id, table: 'bookmarks')

            expect(bookmark).to be_a Bookmark
            expect(bookmark.id).to eq persisted_data.first['id']   
            expect(bookmark.url).to eq 'http://www.testbookmark.co.uk'
            expect(bookmark.title).to eq 'Test Bookmark'
        end
    end

    describe '.delete' do
        it 'deletes the given bookmark' do
            bookmark = Bookmark.add_bookmark(title: 'Gowebme', url: 'http://www.gowebme.co.uk')
            Bookmark.delete(id: bookmark.id)
            expect(Bookmark.all_bookmarks.length).to eq(0)
        end
    end

    describe '.update' do
        it 'updates the bookmark with the given data' do
            bookmark = Bookmark.add_bookmark(title: 'Makers Academy', url: 'http://www.makersacademy.com')
            updated_bookmark = Bookmark.update(id: bookmark.id, url: 'http://www.snakersacademy.com', title: 'Snakers Academy')
        
            expect(updated_bookmark).to be_a Bookmark
            expect(updated_bookmark.id).to eq bookmark.id
            expect(updated_bookmark.title).to eq 'Snakers Academy'
            expect(updated_bookmark.url).to eq 'http://www.snakersacademy.com'
        end
    end

    describe '.find' do
        it 'returns the requested bookmark object' do
            bookmark = Bookmark.add_bookmark(title: 'Makers Academy', url: 'http://www.makersacademy.com')
        
            result = Bookmark.find(id: bookmark.id)
        
            expect(result).to be_a Bookmark
            expect(result.id).to eq bookmark.id
            expect(result.title).to eq 'Makers Academy'
            expect(result.url).to eq 'http://www.makersacademy.com'
        end
    end

    let(:comment_class) { double(:comment_class) }

    describe '#comments' do
        it 'calls .where on the Comment class' do
            bookmark = Bookmark.add_bookmark(title: 'Makers Academy', url: 'http://www.makersacademy.com')
            expect(comment_class).to receive(:where).with(bookmark_id: bookmark.id)
        
            bookmark.comments(comment_class)
        end
    end
end