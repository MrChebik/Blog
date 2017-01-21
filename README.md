#Blog
Create your posts about your life or some else.

##Run
1. Run the *createDB.sh* or do some steps:
    1. Create a database 'Blog' with encoding to UTF-8 (i.e. `CREATE DATABASE Blog DEFAULT CHARACTER SET 'utf8' DEFAULT COLLATE 'utf8_unicode_ci'`)
    2. Run a project to create a tables.
    3. Create a field in *role* table (i.e. *ROLE_USER, ROLE_ADMIN*).
    4. Create a field in *users* table (i.e. *example@mail, admin, admin* with wireless through roles (*user_role* table)).
2. Change *fromEmail* and *password* fields to your real account email (I use Yandex mail for these, i.e. *smtp.yandex.ru*) in ***SMTPServer*** class.
3. Execute: `mvn install tomcat7:run-war`
4. Follow to the link: [_http://localhost:8080/_](http://localhost:8080")