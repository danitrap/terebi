# Terebi

## Tips n' Tricks

### Copy all the series' banners in your media folder

Run `rails c`

```ruby
dir = Pathname.new(APP_CONFIG["media_path"])
series = dir.children.select { |d| d.directory? }.map { |d| File.basename(d) }
series.each do |s| 
  FileUtils.cp(Series.where(:name => s).take.cached_poster.path, APP_CONFIG["media_path"] + "/" + s) rescue next 
end
```