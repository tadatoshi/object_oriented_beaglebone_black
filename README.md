# ObjectOrientedBeagleboneBlack

This is for using BeagleBone Black in Object-Oriented way through Ruby code. 

There are many Ruby projects in GitHub to do a similar thing. 
But I have decided to develop my own from scratch this time instead of using an existing one like I always do.

There are four reasons. 

1. Build my own expertise on controlling Beaglebone Black directly. 

2. Make the code Object-Oriented. 

   e.g. Instead of making the code pin_mode("USR0", "out"), make the code usr0_pin.pin_mode = "out". i.e. Make the PIN object usr0_pin hold the property pin_mode and tell that object to set that property. pin_mode("USR0", "out") is a procedural way of programming and usr0_pin.pin_mode = "out" is an Object-Oriented way of programming. While it is a good idea to follow the same syntax as Arduino's C-language-like code, it is a procedural programming language. Ruby is an Object-Oriented programming language and writing a code in Object-Oriented way in Ruby gives an advantage of using Ruby. 

   That being said, for controlling hardware, I am not against writing Ruby code in script-way, making it more procedural. 

   But I want to write a code in Object-Oriented way, i.e. Beaglebone Black hardware is one object, which contains many objects, such as PIN's. Each algorithm in there is one object. And build the software by interaction and collaboration of those objects. 

3. Many existing ones don't have proper testings. 

   I understand the difficulty of writing a test for a code to control hardware. But less test code makes the source code bulky and not modular. I want to make the code modular naturally by Test-Driven Development. (By Test-Driven Development, the code naturally becomes modular even when not consciously thinking about it, by just thinking about making the code work.)

4. Many existing ones for controlling hardware are focusing on Robotics (controlling motors). 

   My objective is for developing a controller related to Power Electronics. Because of it, what makes existing ones good (for robotics) sometimes makes the code I need difficult to write for my objective. 

The important point in this gem is that everything is Object-Oriented. 
In other words, controlling hardware in Object-Oriented way, treating everything as an Object. 
For example, Pin is an Object with properties and functions for the pin. 
If you want to do something with a pin, you instantiate Pin Object and ask it to perform operations on it. Pin object takes care of its properties, i.e. the values associated with it and takes care of performing the operations. 

The features of Object-Oriented programming, such as Inheritance, etc. and techniques like Composition (and going further, Patterns), make the code organized and reduce duplication. Makes testing is easier. 

Especially, the bigger your code becomes, the more you get the benefit of Object-Oriented programming. It's easier to trace what the code is doing among the big code base and it's easier to modify the code without influencing the other codes in the big code base. 

## Installation

Add this line to your application's Gemfile:

    gem 'object_oriented_beaglebone_black'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install object_oriented_beaglebone_black

## Usage

1. GPIO 

   Example:

    ```ruby
    require 'object_oriented_beaglebone_black'

    led_gpio_pin_number = 60
    button_gpio_pin_number = 15

    led_gpio = ObjectOrientedBeagleboneBlack::Gpio.new(led_gpio_pin_number)

    led_gpio.export

    led_gpio.direction = ObjectOrientedBeagleboneBlack::IO::Direction::OUT

    led_gpio.value = ObjectOrientedBeagleboneBlack::IO::Value::HIGH

    led_gpio.value  # Read the value. HIGH (1) as set above. 

    led_gpio.value = ObjectOrientedBeagleboneBlack::IO::Value::LOW

    led_gpio.value  # Read the value. LOW (0) as set above. 

    led_gpio.unexport
    ```

2. Analog input

   Example:

    ```ruby
    require 'object_oriented_beaglebone_black'

    pin_key = "P9_40"

    # This can take a few seconds:
    analog_input = ObjectOrientedBeagleboneBlack::AnalogInput.new(pin_key)

    analog_input.raw_value  # Read the raw voltage value in the range of 0 and 1.8[V].

    analog_input.value  # Read the relative value between 0 and 1. 
    ```

3. PWM

   Example: 
 
    ```ruby
    require 'object_oriented_beaglebone_black'

    pwm_pin_key = "P9_14"

    # This can take several seconds:
    pwm = ObjectOrientedBeagleboneBlack::Pwm.new(pwm_pin_key)

    pwm.period = 1000 # Unit is [ns] (nano second)

    pwm.period  # Read the period. 1000[ns] as set above.    

    pwm.duty_cycle = 0.5

    pwm.polarity  # Read the polarity. 
                  # The default is direct:  
                  #   ObjectOrientedBeagleboneBlack::Pwm::Polarity::DIRECT

    pwm.duty_cycle  # Read the duty cycle. 0.5 as set above. 
    ```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/object_oriented_beaglebone_black/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
