require "rails_helper"

RSpec.describe FactoryGirl do

  described_class.factories.map(&:name).each do |factory_name|
    describe ":#{factory_name}" do

      # Test each factory
      it "is valid" do
        factory = build(factory_name)
        if factory.respond_to?(:valid?)
          expect(factory).to be_valid, -> { factory.errors.full_messages.join("\n") }
        end
      end

      # Test each trait
      described_class.factories[factory_name].definition.defined_traits.map(&:name).each do |trait_name|
        context "with trait :#{trait_name}" do

          it "is valid" do
            factory = build(factory_name, trait_name)
            if factory.respond_to?(:valid?)
              expect(factory).to be_valid, -> { factory.errors.full_messages.join("\n") }
            end
          end
        end
      end
    end
  end
end
