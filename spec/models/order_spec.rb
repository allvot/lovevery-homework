# require 'rails_helper'

# RSpec.describe Order, type: :model do
#   describe "#validations" do
#     context 'with invalid attributes' do
#       subject(:order) { build :order, shipping_name: nil }

#       before { is_expected.to be_invalid }

#       it "has shipping_name can't be blank error" do
#         expect(order.errors[:shipping_name]).to include "can't be blank"
#       end
#     end

#     context 'with blank attributes' do
#       subject(:order) { described_class.new() }

#       before { is_expected.to be_invalid }

#       it "has shipping_name can't be blank error" do
#         expect(order.errors[:shipping_name]).to include "can't be blank"
#       end
#     end
#   end
# end
