require "spec_helper"

describe "govuk collector" do

  ARTEFACT_URL = "http://www.gov.uk/api/artefacts.json"

  it "should retrieve artefacts from govuk api" do

    artefacts = {
        results: []
    }

    FakeWeb.register_uri(:get, ARTEFACT_URL, body: artefacts.to_json)

    collector = GovUkCollector.new(ARTEFACT_URL)

    messages = collector.messages

    messages.should be_empty
  end

  it "should parse the retrieved artefact into a list of messages" do
    MessageBuilder.any_instance.stub(:build).with("artefact").and_return(:message)

    artefacts = {
        results: [
            "artefact",
            "artefact",
            "artefact"
        ]
    }

    FakeWeb.register_uri(:get, ARTEFACT_URL, body: artefacts.to_json)

    collector = GovUkCollector.new(ARTEFACT_URL)

    messages = collector.messages

    messages.should have(3).messages
    messages[0] == :message
    messages[1] == :message
    messages[2] == :message
  end

end