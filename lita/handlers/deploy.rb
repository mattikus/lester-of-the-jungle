module Lita
  module Extensions

    # monkeypatch the validity check
    module GitHubWebHooksCore
      class HookReceiver < Handler
        def valid_ip?(request)
          true
        end
      end
    end
  end

  module Handlers
    class Deploy < Lita::Extensions::GitHubWebHooksCore::HookReceiver
      config :development_room

      def self.name
        "Deploy"
      end

      def devel_room
        Source.new(room: config.development_room)
      end

      on(:connected) do
        robot.send_message(devel_room, "I LIVE!!!")
      end

      http.post "/github-web-hooks", :receive_hook

      def logger
        Lita.logger
      end

      def kill(response)
        response.reply("Goodbye cruel world!")
        exit!
      end

      # If we get a push event, kill server so it can be restarted by the
      # service manager
      on(:push) do |payload|
        if payload["ref"] =~ /master/
          logger.info("Received push event, commiting suicide!")
          robot.send_message(devel_room, "Deploying sha: `#{payload["after"]}`")
          exit!
        end
      end

      route(/^die!*/i, :kill, command: true, help: {})

      Lita.register_handler(Deploy)
    end
  end
end

