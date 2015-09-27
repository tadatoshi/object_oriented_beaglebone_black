## object_oriented_beaglebone_black 0.0.2 (December 26, 2014) ##

* GPIO

* Analog input

* PWM

## object_oriented_beaglebone_black 0.1.0 ##

There is no 0.1.0. I simply made a mistake to change the version to 0.2.0, after changing the version to 0.1.1 in one commit. 

## object_oriented_beaglebone_black 0.2.0 (September 26, 2015) ##

* PWM period can be set and read.

## object_oriented_beaglebone_black 0.2.1 (September 27, 2015) ##

* When the PWM period is set, the internal "duty" value is modified automatically to keep the same duty cycle. 

  Internally in BeagleBone Black, "duty" value is relative to "period" value. 

    e.g. For "period" = 1000, "duty" = 500 gives the duty cycle = 500 / 1000 = 0.5. 

  In version 0.2.0, when "period" is modified, "duty" is not modified. Hence, the duty cycle changes. 

    e.g. For the example above, 
         When "period" is modified to be 10000, the duty cycle has changed to 500 / 10000 = 0.05. 

  In version 0.2.1, when "period" is modified, "duty" is modified accordingly, in order to keep the same duty cycle. 

    e.g. For the example above, 
         When "period" is modified to be 10000, "duty" is modified to be 5000, which gives the duty cycle 5000 / 10000 = 0.5. 
          
  Note: This can be considered to be incompatible API change. However, at this point, it is not yet considered to be a stable public API. Hence, the MAJOR version is kept to be 0. (See, [Semantic Versioning](http://semver.org/))
