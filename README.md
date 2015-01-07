# Shopify CSV to Heroku Postgre
Takes a shopify customer export CSV and creates a Postgre database table on Heroku. Also has some functions to manipluate the data.

Requires ruby 2.1.*

1. Sign up for Heroku if you don't have an account
2. Install the Heroku toolbelt https://toolbelt.heroku.com/
3. Go to https://postgres.heroku.com/databases and create a Postgre database
4. Note down the App name, eg: heroku-postgres-bb1f6cas
5. Export your Shopify customer CSV and save it as data.csv in this directory
6. Import the CSV with the following command (replace heroku-postgres-bb1f6cas with your App name):

```
ruby import-csv.rb heroku-postgres-bb1f6cas
```
7. The importer will add an ID column to match ID's to emails run:
```
ruby parse-emails.rb heroku-postgres-bb1f6cas
```