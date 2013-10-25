class DataPlot
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
        plot.output "./public/output.gif"

        # see sin_wave.rb
        min_x = series_x.map(&:min).min
        min_y = series_y.map(&:min).min
        max_x = series_x.map(&:max).max
        max_y = series_y.map(&:max).max

        plot.xrange "[#{min_x}:#{max_x+2}]"
        plot.yrange "[#{min_y}:#{max_y}]"

        plot.title title

        plot.xlabel x_label
        plot.ylabel y_label

        plot.boxwidth 0.5
        plot.style "fill solid 1.00 border -1"

        plot.style "data histograms"
        plot.style "histogram columnstacked"

        xs = series_x.first

        data = []
        data << xs

        series_y.each do |ys|
          data << ys
        end

        plot.data << Gnuplot::DataSet.new( data ) do |ds|
          ds.with = "boxes"
          ds.title = "A"
          ds.using = "($1):($2+$3)"
        end

        plot.data << Gnuplot::DataSet.new( data ) do |ds|
          ds.with = "boxes"
          ds.title = "B"
          ds.using = "1:3"
        end
      end
    end
  end
end
