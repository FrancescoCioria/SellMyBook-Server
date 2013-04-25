SellMyBook-Server
=================

parse_setup
-----------

This is the script (written in ruby) that uploads the test data to the parse bckend. This script also serves as reference for the **schema** (parse_setup_schema.rb).

Test data is contained in parse_setup_data.rb, the schema is in parse_setup_schema.rb. The file parse_setup_lib.rb is a helper file, do not touch it.

Before using the script, you have to create a file named config.json in the same directory, like this:

```json
{
	"api_key" : "kh6w4ftqw4tcq4cqw3tKy9ndIcIV8pI54YesnTi2FG9rk",
	"application_id" : "829vXMeUUtvoVTREpDMShr99d8PHakwCOby1zrIb2L"
}
```

replace with real keys ;-)

then to run the script, simply do:

```bash
>> ruby parse_setup_data.rb
```

