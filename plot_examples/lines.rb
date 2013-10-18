class DataSet
  require 'json'
  require 'gnuplot'

  def plot(title, series_x, series_y, series_titles, x_label, y_label)
    Gnuplot.open do |gp|
      Gnuplot::Plot.new( gp ) do |plot|
        # The following lines allow outputting the graph to an image file.
        # The first set the kind of image that you want, while the second
        # redirects the output to a given file.
        #
        # Typical terminals: gif, png, postscript, latex, texdraw
        #
        # See http://mibai.tec.u-ryukyu.ac.jp/~oshiro/Doc/gnuplot_primer/gptermcmp.html
        # for a list of recognized terminals.
        plot.terminal "gif"
        plot.output "./public/sin_wave.gif"

        # see sin_wave.rb
        min_x = series_x.map(&:min).min
        min_y = series_y.map(&:min).min
        max_x = series_x.map(&:max).max
        max_y = series_y.map(&:max).max

        plot.xrange "[#{min_x}:#{max_x}]"
        plot.yrange "[#{min_y}:#{max_y}]"

        plot.title title

        plot.xlabel x_label
        plot.ylabel y_label

        series_x.zip(series_y, series_titles).each do |x,y,title|
          plot.data << Gnuplot::DataSet.new( [x,y] ) do |ds|
            ds.with = "lines"
            ds.linewidth = 4
            ds.title = title
          end
        end
      end
    end
  end
end
