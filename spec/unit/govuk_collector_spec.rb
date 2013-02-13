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

end