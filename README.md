# Events Module API Server

This application is a part of NBOS Network developed by Wavelabs Team. This application have ready to use Events module API. Here is the [link](http://nbos.in/docs/module/module.html) to know more about NBOS Modules. 

## Requirements
* Ruby 2.2.3
* Rails 4.2.4
* Mysql

## Setup
  Step1. Clone the repository & install required gems
  ```shell
  $>git clone https://gitlab.com/wavelabs/module-events-rails.git
  $>cd module-events-rails
  $>bundle install
  ```

  Step2. Database Configuration, After successful installation of all dependencies, Open config/database.yml & update with your local mysql credentials. And run the following commands.
  ```shell
  $>rake db:create
  $>rake db:migrate
  ```
  
  It will create the database schema & events related tables. 
  
  Step3. If you don't want to use cache skip this step, otherwise install & run the Redis server. uncomment the Redis Config section in config/application.yml file.


  Step4. Run the application. 
  ```shell
  $>rails server
  ```

  Step5. Now Your Rails Events Module API server is ready.

## Events Module API

  * To interact with NBOS IDN API Server we need client credentials(client_key & client_secret) & module credentials(client_key, client_secret, module_key & scope of the token verify).
  * To get client credentials first register [here](http://console.nbos.io) & create a project ge the client_key, client_secret. 
  * To get module client credentials register [here](http://dev.nbos.io) & create a module get the client_key, client_secret & module_key.
  * Admin will approve the module which you have created.
  * Once your module get approved you can find that module in project dash board marketplace where you have created your project.
  * You can subscribe that module to your project. Now you are ready.
  * We have already those details & configured in config/idn_config.yml file. 
  * Following are ready to use APIs of Events module.

  URL                                                   | Method | Authorization      | Body(JSON format)
  ----------------------------------------------------- | ------ | ------------------ | ----------------
  htpp://localhost:3000/api/events/v0/events            | GET    | Client/User Token  |  NA 
  htpp://localhost:3000/api/events/v0/events            | POST   | User Token         | {"name": "test", "address": "Hitech City", "start_date": "10-10-2016" , "end_date": "10-10-2016", "start_time": "9:30", "end_time": "17:00","location": "Hyderabad" }
  htpp://localhost:3000/api/events/v0/events/:id        | PUT    | User Token         | {"name": "test", "address": "Hitech City", "start_date": "10-10-2016" , "end_date": "10-10-2016", "start_time": "9:30", "end_time": "17:00","location": "Hyderabad" }
  htpp://localhost:3000/api/events/v0/events/:id        | GET    | User Token         |  NA
  htpp://localhost:3000/api/events/v0/events/:id/attend | POST   | User Token         |  NA
  htpp://localhost:3000/api/events/v0/media             | POST   | User Token         | {"image_file": "File Object"}
  htpp://localhost:3000/api/events/v0/media             | GET    | User Token         |  NA