class Person < ActiveRecord::Base
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
