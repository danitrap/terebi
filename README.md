# Terebi

Terebi is a simple web based media center.

It was born as a tool for me to manage all my TV Series.

![Home page](https://raw.github.com/danitrap/terebi/master/screenshots/home_page.png)

![Series page](https://raw.github.com/danitrap/terebi/master/screenshots/series_page.png)

![Episode list page](https://github.com/danitrap/terebi/raw/master/screenshots/episode_list_page.png)

## Installation

Terebi is a Ruby app based on Rails, Thin, SQLite, and DelayedJob.

It is supposed to run locally as it auto-downloads subtitles and opens your media player of choice.

* Clone this repository
* Run `bundle install` to install dependencies.
* Run `rake db:migrate` to create the database and add the schema.
* Run `rake terebi:install` to configure and update terebi's database.
* Run the server `foreman start`
* Enjoy!

## Updating the app

From the app's directory:

    git pull
    rake db:migrate
    foreman start

## Development

Run the Ruby tests with `rspec`.

## Contribution

Feel free to fork this repo, create a branch with your new features, and send me pull requests. I'll be happy to merge them!

## Acknowledgements

Most of the work is done by TvdbParty and Suby.

The nice design is a courtesy of Twitter Bootstrap. 

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
