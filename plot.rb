require './implementation/wilkie/data_loader.rb'
require './implementation/wilkie/data_plot.rb'
require './implementation/wilkie/data_analysis.rb'

data = DataLoader.new.pull_data

xs, ys = data[:x_series], data[:y_series]

# Make use of data
xs, ys = DataAnalysis.new.analyze(xs, ys)

# Plot data
DataPlot.new.plot(data[:title], xs, ys, data[:labels], data[:x_label], data[:y_label])
