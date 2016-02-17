class Person < ActiveRecord::Base
  extend Textacular

  def self.all_or_search(q = nil)
    return self.basic_search(q) if q

    self.all
  end

end

# == Schema Information
#
# Table name: people
#
#  id          :integer          not null, primary key
#  first_name  :string
#  last_name   :string
#  middle_name :string
#  email       :string
#  website     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
