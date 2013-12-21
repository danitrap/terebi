# Terebi

Terebi is a simple web based media center.

It is born as a tool for me to manage all my TV Series.

![Home page](http://i.imgur.com/c6zag4Y.jpg)

![Series page](http://i.imgur.com/G1LVF1C.jpg)

## Installation

Terebi is a Ruby app based on Rails, Thin, SQLite, and DelayedJob.

It is meant to be ran locally as it auto-downloads subtitles and opens your media player of choice.

* Clone this repository
* Run `bundle install` to install dependencies.
* Run `rake db:migrate` to create the database and add the schema.
* Run `rake terebi:install` to configure and update terebi's database.
* Run the server `rails s`
* Enjoy!

## Updating the app

From the app's directory:

    git pull
    rake db:migrate
    rails s

## Development

Run the Ruby tests with `rspec`.

## Contribution

Feel free to fork this repo and send me pull requests. I'll be happy to merge them!

## Acknowledgements

Most of the work is done by TvdbParty and Suby.

The nice design is a courstesy of Twitter Bootstrap. 

## License

Copyright (c) 2013 Daniele Trapani

MIT License

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
