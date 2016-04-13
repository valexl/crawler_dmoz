
# Dmoz crawler

## Instalation

You need clone application :

```sh
$ cd workspace #directory where will be current project
$ git clone https://git@github.com:valexl/crawler_dmoz.git
$ cd crawler_sketch
```

You need make bundle install before:

```sh
$ bundle install
```

You need load all industries via rake task:

```sh
$ rake data:load:industries
```

Test that everything is well:

```sh
$ rspec spec
```

Try it in irb:

```sh
$ irb -r ./boot.rb
```

Example how to use:

```ruby
path = "#{Dir.pwd}/data/content.rdf.u8" # content.rdf.u8 - is file downloaded from mounthly backups - http://rdf.dmoz.org/
parser = DMOZParser.new path
parser.load!

```
