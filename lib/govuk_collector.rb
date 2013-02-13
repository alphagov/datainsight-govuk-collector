require "uri"
require "songkick/transport"
require_relative "message_builder"

class GovUkCollector

  def initialize(url)
    @url = URI(url)
  end

  def messages
    client = Songkick::Transport::HttParty.new(
        "#{@url.scheme}://#{@url.host}",
        user_agent: "Data Insight GOV.UK Collector",
        timeout: 10
    )

    response = client.get(@url.path)

    response.data["results"].map { |artefact| MessageBuilder.new.build(artefact) }
  end

end
