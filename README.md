#minimongoid

Mongoid inspired models. For your Meteor app. Kinda. Be sure to check out the [post](https://coderwall.com/p/_q9b1w) on my coderwall.

## Installation

For now, download [minimongoid.coffee](https://github.com/haihappen/minimongoid/blob/master/minimongoid.coffee) and place it into your Meteor app. Dont forget to install the `coffeescript` package:

```sh
meteor add coffeescript
```

## Usage

```coffeescript

class User extends Minimongoid
  isValid: ->
    @attributes.name.length >= 3

# Haters gonna hate!
User.new(name: 'Bob').save()

User.create name: 'Bob' # => User
User.create name: '' # => false

User.where(name: 'Bob').toArray() # => [User]

User.count() # => 1
```

Be sure to checkout the [implementation](https://github.com/haihappen/minimongoid/blob/master/minimongoid.coffee) for the full API.

## Testing

For now, you can test it using the meteor packages test suite. Copy the whole folder to your `/local/copy/of/meteor/packages` folder, and then run `../../meteor` from inside the `minimongoid` folder. Visit [localhost:3000](localhost:3000) to run the test suite. (Running the whole Meteor test suite isn't supported, cause minimongoid is implemented in CoffeeScript.)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

(The MIT license)

Copyright (c) 2013 Mario Uher

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.