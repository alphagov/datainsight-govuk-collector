require "spec_helper"

describe "govuk collector" do

  it "should retrieve artefacts from govuk api" do

    artefacts = {
        results: []
    }

    url = "http://www.gov.uk/api/artefacts.json"
    FakeWeb.register_uri(:get, url, body: artefacts.to_json)

    collector = GovUkCollector.new(url)

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

    url = "http://www.gov.uk/api/artefacts.json"
    FakeWeb.register_uri(:get, url, body: artefacts.to_json)

    collector = GovUkCollector.new(url)

    messages = collector.messages

    messages.should have(3).messages
    messages[0] == :message
    messages[1] == :message
    messages[2] == :message
  end

end