require 'rails_helper'

RSpec.describe Topic, type: :model do
  # let (:name) { RandomData.random_sentence }
  # let (:description) { RandomData.random_paragraph }
  # let (:topic) { Topic.create!(name: name, description: description) }

  # refactored the above to use a factory
  let(:topic) { create(:topic) }

  let (:public) { true }


  it { is_expected.to have_many(:posts) }

  #here confirm that a topic responds to the appropriate attributes
  describe "attributes" do
    it "has name, description, and public attributes" do
      expect(topic).to have_attributes(name: topic.name, description: topic.description)
    end
    # confirm that the public attribute is set to true by default
    it " is public by default" do
      expect(topic.public).to be(true)
    end

  end

end
