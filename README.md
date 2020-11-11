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
