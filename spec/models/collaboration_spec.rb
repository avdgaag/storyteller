require 'spec_helper'

describe Collaboration do
  it { should belong_to(:project) }
  it { should belong_to(:user) }
end
