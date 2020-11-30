## Task model
| Column name | Data type |
|:------------|:-----------|
| title       | string     |
| content     | text       |
| duedate     | datetime   |
| status      | string     |
| priority    | integer    |
| user_id     | integer    |
## User model
| Column name | Data type |
|:----------------|:-----------|
| name            | string     |
| email           | string     |
| password_digest | string     |
## Label model
| Column name | Data type |
|:------------|:-----------|
| name           | string     |
##  Bag label model
| Column name | Data type |
|:------------|:-----------|
| task_id     | integer    |
| label_id    | integer    |
*****

## Deploying on Heroku

1. Login
 - Login first]using the command
 ```heroku login ```


2. Create an app on heroku using
  ```heroku create```


3. Send codes to heroku from main branch using
  ```git push heroku main ```


4. Run migrations on heroku using
  ```heroku run:detached rails db:migrate```
