require "uri"
require "songkick/transport"

class GovUkCollector

  def initialize(url)
    @url = URI(url)
  end

  def messages
    client = Songkick::Transport::HttParty.new(
        "#{@url.scheme}://#{@url.host}",
        user_agent: "Datainsight InsideGov Collector",
        timeout: 10
    )

    response = client.get(@url.path)

    return response.data["results"]
  end

end