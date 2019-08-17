require 'rails_helper'

RSpec.describe "Model > Fiat", type: :model do
  before(:all) do
    @fiat = create(:fiat, code: "USD")
  end

  it "validates presence of type" do
    @fiat.type = ""
    @fiat.valid?
    expect(@fiat.errors[:type]).to include("can't be blank")
  end

  it "validates presence of name" do
    @fiat.name = ""
    @fiat.valid?
    expect(@fiat.errors[:name]).to include("can't be blank")
  end

  it "validates presence of code" do
    @fiat.code = ""
    @fiat.valid?
    expect(@fiat.errors[:code]).to include("can't be blank")
  end

  it "has many accounts" do
    2.times {create(:user)}
    expect(@fiat.accounts.length).to equal 2
  end

  it "has many users" do
    2.times {create(:user)}
    expect(@fiat.users.length).to equal 2
  end

  it "has many teams" do
    2.times {create(:user, :with_team)}
    expect(@fiat.teams.length).to equal 2
  end
end
