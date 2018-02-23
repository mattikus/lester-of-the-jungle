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

      on(:push) do |payload|
        puts payload.inspect
      end

      Lita.register_handler(Deploy)
    end
  end
end

