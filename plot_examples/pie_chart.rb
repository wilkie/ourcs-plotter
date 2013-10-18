class DataPlot
  require 'gruff'

  def plot(title, series_x, series_y, series_titles, x_label, y_label)
    g = Gruff::Pie.new
    g.title = title

    series_x.first.zip(series_y.first).each do |x, y|
      g.data(x, y)
    end

    g.write("./public/output.gif")
  end
end
