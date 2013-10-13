Twitter Fetch
=============

JSON API to fetch tweets of a user in a specified Date Range. Made this for another project of mine. So just putting it here.


Before Using
------------
1. Sign up for Twitter Dev account.
2. Get a "Consumer Key", "Consumer Secret", "OAuth Token" and "OAuth Secret".
3. Edit the 'TwitterUser' model and save these values.


```
  TCLIENT = Twitter::Client.new(
    :consumer_key       => "Your Consumer Key",
    :consumer_secret    => "Your Consumer Secret",
    :oauth_token        => "Your OAuth Token",
    :oauth_token_secret => "Your OAuth Secret"
  )
```

Operations
----------

### Parse

You need to parse a user before you can apply date-range operations. On reloading, if you get status 'completed', then you're are ready to apply operations. To parse:

http://localhost:3000/parse/user/**twitterhandle**/

### Fetch

Once parsed, you can get all the tweets in a specified Date-Range (Format: YYYY-MM-DD). To fetch:

http://localhost:3000/parse/user/**twitterhandle**/tweets/from/**2013-1-1**/to/**2014-1-1**/


A few things to know
--------------------

1. Twitter's API allows the retrieval of only 200 statuses per call and only 16 such calls per user can be placed at a time. That means you can only retrieve 3200 tweets of any user (Little changes required in code to get all).
2. Each call is expensive and a little slow. This time delay builds up when you're fetching thousands of tweets, so please wait a little. You can first test it with a user with <400 tweets.
3. You need to have a Delayed Job's Worker instance (`rake jobs:work`) running to do the parsing and whatnot.


Built using
-----------

- Ruby 1.9.3
- Rails 3.2.3
- Mongoid 3.0
- Delayed Job 2.0 (for Mongoid)
- The `Twitter` Gem by [sferik](https://github.com/sferik/twitter)


Blah Blah
----------

Added Devise to the project too. I don't know why. Just did.