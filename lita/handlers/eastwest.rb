VIDEO_URLS = [
  "http://www.youtube.com/watch?v=gODZzSOelss",
  "http://www.youtube.com/watch?v=rT1nGjGM2p8",
  "https://www.youtube.com/watch?v=mDp-ABzpRX8"
]

SITE = "http://collegebowl.avatarpro.biz/"

module Lita
  module Handlers
    class EastWest < Handler
      route(/(eastwest|east|west)(?: me)?$/i, :player, command: true, help: {
        "east" => "Let's meet a random player from the East",
        "west" => "Let's meet a random player from the West",
        "eastwest" => "Let's meet a random player",
      })

      route(/eastwest(?: me)? url(?: )?([1-3])?/i, :video, command: true, help: {
        "eastwest url" => "Show the original East vs West video",
        "eastwest url 1" => "Show the original East vs West video",
        "eastwest url 2" => "Show the second East vs West video",
        "eastwest url 3" => "Show the third East vs West video",
      })

      def player(response)
        conference = response.match_data[1]
        endpoint = if conference == "eastwest" then
                     "player"
                   else
                     "#{conference}/player"
                   end
        player = MultiJson.load(http.get("#{SITE}/#{endpoint}").body).first

        attachment = Lita::Adapters::Slack::Attachment.new("", {
          :fallback => player['name'],
          :image_url => player['image'],
          :fields => [
            { :title => "Name", :value => player['name'], :short => true},
            { :title => "College", :value => player['college'], :short => true},
          ],
        })
        robot.chat_service.send_attachment(response.room, attachment)
      end

      def video(response)
        idx = (response.match_data[1] || "1").to_i - 1
        response.reply(VIDEO_URLS[idx])
      end
    end

    Lita.register_handler(EastWest)
  end
end
