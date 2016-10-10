FrontLearn
=================
Here I'm trying to raise up my skills in web-development.

Project based on [Mayak Rails website template](http://mayak.io).

Getting Started
---------------

You can find required version of Ruby in file `.ruby-version` in the root directory of the application.

If you use RVM, add [.ruby-gemset file](http://stackoverflow.com/questions/15708916/use-rvmrc-or-ruby-version-file-to-set-a-project-gemset-with-rvm) to the root directory of the application.

Create file `config/database.yml` for database connection with content like:

    development:
      adapter: postgresql
      database: project_name
      pool: 5

There is `config/database_example.yml` for full example.

When done, run:

    $ bin/bundle install --without production
    $ bin/rake db:create db:migrate

You can install demo data using command: `bin/rake db:seed`

Application ready for start. You can launch webserver with command `bin/rails server` and see home page at [localhost:3000](http://localhost:3000/) url.