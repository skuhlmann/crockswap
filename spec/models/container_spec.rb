require 'rails_helper'

RSpec.describe Container, type: :model do
  it "exists" do
    container = create(:container)

    expect(container).to be_valid
    expect(container.name).to eq("Tupperware")
  end

  it "can belong to  a group" do
    container = create(:container)
    group = create(:group)
    group.container = container

    expect(group.container.id).to eq(container.id)
  end
end
