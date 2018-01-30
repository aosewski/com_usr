## Installation 

Useful instructions can be found [here](https://www.redmine.org/projects/redmine/wiki/RedmineInstall) and [here](https://gist.github.com/rotexdegba/e39b6b4f85ac580fe5e0434dbb00beb0).

1. Download sources
    ```bash
    cd ~/Downloads
    wget https://www.redmine.org/releases/redmine-3.4.2.tar.gz
    tar -xvf redmine-3.4.2.tar.gz redmine-3.4.2/
    sudo mkdir -p /opt/redmine
    sudo cp -r redmine-3.4.2/* /opt/redmine/
    cd /opt/redmine
    ```
2. Install Ruby, Rails and postgresql database, and apache2 server
    ```bash
    sudo apt-get install ruby-rails ruby-dev
    sudo apt-get install postgresql postgresql-contrib
    sudo apt-get install apache2 libapache2-mod-passenger
    ```
3. Configure postgresql database. Open postgresql terminal:
    ```bash
    sudo -u postgresql psql
    ```
    Make sure database datestyle is set to ISO (Postgresql default setting):
    ```sql
    ALTER DATABASE "redmine_db" SET datestyle="ISO,MDY";
    ```
    Create empty database (_redmine_) and accompanying user (_redmine_):
    ```sql
    CREATE ROLE redmine LOGIN ENCRYPTED PASSWORD 'redmine' NOINHERIT VALID UNTIL 'infinity';
    CREATE DATABASE redmine WITH ENCODING='UTF8' OWNER=redmine;
    ```
4. Copy config/database.yml.example to config/database.yml and edit this file in order to configure your database settings for "production" environment.
    ```bash
    cp config/database.yml.example config/database.yml
    sudo vim config/database.yml
    ```
    Comment MySQL setup part, uncomment postgresql and edit like this:
    ```yaml
    # PostgreSQL configuration example
    production:
      adapter: postgresql
      database: redmine
      host: localhost
      username: redmine 
      password: "redmine"
      encoding: utf8
      schema_search_path: public
    ```
5. Dependencies installation, secret token, create database schema objects and load default data set
    ```bash
    sudo bundle install --without development test rmagick
    sudo bundle exec rake generate_secret_token
    sudo RAILS_ENV=production bundle exec rake db:migrate
    sudo RAILS_ENV=production REDMINE_LANG=en bundle exec rake redmine:load_default_data
    ```
    Don't forget to re-run `bundle install --without development test ...` after adding or removing adapters in the `config/database.yml` file!
6. Test installation
    ```bash
    sudo bundle exec rails server webrick -e production
    ```
    Now you can see welcome page in you browser at [http://localhost:3000/](http://localhost:3000/)

7. Now Configure Apache
    ```bash
    cd /etc/apache2
    ```

8. Now, create the `redmine.conf` file in the `sites-available` subdirectory with the following content (do this under root):
    ```xml
    <VirtualHost *:3000>
            RailsEnv production
            DocumentRoot /opt/redmine/redmine-3.2.0/public
            <Directory "/opt/redmine/redmine-3.2.0/public">
                    Allow from all
                    Require all granted
            </Directory>
    </VirtualHost>
    ```
    This is the configuration of the virtual host that will run Redmine. However, this is not the only virtual host that we currently have. Please note that Redmine, which is installed and configured this way, is going to run from your user account. If you prefer to use another user, _www-data_, for example,  you need to add PassengerDefaultUser _www-data_ to your virtual host configuration, and change the owner of the `redmine` directory by executing `chown www-data:www-data /opt/redmine -R`
9. Edit passenger config file `/etc/apache2/mods-available/passenger.conf` adding following lines:
    ```xml
    PassengerUserSwitching on
    PassengerUser <user-name>
    PassengerGroup <user-name>
    ```
10. Edit apache2 config file: `/etc/apache2/sites-available/000-default.conf`
    ```xml
    <Directory /var/www/html/redmine>
      RailsBaseURI /redmine
      PassengerResolveSymlinksInDocumentRoot on
    </Directory>
    ```
11. Enable the `redmine.conf` and `passenger` mode: 
    ```bash
    sudo a2ensite redmine
    sudo a2enmod passenger
    sudo ln -s /opt/redmine/redmine/public/ /var/www/html/redmine
    ```
12. Add port 3000 to the `/etc/apache2/ports.conf` file like so:
    ```
    Listen 3000
    ```
13. Restart apache:
    ```bash
    sudo service apache2 reload
    sudo service apache2 restart
    ```
 14. from `/opt/redmine` directory:
    ```bash
    sudo rake generate_secret_token
    sudo rake db:migrate RAILS_ENV=production
    sudo rake redmine:plugins:migrate RAILS_ENV=production
    sudo rake tmp:cache:clear
    sudo rake tmp:sessions:clear
    ```
