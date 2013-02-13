require "uri"
require "songkick/transport"
require_relative "message_builder"

class GovUkCollector

  def initialize(url)
    @url = URI(url)
    @message_builder = MessageBuilder.new
  end

  def messages
    client = Songkick::Transport::HttParty.new(
        "#{@url.scheme}://#{@url.host}",
        user_agent: "Data Insight GOV.UK Collector",
        timeout: 10
    )

    response = client.get(@url.path)

    response.data["results"].map { |artefact| @message_builder.build(artefact) }
  end

end
