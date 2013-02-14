require "date"

class MessageBuilder

  def build(artefact)
    {
        :envelope => {
            :collected_at => DateTime.now,
            :collector => "GOV.UK"
        },
        :payload => artefact
    }
  end

end
