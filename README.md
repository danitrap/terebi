# Terebi

Terebi is a simple web based media center.

## Installation

Clone this repository, create and edit the config file at `/config/settings.yml`:

    ---
    # path to your media folder.
    # please use slashes instead of backslashes even on windows.
    # and no trailing slashes!
    media_path: F:/Tv Shows

    # preferred locale for subtitles.
    subs_locale: it

    # the player you wish to use.
    # remember to escape any backslashes.
    player: C:\\Program Files (x86)\\K-Lite Codec Pack\\Media Player Classic\\mpc-hc.exe

* Run `bundle install` to install dependencies.
* Run `rake db:migrate` to create the database and add the schema.
* Run `rake terebi:update` to update terebi's database.
* Run the server `rails s`

Enjoy!

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
