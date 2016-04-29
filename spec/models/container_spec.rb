require 'rails_helper'

RSpec.describe Container, type: :model do
  it "exists" do
    container = create(:container)

    expect(container).to be_valid
    expect(container.name).to eq("Tupperware")
  end

  it "can belong to groups" do
    container = create(:container)
    group = create(:group)
    group.containers << container

    expect(group.containers.first.id).to eq(container.id)
  end
end
