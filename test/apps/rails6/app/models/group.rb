class Group < ApplicationRecord
  def uuid_in_sql
    ActiveRecord::Base.connection.exec_query("select * where x = #{User.uuid}")
  end

  def date_in_sql
    date = 30.days.ago
    Arel.sql("created_at > '#{date}'")
  end

  def ar_sanitize_sql_like(query)
    query = ActiveRecord::Base.sanitize_sql_like(query) # escaped variable
    Arel.sql("name ILIKE '%#{query}%'")
  end

  def fetch_constant_hash_value(role_name)
    roles = { admin: 1, moderator: 2 }.freeze
    role = roles.fetch(role_name)
    Arel.sql("role = '#{role}'")
  end
end
