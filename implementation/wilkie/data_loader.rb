class DataLoader
  require 'json' # Library to load JSON
  require 'roo'  # Library to load XLS

  def pull_data
    # Each plot will be an element in this array
    x_series = [] # One for the x
    y_series = [] # One for the y
    labels   = [] # One to hold a description of the data

    # Load JSON
    json = JSON.load( IO.read("data/wilkie/data.json") )

    # From inspecting the JSON, I know that it is weird.
    # It is a bunch of records which are basic json arrays.
    # The ninth element is the grade level, tenth element is the year, 13th is the mean score

    # Select all eighth grader data
    points = json["data"].select do |data|
      data[9] == "8"
    end

    # It is split up by district, so I want a running total
    grade_x_series = []
    grade_y_series = []
    total = []
    points.each do |point|
      year  = point[10].to_i
      grade = point[13].to_i

      if grade_x_series.include? year
        index = grade_x_series.index year
        grade_y_series[index] += grade
        total[index] += 1
      else
        grade_x_series << year
        grade_y_series << grade
        total << 1
      end
    end

    grade_y_series.each_with_index do |e, i|
      grade_y_series[i] /= total[i]
    end

    # Add this to our overall data pool
    x_series << grade_x_series
    y_series << grade_y_series
    labels   << "8th Grader Math Test Scores"

    # Load XLS
    xls = Roo::Excel.new("data/wilkie/usage.xls")

    # Pull out data for this series
    social_data_y = [] # This will hold the year
    social_data_x = [] # This will hold the actual data

    # Pull out the data from the cells in the excel sheet
    # /^\D+(\d+)$ is a regular expression that pulls out the year
    #   since the cells contain things like 'Dec. 2000' ... we only
    #   want the '2000' part.
    social_data_y << xls.sheet(0).cell(23, 'C')
    social_data_x << xls.sheet(0).cell(6, 'C')[/^\D+(\d+)$/,1].to_i

    social_data_y << xls.sheet(0).cell(23, 'D')
    social_data_x << xls.sheet(0).cell(6, 'D')[/^\D+(\d+)$/,1].to_i

    social_data_y << xls.sheet(0).cell(23, 'E')
    social_data_x << xls.sheet(0).cell(6, 'E')[/^\D+(\d+)$/,1].to_i

    # no data for 2007

    social_data_y << xls.sheet(0).cell(23, 'G')
    social_data_x << xls.sheet(0).cell(6, 'G')[/^\D+(\d+)$/,1].to_i

    social_data_y << xls.sheet(0).cell(23, 'H')
    social_data_x << xls.sheet(0).cell(6, 'H')[/^\D+(\d+)$/,1].to_i

    x_series << social_data_x
    y_series << social_data_y
    labels   << "% Teens Using Online News"

    # Pull out data for general internet usage
    # It is the same as before
    usage_data_y = []
    usage_data_x = []

    usage_data_y << xls.sheet(0).cell(8, 'C') * 100 # For some reason, they entered this as a %
    usage_data_x << xls.sheet(0).cell(6, 'C')[/^\D+(\d+)$/,1].to_i

    usage_data_y << xls.sheet(0).cell(8, 'D')
    usage_data_x << xls.sheet(0).cell(6, 'D')[/^\D+(\d+)$/,1].to_i

    usage_data_y << xls.sheet(0).cell(8, 'E')
    usage_data_x << xls.sheet(0).cell(6, 'E')[/^\D+(\d+)$/,1].to_i

    usage_data_y << xls.sheet(0).cell(8, 'F')
    usage_data_x << xls.sheet(0).cell(6, 'F')[/^\D+(\d+)$/,1].to_i

    usage_data_y << xls.sheet(0).cell(8, 'G')
    usage_data_x << xls.sheet(0).cell(6, 'G')[/^\D+(\d+)$/,1].to_i

    usage_data_y << xls.sheet(0).cell(8, 'H')
    usage_data_x << xls.sheet(0).cell(6, 'H')[/^\D+(\d+)$/,1].to_i

    x_series << usage_data_x
    y_series << usage_data_y
    labels   << "% Teens On the Internet"

    # Return the result
    return {
      :x_series => x_series,
      :y_series => y_series,
      :labels   => labels,
      :x_label  => "Year",
      :y_label  => "Average Test Score / Utilization",
      :title    => "Grades vs Tech Usage"
    }
  end
end
