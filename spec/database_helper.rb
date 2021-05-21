require 'pg'
require './lib/database_connection'

def persisted_data(id:, table:)
    # connection = PG.connect(dbname: 'bookmark_manager_test')
    # result = connection.query("SELECT * FROM #{table} bookmarks WHERE id = #{id};")
    # result.first
    DatabaseConnection.query("SELECT * FROM #{table} WHERE id = '#{id}';")
end