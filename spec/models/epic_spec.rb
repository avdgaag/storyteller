require 'spec_helper'

describe Epic do
  it { should belong_to(:author) }
  it { should belong_to(:project) }
  it { should have_many(:stories) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:author) }
end
