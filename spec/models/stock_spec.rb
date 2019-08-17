require 'rails_helper'

RSpec.describe "Model > Stock", type: :model do
  before(:all) do
    @stock = create(:stock, code: "AMZN")
  end

  it "validates presence of type" do
    @stock.type = ""
    @stock.valid?
    expect(@stock.errors[:type]).to include("can't be blank")
  end

  it "validates presence of name" do
    @stock.name = ""
    @stock.valid?
    expect(@stock.errors[:name]).to include("can't be blank")
  end

  it "validates presence of code" do
    @stock.code = ""
    @stock.valid?
    expect(@stock.errors[:code]).to include("can't be blank")
  end

  it "has many accounts" do
    2.times do
      user = create(:user)
      user.register_an_account(@stock)
    end
    expect(@stock.accounts.length).to equal 2
  end

  it "has many users" do
    2.times do
      user = create(:user)
      user.register_an_account(@stock)
    end
    expect(@stock.users.length).to equal 2
  end

  it "has many teams" do
    2.times do
      user = create(:user, :with_team)
      user.teams.last.register_an_account(@stock)
    end
    expect(@stock.teams.length).to equal 2
  end
end
