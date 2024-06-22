# TrueLogicTest

## Description
This project is for the take-home TrueLogic test: 

1. In the attached file (w_data.dat), you’ll find daily weather data. Download this text file, then write a program to output the day number (column one) with the smallest temperature spread (the maximum temperature is the second column, the minimum the third column).
2. The attached soccer.dat file contains the results from the English Premier League. The columns labeled ‘F’ and ‘A’ contain the total number of goals scored for and against each team in that season (so Arsenal scored 79 goals against opponents, and had 36 goals scored against them). Write a program to print the name of the team with the smallest difference in ‘for’ and ‘against’ goals.

## Installation
### Prerequisites
- Ruby 3.3.3 or later

### Clone the repository
To get started with this project, you need to clone the repository to your local machine. Open your terminal and run the following command:

```bash
git clone https://github.com/hehuhdez/truelogictest.git
```

### Install dependencies
Once you have cloned the repository, navigate to the project directory and install the required dependencies. Run the following command:

```bash
bundle install
```

### Run the project
After installing the dependencies, you can run the project using the following command:

```bash
ruby main.rb
```

This will run the project with the default fixture examples. 

You can also run the specs in case you're curious about a specific method.

```bash
  bundle exec rspec
```

## Exploring the solution

### Using a module
While I started originally with the `WeatherData` class my intention was always to move things into a module as a way to DRY-up my code. This decision came to be given the following reasons:

- Both exercises require to read data from a file
- Both exercises need to get the minimum spread between two values

The only real difference is how the data is processed as they have different keys and different structure. That is why the `DataMethods#get_data` method will raise an exception if is not implemented in the included class. 

```ruby
  def get_data(file)
    raise 'NotImplementedError'
  end
```

### Reading the data

For both examples I decided to split the data and select only the relevant information based on the `length` of each line.

```ruby
  table_lines = file.split("\n").select { |line| line.length == 89 }
```

This is obviously not the best approach as can be seen by the soccer example

```ruby
  table_lines = file.split("\n").select { |line| line.length >= 58 && !line.include?('---') }
```

Not all lines have the same length and while we can do more filtering, like in the case of the soccer exercise, it is not perfect. And it all comes down to the delimiter. The provided files are tabulated separated values but, the file does not make use of special escape sequences (i.e.  `\t` `\s`) nor character delimiters.

So the issue is pretty obvious when looking at the weather example

```ruby
  columns = table_lines.first.strip.split
  table_lines[1..-1].map do |line|
    columns.zip(line.strip.split).to_h
  end
```

Once we have our data separated from our header, stripping each line from trailing whitespace and splitting the string we create a hash with the `zip` method using the header column names as keys. However, since we have missing data points we end up assigning values to the wrong key. I tried not to focus too much on this aspect as for the purposes of the exercise the temperature data was correct. But this is something that I definitely need to improve if I had more time. 

In the soccer example it was actually easier, as we didn't have missing data, meaning that we could simply do a split with a regex, or in my case I decided to use the `scanf` module and make it match a format based on what I saw from the file

```ruby
  FORMAT = "%21c %d %d %d %d %d - %d %d"

  columns = table_lines.first.strip.split
  table_lines[1..-1].map do |line|
    columns.zip(line.scanf(FORMAT)).to_h
  end
```

The format of the soccer data is a 21 length character followed by 5 integer numbers then a dash and we continue with two more integers. I could not use the same approach for the weather data as the way `scanf` works is by converting based on the specifiers (the character following `%`) however there is no specifier for whitespace so I can't get an array with the empty spaces like that. 

There are definitely some improvements that could have been made, but for the sake of time I didn't want too much time on the parsing of the data. 

### Calculating the spread

The spread method is defined in the `DataMethods` module 

```ruby
  def calculate_minimum_spread(min_key, max_key)
    min_spread = nil
    min_spread_item = nil

    @data.each do |item|
      spread = get_spread(item[min_key], item[max_key])

      if min_spread.nil? || spread < min_spread
        min_spread = spread
        min_spread_item = item
      end
    end

    min_spread_item
  end
```

It has a time complexity of O(n) meaning that once we have our data array we just need to iterate over all the elements once to get the item with the minimum spread. Since we moved this into the module we need to pass the name of the minimum and maximum keys of the data array. This time could be improved to O(log n) if we used a different data structure like a MinHeap however given the ask I did not see fit to implement a class like that into this project. If we had more operations to get data based on keys or a need to update the data I could see the implementation of a more complex data structure worth it. 

Once we have the minimum item we just have to access the value given the Key and do formatting if required

```ruby
  def calculate_team_with_minimun_spread
    calculate_minimum_spread(GOALS_FOR_KEY, GOALS_AGAINST_KEY)[TEAM_KEY].strip
  end
```

## License
This project is licensed under the [MIT License](https://opensource.org/licenses/MIT). See the [LICENSE](LICENSE) file for more details.