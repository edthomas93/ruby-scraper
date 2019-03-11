## Approach

I was hoping to implement all philosophies that I have learnt at Maker's so far. This included creating user stories and then creating Test-Driven, readable, modularised, DRY code to satisfy these desired features. However as time was limited to 2 hours I focused on creating a finished product and then testing it with the time I had left. To ensure as much of the project was tested as possible I decided to do a feature test covering 90% of the code.

## How to use

#### 1. Open your terminal and open the repository with your chosen IDE:
e.g. `atom ./songkick-tech-test`

#### 2. Install the gemfiles. The gems are rspec to see all passing tests, simplecov to see the test coverage and rubocop to see any formatting errors:
`bundle install`

#### 3. To see if the tests are passing and the coverage type from the folder 'bank_tech_test':
`rspec`

#### 4. To run the program start IRB:
`irb`

#### 5. Require file you wish to use:
`require './lib/scraper.rb'`

#### 6. Create an instance of the scraper class:
`scraper = Scraper.new`

#### 7. View all the upcoming concerts in an easy to read format with the number of pages you want to view (large numbers can take a long time to load). The following would show the first 2 pages ( there are 10 results per page):
`scraper.print_list(2, 'view')`

#### 8. View all the upcoming concerts in JSON format. Input the number of pages' results you would like to see:
`scraper.print_list(2, 'json')`

#### 9. Save the json to the public folder (will overwrite the pre-existing file):
`scraper.create_json_file`

#### 10. When finished, exit IRB:
`exit`

#### 11. If you would like to the access JSON file open the file with your preferred IDE:
`atom './public/temp.json'`

#### User stories:
```
As a music lover,
To make decisions on upcoming concerts,
I would like a detailed list of concerts with details such as the artist, city, venue, date and price.
```