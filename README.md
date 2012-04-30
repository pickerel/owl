Objects with Lua (OWL)
======================

Easy object-oriented programming in Lua with Corona SDK. Supports display objects, and can also be used with non-Corona Lua scripts.

* **Module:** owl.lua
* **Version:** 1.0.1
* **License:** MIT (see below)
* **Author:** Jonathan Beebe
* **Website:** [http://jonbeebe.net]()


### Features

* Constructor/initializers via init() method of class (or custom per-instance callbacks)
* Classes for display objects, as well as non-display objects.
* Fast creation of new object instances from specified parent class.
* Create metamethods for objects easily with property callbacks.
* Familiar OOP methods: is_a(), kind_of(), instance_of()
* Private class data via .private table of class.
* Multi-level inheritance (to top-most parent class).


### Important Notes

* Object instances have a reserved property that you cannot read or write to: **display_obj**
* Object instances have three read-only properties: **class_name**, **super_class**, and **callback_properties**
* Classes and instances each have their own **private** table (*e.g. object.private*) which does not inherit any data.


### Usage

For examples of usage from basic to advanced, see included sample projects. And although OWL.lua can be used with non-Corona SDK Lua scripts, the samples below are Corona SDK projects that should be run in the Corona Simulator. I recommend you study all of the samples (and corresponding Terminal output), and play around with them to gain a more complete understanding of all the features of OWL.

* Samples/**ExternalClasses** - shows how to separate classes into external modules.
* Samples/**PrivateClassData** - demonstrates how the class 'private' table works.
* Samples/**ClassMethods** - shows how to define and use class methods.
* Samples/**EasyMetamethods** - shows how to use property callbacks to do creative things.
* Samples/**Constructors** - shows how to use class constructors and per-instance constructors.


### MIT License

Copyright &copy; 2012 Jonathan Beebe

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.