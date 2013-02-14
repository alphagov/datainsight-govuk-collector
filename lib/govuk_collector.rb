require "uri"
require "songkick/transport"
require_relative "message_builder"

class GovUkCollector

  def initialize(url, formats)
    @url = URI(url)
    @message_builder = MessageBuilder.new
    @formats = formats
  end

  def messages
    client = Songkick::Transport::HttParty.new(
        "#{@url.scheme}://#{@url.host}",
        user_agent: "Data Insight GOV.UK Collector",
        timeout: 10
    )

    response = client.get(@url.path)

    response
      .data["results"]
      .select { |artefact| @formats.include?(artefact["format"]) }
      .map { |artefact| @message_builder.build(artefact) }
  end

end
