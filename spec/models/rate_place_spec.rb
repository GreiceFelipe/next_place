require 'rails_helper'

RSpec.describe RatePlace, type: :model do
  it { is_expected.to(validate_presence_of(:rate)) }

  it { belong_to(:user) }
  it { belong_to(:place) }
end
