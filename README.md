<img src="https://s3.amazonaws.com/crooklyn/nooklyn.png" alt="Nooklyn">
# Crooklyn
Crooklyn is a small Ruby script that pulls listing data from **[Nooklyn](nooklyn.com)**.

## How To Use Crooklyn

The script depends on HTTParty, so to save time, install the gem before running the script:

```
$ gem install httparty
```

Clone the repo, switch to the 'crooklyn' directory, and run the script:

```
$ git clone git@github.com:martinez-angel/crooklyn.git
$ cd crooklyn
$ ruby crooklyn.rb
```

This will generate a CSV file with filtered listings (from the last 30 days only). An example export is included in the repo as well!

###Disclaimer
**I'm not affiliated with Nooklyn, but s/o to them for the data!**

-
Angel :pray:
