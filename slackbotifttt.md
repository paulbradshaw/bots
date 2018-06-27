# How to: create a Slack alert bot for Parliament events using IFTTT

First, you will need to [set up an account on IFTTT](https://ifttt.com/). IFTTT is a website which connects different services - in this case we are going to connect an RSS feed to a Slack channel to create an alerts bot every time a new item is added to the RSS feed.

Use the X in the upper right corner to skip the introductory steps.

Next, click on your name in the upper right corner and from the drop down menu select **New Applet** (a bot, in other words), or go to [https://ifttt.com/create](https://ifttt.com/create).

You will be presented with the words **if this then that** in large letters (this is what IFTTT stands for: 'this' is the trigger and 'that' is the action you want to happen when the applet is triggered). 

The 'this' will be blue with a plus button next to it. Click on it to choose what you want your trigger to be.

You will be asked to *Choose a service* for your trigger. You can browse lots of services at the bottom of the page, or use the search box to find them individually. The trigger you need to select is **RSS Feed** - it's one of the first options. 

Once you click **RSS Feed** you will be taken to Step 2: *Choose trigger*. For RSS feeds there are two options: *New feed item* or *New feed item matches*. 

Click **New feed item**.

Now you need to fill in a box marked *Feed URL*. To find that URL we need a little detour...

## Finding the RSS feed for the Parliament calendar

Parliament publishes a calendar online at [calendar.parliament.uk](https://calendar.parliament.uk/). It has a tab for the House of Commons, and one for the House of Lords. Tucked away in the upper right corner is a link to [RSS feeds](https://www.parliament.uk/site-information/rss-feeds/) - this is what you need.

RSS is often called 'Really Simple Syndication' - in other words, it is like a newswire: a feed of information that can be pulled and used anywhere else on the web. This is exactly what we want to do: pull a feed of calendar events into Slack.

On the [RSS feeds page](https://www.parliament.uk/site-information/rss-feeds/) you will find feeds for different House of Commons and Lords committees, and for each main chamber - and you will also find a feed for *[All calendar feeds](https://services.parliament.uk/calendar/all.rss)*.

It is best to click on that link using a browser like Chrome or Firefox - this is not a HTML page so it won't look particularly pretty and on some browsers it will try to download the file instead. This doesn't matter: you don't need to look at it in the browser, you just need the URL: 

`https://services.parliament.uk/calendar/all.rss`

## Back to IFTTT

Copy that URL and return to the page that you had open on IFTTT.

Paste that URL in the box marked *Feed URL*, and click **Create trigger**.

You'll now be taken back to the 'if this then that' page - only the 'this' should now be replaced with an orange RSS icon, and the 'that' is now blue with a plus icon next to it.

Click '**that**'.

Now you are asked to choose an *action service* - in other words, what you want to happen when the RSS feed *triggers* it.

Use the search box to start looking for **Slack**. Then click it.

You will now be asked to *Connect Slack* - you only have to do this the first time you create an applet for Slack. 

Click **Connect**

A window will pop up asking you to type in the address of your Slack workspace, and then sign in. 

Once you've done this, you will be taken to Step 4: *Choose action*.

For Slack you can only choose one action: **Post to channel**. Select this.

Now you need to provide a bit more detail about which channel you want to post to and how you want to post that. This includes:

* The first drop down menu under *Which channel?* is where you specify whether you want this applet to post to a public channel when triggered, or send a direct message, or post to a private group. 
* Once that's selected, the menu underneath becomes active, and you can select the specific channel, group or user that you want the applet to send an update to.
* The *Message* box should contain two elements at the moment: `EntryTitle` and `EntryUrl`. These are automatically taken from the RSS feed you have provided. But if you click on **Add ingredient** underneath you will see a list of all the fields in the RSS feed which you could also use, including author, content and publication date. You can also customise your message by clicking in the box and adding some extra text such as 'From the Parliament calendar bot:'. When you do this the boxes will change to `{{EntryTitle}} {{EntryUrl}}` - leave those as they are, they are placeholders for the information that is pulled from the feed, which you can incorporate into your text.
* The *Title* box underneath that specifies, in the same way, what is used for the message title (again this is taken from the feed)
* *Title URL* should always contain the URL for the feed item
* And *Thumbnail URL* is where you specify any URL that can be used for image thumbnails. As it happens our feed has a field for that: `EntryImageUrl`, and it's already been selected. 

Apart from the channel you want to use, you can leave all of these as defaults.

Then click **Create action**

## Review and finish

You are now on the final step. You should now be seeing a summary of the applet that you've just created: "*If New feed item from https://services.parliament.uk/calendar/all.rss, then Post a message to a Slack channel*"

Underneath that box is a switch: *Receive notifications when this Applet runs*. It is currently switched on - it's a good idea to leave this on so you will get emails when it's working. But once you're happy that it's working and you don't want those emails any more, you can return to this page and turn it off.

Click **Finish**

You now get a bigger version of the summary you just saw. This one, however, adds a date of creation, and when it was last run. Note that it says *Never run* because it will normally wait a few hours to run for the first time. 

Click **Check now** to force it to run now.

## That's it.

That's it. You now have a Slack bot (applet) set up to publish alerts to a channel whenever a new feed item is added to the Parliament calendar RSS feed. If you ever want to turn it off, or change its settings, you can just log back in to IFTTT and click on **[My Applets](https://ifttt.com/my_applets)**, then click on the applet and edit it accordingly.

