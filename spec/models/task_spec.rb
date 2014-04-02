require "spec_helper"

describe Task do
  ## validations
  it { expect(subject).to validate_presence_of(:title) }
  it { expect(subject).to validate_presence_of(:user) }

  ## associations
  it { expect(subject).to belong_to(:user) }
end
