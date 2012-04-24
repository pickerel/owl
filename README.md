OWL
===

**Objects-With-Lua:** Object-oriented programming in Lua for Corona SDK.

* **Module:** betterclass.lua
* **Version:** 1.0.0
* **License:** MIT (see below)
* **Author:** Jonathan Beebe
* **Website:** [http://jonbeebe.net]()

### Features

* Constructor/initializers
* Classes for display objects, as well as non-display objects.
* Fast creation of new object instances from specified parent class.
* Create metamethods for objects easily with property callbacks.
* Familiar OOP methods: is_a(), kind_of(), instance_of()
* Private class data via .private table of class.
* Multi-level inheritance.

### Important Notes

* Object instances have two reserved properties (cannot read or write): **private** and **display_obj**
* Object instances have three read-only properties: **className**, **superClass**, and **callbackProperties**

### Usage

For examples of usage from basic to advanced, see included sample projects (which should run as-is in the Corona Simulator) &mdash; COMING SOON.


### MIT License

Copyright &copy; 2012 Jonathan Beebe

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.