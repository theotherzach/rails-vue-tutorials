require 'rails_helper'

RSpec.describe Person, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
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
