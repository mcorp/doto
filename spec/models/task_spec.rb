require "spec_helper"

describe Task do
  it { expect(subject).to validate_presence_of(:title) }
end
