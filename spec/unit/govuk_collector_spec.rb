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
    artefacts = {
        results: [
            {
                format: "answer",
                title: "Benefit Integrity Centres",
                id: "https://www.gov.uk/api/benefit-integrity-centres.json",
                web_url: "https://www.gov.uk/benefit-integrity-centres"
            },
            {
                format: "guide",
                title: "Road users requiring extra care (204 to 225)",
                id: "https://www.gov.uk/api/road-users-requiring-extra-care-204-to-225.json",
                web_url: "https://www.gov.uk/road-users-requiring-extra-care-204-to-225"
            },
            {
                format: "answer",
                title: "Legal rights for egg and sperm donors",
                id: "https://www.gov.uk/api/legal-rights-for-egg-and-sperm-donors.json",
                web_url: "https://www.gov.uk/legal-rights-for-egg-and-sperm-donors"
            }
        ]
    }

    url = "http://www.gov.uk/api/artefacts.json"
    FakeWeb.register_uri(:get, url, body: artefacts.to_json)

    collector = GovUkCollector.new(url)

    messages = collector.messages

    messages.should have(3).messages
  end

end