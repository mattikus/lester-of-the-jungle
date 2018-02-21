NAMES = ["Sleve McDichael", "Onson Sweemey", "Darryl Archideld",
         "Anatoli Smorin", "Rey McSriff", "Glenallen Mixon",
         "Mario McRlwain", "Raul Chamgerlain", "Kevin Nogilny",
         "Tony Smehrik", "Bobson Dugnutt", "Willie Dustice",
         "Jeromy Gride", "Scott Dourque", "Shown Furcotte",
         "Dean Wesrey", "Mike Truk", "Dwigt Rortugal",
         "Tim Sandaele", "Karl Dandleton", "Mike Sernandez",
         "Todd Bonzalez", "Wilson Chul Lee", "Nert Bisels",
         "Kenn Nitvarn", "Fergit Hote", "Coll Bitzron",
         "Lood Janglosti", "Taenis Tellron", "Marnel Hary",
         "Dony Olerberz", "Gin Ginlons", "Wob Wonkoz",
         "Tanny Mlitnirt", "Hudgyn Sasdarl", "Fraven Pooth",
         "Rarr Dick", "Dorse Hintline", "Roy Gamo",
         "Tenpe Laob", "Varlin Genmist", "Pott Korhil",
         "Am O'Erson", "Snarry Shitwon", "Bobs Peare",
         "Renly Mlynren", "Ceynei Doober", "Hom Wapko",
         "Odood Jorgeudey", "Gary Banps", "Jaris Forta",
         "Erl Jivlitz", "Lenn Wobses", "Dan Boyo",
         "Yans Loovensan", "Mob Welronz", "Bannoe Rodylar",
         "Al Swermirstz", "Jinneil Robenko", "Bobson Allcock Dugnut",
         "Chicken Nutlugget" ]

IMAGE_BASE = "http://www.mcs.anl.gov/~acherry/bb-images"

module Lita
  module Handlers
    class Baseball < Handler
      route(/baseball(?: me)?$/, :player, command: true, help: {
        "baseball me" => "do the thing",
      })

      def player(response)

        image_number = (860 * Random.rand).floor
        image_url = "#{IMAGE_BASE}/#{image_number}.jpg"
        name = NAMES.shuffle.first

        attachment = Lita::Adapters::Slack::Attachment.new("", {
          :fallback => name,
          :title => name,
          :image_url => image_url,
        })
        robot.chat_service.send_attachment(response.room, attachment)
      end
    end

    Lita.register_handler(Baseball)
  end
end
