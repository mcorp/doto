require "spec_helper"

describe User do
  ## associations
  it { expect(subject).to have_many(:tasks).dependent(:destroy) }
end
