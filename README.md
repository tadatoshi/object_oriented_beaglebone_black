# BeagleboneBlackRuby

This is for accessing Beaglebone Black pins through Ruby code. 

There are many Ruby projects in GitHub to do a similar thing. 
But I have decided to develop my own from scratch this time instead of using an existing one like I always do.

There are three reasons. 

1. Build my own expertise on controlling Beaglebone Black directly. 

2. Make the code Object-Oriented. 
   e.g. Instead of making the code pin_mode("USR0", "out"), make the code usr0_pin.pin_mode = "out". i.e. Make the PIN object usr0_pin hold the property pin_mode and tell that object to set that property. pin_mode("USR0", "out") is a procedural way of programming and usr0_pin.pin_mode = "out" is an Object-Oriented way of programming. While it is a good idea to follow the same syntax as Arduino's C-language-like code, it is a procedural programming language. Ruby is an Object-Oriented programming language and writing a code in Object-Oriented way in Ruby gives an advantage of using Ruby. 
   That being said, for controlling hardware, I am not against writing Ruby code in script-way, making it more procedural. 
   But I want to write a code in Object-Oriented way, i.e. Beaglebone Black hardware is one object, which contains many objects, such as PIN's. Each algorithm in there is one object. And build the software by interaction and collaboration of those objects. 

3. Many existing ones don't have proper testings. 
   I understand the difficulty of writing a test for a code to control hardware. But less test code makes the source code bulky and not modular. I want to make the code modular naturally by Test-Driven Development. (By Test-Driven Development, the code naturally becomes modular even when not consciously thinking about it by just thinking of making the code work.)

4. Many existing ones for controlling hardware are focusing on Robotics (controlling motors). 
   My objective is for developing a controller for DC-DC converter. Because of it, what makes existing ones good (for robotics) sometimes makes the code I need difficult to write for my objective. 

If you are trying to decide which gem to use without spending too much time to investigate each one of them, I would suggest eliminate this one from your list so that there is one less gem to investigate. 

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
