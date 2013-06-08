module Tribe
  module EM
    module AmfSocket
      class Connection < Tribe::EM::Connection
        def self.proxy_class
          return Tribe::EM::AmfSocket::ActorProxy
        end

        private

        def write(data)
          raise 'This method can not be used with AMF Socket.'
        end

        def write_message(command, params = {})
          @_actor_proxy.write_message(command, params)
        end

        #
        # Command handlers.
        #

        def on_receive_message(event)
          receive_message_handler(event.data)
        end

        #
        # System handlers.
        #

        def receive_message_handler(message)
        end
      end
    end
  end
end
