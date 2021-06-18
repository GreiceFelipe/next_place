require 'rails_helper'

RSpec.describe Place, type: :model do
  it { is_expected.to(validate_presence_of(:name)) }
  it { is_expected.to(validate_presence_of(:url)) }
  it { is_expected.to(validate_presence_of(:address)) }
  it { is_expected.to(validate_presence_of(:maps_id)) }
  it { is_expected.to(validate_presence_of(:latitude)) }
  it { is_expected.to(validate_presence_of(:longitude)) }

  it { is_expected.to(validate_uniqueness_of(:maps_id)) }
  it { belong_to(:user) }
end
