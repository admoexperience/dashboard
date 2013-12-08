Admo Dashboard
--------------

Based on [Shopify's Dashing](http://shopify.github.com/dashing). Check their project page for more info

Required environment variables to get it running on heroku

|ENV Var      | Default Value | Help      |
|-------------|---------------|-----------|
|USER_NAME    | admin         | Basic auth to access the dashboard |
|USER_PASSWORD| password      | Basic auth to access the dashboard |
|UNITS1       | Admo-1,Admo-2 | Which units to display(current 2 per screen/instance) |
|UNITS2       | Admo-3,Admo-3 | Which units to display(current 2 per screen/instance) |


Updating the dashboard either via curl or via code

            curl -i -d '{ "auth_token": "YOUR_AUTH_TOKEN", "screenshotCreatedAt":"2013-12-8 20:43", "checkedinAt":"2013-12-8 20:43", "screenshotUrl":"https://url.to.you.image/screenshot.png"}' http://localhost:3030/widgets/Admo-1


Pictures

![Screenshot](https://bitbucket.org/fireid/admo-dashboard/raw/master/docs/screenshot.png "Screenshot")
