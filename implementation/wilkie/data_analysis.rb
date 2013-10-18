class DataAnalysis
  require 'json'

  def analyze(series_x, series_y)
    # Here we can alter or adjust the data

    # We could remove outliers... normalize the data... whatever we want

    # For me, I'm using years as my x axis, and I want to extend the data
    # with a 'guess' so that data that isn't there is shown on the graph

    # That is, I want to make sure there is a value for every possible year
    # shared by every set of values

    # Get the highest year for each series (returns an array reflecting the
    # highest year for each set of data I have)
    most_xs = series_x.map(&:max)

    # Which year do I need a value for?
    highest_year = most_xs.max

    series_x.zip(series_y, most_xs).each do |xs, ys, most|
      if most != highest_year
        xs << highest_year
        ys << ys[xs.index(most)]
      end
    end

    return series_x, series_y
  end
end
