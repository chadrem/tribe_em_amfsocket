# Tribe EM AMF Socket

This Ruby gem provides AMF Socket bindings for [Tribe EM] (https://github.com/chadrem/tribe_em "Tribe EM").
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
    class EchoConnection < Tribe::EM::AmfSocket::Connection
      private

      def on_post_init(event)
        puts "Actor (#{identifier}) connected to client using thread (#{Thread.current.object_id})."
        super
      end
      
      def on_unbind(event)
        puts "Actor (#{identifier}) disconnected from client using thread (#{Thread.current.object_id})."
        super
      end

      def on_receive_message(event)
        puts "Actor (#{identifier}) received message (command=#{event.data.command}, params=#{event.data.params} using thread (#{Thread.current.object_id})."
        write_message(event.data.command, event.data.params)
        enqueue(:shutdown)
      end
    end

    # Create your server actor.
    server = Tribe::EM::TcpServer.new('localhost', 9000, EchoConnection)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
