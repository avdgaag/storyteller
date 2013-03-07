require 'spec_helper'

describe Attachment do
  it { should belong_to(:attachable) }
  it { should belong_to(:user) }
  it { should have_attached_file(:file) }
  it { should validate_attachment_presence(:file) }
end
