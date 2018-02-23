module Lita
  module Handlers
    class Deploy < Lita::Extensions::GitHubWebHooksCore::HookReceiver
      def self.name
        "Deploy"
      end

      on(:connected) do
        target = Source.new(room: "#lester-development")
        robot.send_message(target, "I LIVE!!!")
      end

      http.post "/github-web-hooks", :receive_hook

      def logger
        Lita.logger
      end

      # If we get a push event, kill server so it can be restarted by the
      # service manager
      on(:push) do |payload|
        if payload["ref"] =~ /master/
          logger.info("Received push event, commiting suicide!")
          Kernel.exit(0)
        end
      end

      Lita.register_handler(Deploy)
    end
  end
end

