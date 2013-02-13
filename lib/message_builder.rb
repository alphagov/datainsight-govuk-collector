require "date"

class MessageBuilder

  def build(artefact)
    {
        :envelope => {
            :created_at => DateTime.now,
            :collector => "GOV.UK"
        },
        :payload => artefact
    }
  end

end
