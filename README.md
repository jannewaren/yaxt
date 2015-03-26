# README

This application is made purely by request, as a proof-of-skill. If you don't want to run it yourself, you can also just check it here: http://s-yaxt.jannewaren.fi

Requirements for the application:

* Allows user to upload an XML file and specify name and description of that file (text input, text area).
* Stores the actual file on disk and the information about the file in the database (name, description, upload IP, file name and size).
* Shows a list of uploaded files and allows removal of an entry in that list.
* For each entry in the list (representing one XML file), allow the possibility to check if a certain node exists in the XML, via Ajax (node name supplied by user of the app in a text box, you need only to check if it exists or not and respond with 'node exists / does not exist in the xml')

Notes / extra features / pros:

* Store both filenames, the user filename and internal system filename (do not use the user's filename to save the file)
* Show XML content (it was not strictly required)
* Show last five uploads in front page
* Search for a tag in two places:
  * Listing entries
  * Show entry
* Performance: go trough the file nodes once, and then search "in live mode"
* Ignores case-sensitivity in either direction when search for a node

Cons:

* Did not use TDD
* No real exception handling


## Ruby version

Tested using Ruby 2.2.1 and Rails 4.2.0

## How to run the test suite

Run the command "bundle exec rspec"

## How to run the application (in develpoment)

1. git clone https://github.com/jannewaren/yaxt
2. bundle
3. bundle exec thin start
