# Tribe EM AMF Socket

This Ruby gem provides [AMF Socket] (https://github.com/chadrem/amf_socket_ruby "AMF Socket") bindings for [Tribe EM] (https://github.com/chadrem/tribe_em "Tribe EM").
Currently sending and receive messages is integrated (requests are not).

## Installation

Add this line to your application's Gemfile:

    gem 'tribe_em_amfsocket'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tribe_em_amfsocket

## Usage

    # Create a custom connection actor class.
    class EchoConn < Tribe::EM::AmfSocket::Connection
      private
      def exception_handler(e)
        super
        puts concat_e("EchoConn (#{identifier}) died.", e)
      end

      def post_init_handler
        puts "EchoConn (#{identifier}) connected to client using thread (#{Thread.current.object_id})."
      end

      def unbind_handler
        puts "EchoConn (#{identifier}) disconnected from client using thread (#{Thread.current.object_id})."
      end

      def receive_message_handler(message)
        puts "EchoConn (#{identifier}) received message (message=#{message} using thread (#{Thread.current.object_id})."
        write_message(message.command, message.params)
        shutdown!
      end
    end

    # Create your server actor.
    server = Tribe::EM::TcpServer.new('localhost', 9000, EchoConn)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
