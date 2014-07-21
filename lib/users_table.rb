class UsersTable
  def initialize(connection)
    @database_connection = connection
  end

  def create(username, message)
    @database_connection.sql("INSERT into users (username, message) values ('#{username}', '#{message}') returning id").first["id"]
  end

  def find(id)
    @database_connection.sql("SELECT * from users where id = #{id}").first
  end
end
