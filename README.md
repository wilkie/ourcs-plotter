## Install

I can always help. Installing things is frustrating.

You *might* need to install ruby.

https://www.ruby-lang.org/en/downloads/

You will also need to install gnuplot and imagemagick.

http://www.gnuplot.info/download.html
http://www.imagemagick.org/script/binary-releases.php

## Setup

First, make a directory in /data and /implementation with your name.

To do that (replace your_name with your name or handle):

```
mkdir data/your_name
mkdir implementation/your_name
```

Second, copy the examples:

```
cp data/wilkie/* data/your_name
cp implementation/wilkie/* implementation/your_name
```

## Now, you can at this point look at how my example works (again, substitute my name, wilkie, with your own)

```
ruby plot.rb wilkie
```

## Take a look at output.gif

## Now, think about the data you would like to visualize... and find that data.

https://nycopendata.socrata.com/ - New York City civic data (download as JSON or XLS)
http://www.pewresearch.org/data/download-datasets/ - Pew research data (tech usage, social trends, demographics) (usually in XLS)

Put all of your data in data/wilkie

## Write code!

In DataLoader, you figure out how to load the data from the files you are using

- my example loads from json and from an xls (excel spreadsheet)

In DataAnalysis, you can rework some of the data

- in my example, I extended values that were missing by simply naively using existing data

In DataPlot, you can plot your result

- gnuplot examples are examples/line.rb and examples/box.rb
- gruff examples are examples/pie_chart.rb
- you can just drop one of those in, and adjust it until it works for you :)
