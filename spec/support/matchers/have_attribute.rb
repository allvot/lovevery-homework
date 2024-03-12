# Have attribute

RSpec::Matchers.define :have_attribute do |expected|
  match do |actual|
    actual.attributes.keys.map(&:to_s).include?(expected.to_s)
  end

  failure_message do |actual|
    "expected that #{actual} would have an attribute called #{expected}"
  end

  failure_message_when_negated do |actual|
    "expected that #{actual} would not have an attribute called #{expected}"
  end
end
