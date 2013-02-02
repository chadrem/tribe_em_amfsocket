module Tribe
  module EM
    module AmfSocket
      class Connection < Tribe::EM::Connection
        def self.proxy_class
          return Tribe::EM::AmfSocket::ActorProxy
        end

        private

        # Override and and call super as necessary.
        def on_post_init(event)
          super
        end

        # Override and and call super as necessary.
        def on_unbind(event)
          super
        end

        # Override and and call super as necessary.
        def on_receive_message(event)
        end

        def write(data)
          raise 'This method is not available with AMF Socket connections.'
        end

        def write_message(command, params = {})
          @actor_proxy.write_message(command, params)
        end
      end
    end
  end
end
