# BeagleboneBlackRuby

This is for accessing Beaglebone Black pins through Ruby code. 

There are many Ruby projects in GitHub to do a similar thing. 
But I have decided to develop my own from scratch this time instead of using an existing one like I always do.

There are three reasons. 

1. Build my own expertise on controlling Beaglebone Black directly. 

2. Many existing ones don't have proper testings. I understand the difficulty of writing a test for a code to control hardware. But less test code makes the source code bulky and not modular. I want to make the code modular naturally by Test-Driven Development. (By Test-Driven Development, the code naturally becomes modular even when not consciously thinking about it by just thinking of making the code work.)

3. Many existing ones for controlling hardware are focusing on Robots (controlling motors). My objective is for developing a controller for DC-DC converter. Because of it, what makes existing ones good (for robotics) sometimes makes the code I need difficult to write for my objective. 

If you are trying to decide which one to use without spending too much time to investigate each one of them, I would suggest eliminate this one from your list so that there is one less project to investigate. 

But you are always welcome to use this gem. You may find that this one can serve for your purpose. 

## Installation

Add this line to your application's Gemfile:

    gem 'beaglebone_black_ruby'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install beaglebone_black_ruby

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/beaglebone_black_ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
