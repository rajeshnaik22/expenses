require 'rails_helper'

RSpec.describe Role, type: :model do
  subject(:role) { Role.new(**props)}
  let(:props) { {name: "admin"}}
  
  describe 'validations:' do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    describe "without name" do
      let(:props) {{name: nil}}
      it { is_expected.to be_invalid }
    end


    it "is not valid with duplicate name" do
      role2 = Role.create!(**props)
      expect(subject).to be_invalid
    end
  end
end
