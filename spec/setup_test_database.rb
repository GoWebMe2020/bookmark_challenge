require 'pg'

def setup_test_database
    p "Setting up test datasbase ..."
    connection = PG.connect(dbname: 'bookmark_manager_test')
    connection.exec("TRUNCATE bookmarks, comments, users;")
end