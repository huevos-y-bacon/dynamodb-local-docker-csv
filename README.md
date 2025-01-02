# DDB local (docker) with csv table scripts

- See [Deploying DynamoDB locally on your computer](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DynamoDBLocal.DownloadingAndRunning.html#docker)
- Update accounts.csv and run `run_all_the_scripts.sh` or run the scrips individually.

- **Notes:**
  - *__This does not work on my M1 Macbook!__ Run on Ubuntu instead (x64)*
  - `_env` because `.env` gitignored
  - `version` removed
  - `user: "root"` added to `docker-compose.yml` (see [this](https://stackoverflow.com/a/73870386)).
    - _Due to error: `docker local dynamodb com.almworks.sqlite4java.Internal log dynamodb-local | WARNING: [sqlite] cannot open DB[1]: com.almworks.sqlite4java.SQLiteException: [14] unable to open database file`_
