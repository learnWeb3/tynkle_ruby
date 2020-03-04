# Tynkle

Tynkle est une plateforme de dépannage informatique entre particuliers


## Ruby && Rails version

ruby 2.5.1p57
Rails 5.2.4

## Configuration

### Local 

1) Download, clone the repository

```
git clone https://github.com/AntoineLGA/u-select-review.git
```

2) Add .env file and .gitignore file to root directory

```
touch .env
touch.gitignore
```


3) Add API keys for services in .env file


```
GOOGLE_API_SERVER_KEY='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
GOOGLE_GEOCODING_SERVER_KEY='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'


GOOGLE_CLIENT_ID= '7xxxxxxxxxxxxxxxxxxxx.apps.googleusercontent.com'
GOOGLE_CLIENT_SECRET= 'xxxxxxxxxxxxxxxxxxxxxxxxxx'

FACEBOOK_APP_ID ='xxxxxxxxxxxxxxxxxxxxxxx'
FACEBOOK_APP_SECRET = 'xxxxxxxxxxxxxxxxxxxxxxxxxx'
```

4) Install gems dependencies through bundler

```
bundle install
```

5) Set up Default account on platform

In seed default account is email "antoineleguillouhadrien@outlook.com", password:"foobar"
please change it !


6) Create Database, pass migrations and Seed database

```
rails db:create
rails db:migrate
rails db:seed
```

7) Lauch local server

```
rails s and provide credentials for default user
```



## HEROKU

1) Initialize a git repository and add all changes to it

```
git init
git add *
git commit -m 'what are commiting for ?'
```

2) Create Heroku app

```
heroku create appName
```

3) Push on heroku 

```
git push heroku master
```

4) Pass api keys as environnement variables 

Please refer to amazing documentation from heroku support

https://devcenter.heroku.com/articles/config-vars

5) Pass migration and seed database

```
heroku run rails db:migrate
heroku run rails db:seed
```

6) Set up Default account on platform

Spotify connect prompt for default user grants rights to application access


## USAGE

TO BE AMEND 

## Future improvements

ADMIN DASHBOARD AND ACTIONS // OFFER INDEX VIEW TO DISPLAY USER OFFERS WITH TABS EXPIRED/ACCEPTED/REJECTED



Regards





