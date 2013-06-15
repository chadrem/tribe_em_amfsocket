# Attempt to provide thread-safe communication between EventMachine and AMF Socket.
# 1. Always use EM.schedule to push work to the reactor thread.
# 2. Always use @actor.deliver_message! to push work to the actor's thread pool.

module Tribe
  module EM
    module AmfSocket
      class ActorProxy < ::AmfSocket::AmfRpcConnection
        private

        def initialize(actor_class, options = {})
          @actor_class = actor_class || raise('You must provide an actor class.')
          @logger = Workers::LogProxy.new(options[:logger])

          @actor = @actor_class.new({ :actor_proxy => self, :logger => @logger })
        end

        #
        # EM Callbacks.
        #

        public

        def post_init
          super

          @actor.deliver_message!(:post_init, nil)
        end

        def unbind
          super

          @actor.deliver_message!(:unbind, nil)
        end

        def receive_message(message)
          @actor.deliver_message!(:receive_message, message)
        end

        #
        # Public methods.  Call these from the associated actor.
        #

        public

        def close(after_writing = false)
          ::EM.schedule { close_connection(after_writing) }

          return nil
        end

        def write_message(command, params = {})
          ::EM.schedule { send_message(command, params) }

          return nil
        end

        #
        # Private methods.
        #

        private

        def write(data)
          raise 'This method can not be used with AMF Socket.'
        end
      end
    end
  end
end
