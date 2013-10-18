## Setup

First, make a directory in /data and /implementation with your name.

To do that (wilkie is my name):

```
mkdir data/wilkie
mkdir implementation/wilkie
```

Second, copy the examples:

```
cp data/data.json data/wilkie
cp implementation/data_plot.rb implementation/wilkie
cp implementation/data_analysis.rb implementation/wilkie
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
