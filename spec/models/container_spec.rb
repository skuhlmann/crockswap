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

  it "name is required" do
    container = Container.create(size: "16oz")

    expect(container).to be_invalid
  end

  it "provides all active containers" do
    container = create(:container)
    container2 = Container.create(name: "pyrex", size: "16oz", active: true)
    container2 = Container.create(name: "pyrex", size: "8oz", active: false)

    containers = Container.active

    expect(containers.length).to be(2)
    expect(Container.count).to be(3)
  end
end
