require "spec_helper"

describe "MessageBuilder parser" do
  it "should build a message from an artefact" do
    now = DateTime.new(2012, 12, 12, 12, 12, 12)
    Timecop.freeze(now) do
      artefact = {
          format: "answer",
          title: "Benefit Integrity Centres",
          id: "https://www.gov.uk/api/benefit-integrity-centres.json",
          web_url: "https://www.gov.uk/benefit-integrity-centres"
      }

      message = MessageBuilder.new.build(artefact)

      message[:envelope][:created_at].should == now
      message[:envelope][:collector].should == "GOV.UK"

      message[:payload].should == artefact
    end
  end
end
