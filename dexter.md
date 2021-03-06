# Creating Facebook Messenger bots with Dexter

[Dexter](https://rundexter.com) is a platform for creating bots (you can [find a list of alternatives on my bookmarks for 'bots+tools'](https://pinboard.in/u:paulbradshaw/t:bots+tools)). In this tutorial I'll explain how to create a basic Facebook Messenger bot using Dexter, and some ideas for developing it further.

By the way, you'll [find some useful background on bots in journalism in this extract from the second edition of the Online Journalism Handbook](https://onlinejournalismblog.com/2016/12/21/how-bots-came-to-play-a-role-in-journalism-a-brief-history/)

Before you begin, you will need to do the following:

* Register for a free account with Dexter (click on '*Make your first bot*' or '*Sign in*')
* Create a [Facebook Developer account](https://developers.facebook.com/apps/)
* [Create a Facebook Page](https://www.facebook.com/help/104002523024878) to host your bot, if you don't have one already (you can [see all your pages here](https://www.facebook.com/bookmarks/pages)). This could be a [professional profile page for you as a journalist](https://www.facebook.com/James-Ball-146632022068073/), or a journalistic project, or a publication, or a spin-off page devoted to a particular niche (like [Birmingham Eastside Technology](https://www.facebook.com/bhameastsideTech/))

Dexter has a [quick start guide](http://docs.rundexter.com/quick-start/) which walks you through the process of creating a basic bot, along with various other guides to particular aspects of bot creation along the left hand navigation. Those guides will be very useful to refer to as you continue. This tutorial is going to take some aspects of those and apply them to a journalistic context.

## Create your first bot

Make sure you are logged into Dexter and at the page [rundexter.com/bot](https://rundexter.com/bot). 

Click the **New Bot** button on the left hand side, and give your bot a name, like 'eastsidebot' or 'crimebot'.

You will be asked to pick one of 4 templates that Dexter uses:

* FAQ Bot
* Character Bot
* Quiz Bot
* Blank Project

It is useful at some point to open each of these templates and try to reverse-engineer how they are made. For example:

* The quiz bot adds values to an overall score which is used to then generate a final 'rating' or 'decision'.
* The FAQ bot has different 'threads' that it will follow based on user choices
* The character bot just responds to different keywords, without threads or scores

Choose the **Character Bot** - we'll end up deleting most of it, but here goes...

## Reverse engineering the Character Bot

Once you've selected Character Bot you will be taken to the editing screen, which has 3 parts:

* On the left are all the *Topics* (threads) for the bot. At the moment there's only a *default*, but you can add more by clicking *New Topic*.
* In the middle is the area where you specify the **triggers** and **responses** that you want to encode into your bot. For example, you might specify that 'hello' is a trigger, and the bot will respond in a certain way to that trigger (for example saying hello back!)
* On the right is a *simulator* where you can test the bot that you've created, by typing messages and seeing how it responds

Now let's look more closely at the template code that's already been provided for us. Some things to note:

* Each trigger starts with a plus sign `+`, and the responses to that come after a minus sign, in the line beneath. Typing `+` at the start of a line indicates that you are specifying something that the user might type (a trigger), and typing - at the start of a line indicates the response you want to script. Try typing two new lines - one starting with `+` and the other with `-` - below the code that's already written, and see what happens.
* If you have more than one `-` sign, that means you are specifying multiple possible responses, and the script will choose one randomly from those. Try typing 'space' in the simulator and pressing enter, and keep doing it until you see a different response to the first.
* You can have multiple possible inputs by putting words in brackets separated by the pipe symbol, ilke so: `science (rules|rocks|is great)` - this trigger will run when someone types 'science rules' *or* 'science rocks' *or* 'science is great'
* The asterisk sign `*` has a special meaning: it means *one or more of any character*
* An asterisk sign in square brackets `[*]` has a slightly different special meaning: it means *none or more of any character*

The difference is important. For example, the trigger `* 10% * brain` will only be triggered when someone types *something* followed by the characters '10%' followed by *something* followed by 'brain'. If they typed '10% brain' it would not be triggered.

The trigger `[*] space [*]`, on the other hand, will be triggered by the word 'space' on its own, or *any sentence* containing the word 'space'.

## Deciding what you want your bot to do

Before adding your own commands, think what your bot is going to do. The best ideas serve a purpose for your audience, so think: 'What stories do I have which would work well with user interaction?' or 'What problems do my audience have that a bot might help with?'

## Adding your own commands

The first command is normally triggered by the user typing anything (indicated by the asterisk sign), or a greeting like 'hello/hi/sup'. Delete the asterisk trigger, then, and replace it with this:

`+ (hi|hello|sup|yo)`

The first response needs to introduce our bot and what they do, before ideally presenting some options. So delete the response that's there at the moment and type:

`- Hello, I am the Birmingham Eastside bot. I'll tell you what's happening in Birmingham. What do you want to know?`

You can add buttons, links or images by clicking on the code/arrow button (`</>`) just above the code area and selecting the appropriate option. Click on there now and select *Insert Buttons*

![](https://raw.githubusercontent.com/paulbradshaw/bots/master/images/dexter_insert_buttons.png)

This will insert this code:

`^buttons(First Choice, Second Choice, Third Choice)`

You can replace 'First Choice' with whatever you want to be the first choice, and so on. These buttons will be represented in Messenger as numbered options, prefixed by `[1]`, and so on. Let's go with some easy options:

`^buttons(What is Birmingham Eastside?, Where is Eastside?, What's the latest story?)`

Now you can test this in the simulator by typing one of the prompts like 'hi', and seeing how it responds.

Now to add our answers. Because the options are numbered, we should anticipate that some people will simply type the number as their response. We can also add some asterisks to anticipate partial responses like so:

```
+ (1|[*] what[*]|[*] birmingham eastside[*])
- Birmingham Eastside is a news site for people working in Birmingham city centre’s Eastside district, near Millennium Point. In addition to the city centre, we cover stories in other areas of Birmingham, such as Moseley, Kings Heath, Edgbaston, Selly Oak, Perry Barr, Solihull and Sutton Coldfield.
```

Note that we're using **only lower case letters** in the trigger. If you use any capitals, it will generate an error. 

### Adding links and images


### Adding a catch-all response

It's useful to have a response when the bot doesn't understand what has been said. This should always be the last trigger in your list, and should look like this:

```
+ [*]
- Sorry, I didn't understand that. I'm only a bot with limited understanding. Please try again.
```

Now for the second response. For this we're going to use [some text from Wikipedia](https://en.wikipedia.org/wiki/Eastside,_Birmingham) - and add an image and a link:

```
+ (2|[*] where[*])
- Eastside is an area centred on Birmingham City University's Parkside campus and the new HS2 development around Curzon Street station, but it also takes in the Aston University campus and fire station to the north, Digbeth, Fazeley Street and South Birmingham College to the south, and the Bullring to the West.
```

To add an image after this text use the same insert button you used to select 'Insert Button', but this time select 'Insert Image'. This code will appear:

`^image("url")`

Replace "url" with an actual image URL. I'm going to take the image from that Wikipedia entry, like so:

`^image("https://upload.wikimedia.org/wikipedia/commons/b/be/BirminghamEastsideMap.png")`

Repeat the process for a link:

`^link("<url>","<title>")`

And change it to the correct URL and title:

`^link("https://en.wikipedia.org/wiki/Eastside,_Birmingham","Wikipedia")`

When you test this you will notice that the image loads first, even though it appears after the text in your code. And the link title appears in square brackets, which isn't great, but there you go.

### Adding an RSS feed

To add an RSS feed use the `^getRSSFeed` shortcode, as [detailed in the documentation for Dexter](http://docs.rundexter.com/writing/shortcodes/get-rss-feed/), like so:

```
+ (3|[*] story[*])
- The 3 most recent stories on Birmingham Eastside are: ^getRSSFeed("http://birminghameastside.com/feed/", 3, "desc")
```

### Adding a catch-all response

It's a good idea to have a final trigger which catches all other possible things the user might type, and serves up a response that explains that it has not understood. Note that this should always be positioned last so it only runs *if* none of the other triggers have been triggered.

```
+ [*]
- Sorry, I didn't understand that. I'm only a bot with limited understanding. Please try again.
```

You can also get this response to trigger another response, such as the initial greeting, by adding it in curly brackets with an @ sign before it, like so:

`{@hello}`

When it is included, it will look like this:

```
+ [*]
- Sorry, I didn't understand that. I'm only a bot with limited understanding. Please try again.{@hello}
```

Make sure that your initial greeting works in this context, or break it up so that it does.

### Using information that has been entered

You can also use the asterisk - or *star* to pull information that has been entered, like so:

```
+ my name is *
- It's great to meet you, <star>!
```

The `<star>` bit in the response, is a placeholder for whatever the person typed after `my name is `

If you have more than one star, you can specify it by number like so:

```
+ my * name is *
- It's great to meet you, <star2>!
```

(try typing 'my first name is paul')

### Explore the documentation for other options

There's a lot more you can do - [explore the documentation](http://docs.rundexter.com/quick-start/) (see the navigation on the left) to see what's possible, and examples that you can adapt for your own purposes.

## Testing on Facebook

Once you've got something you're happy to try out on Facebook, click **Publish** in the top right corner. (*Note: if you have more than one topic in your bot, you will need to publish each one*)

Now click on the **Platforms** menu across the top bar.

![](https://raw.githubusercontent.com/paulbradshaw/bots/master/images/dexter_platforms.png)

Click on **Messenger** on the left to turn it on, then follow the instructions. At some point you will be invited to get some details from the app settings page (the URL will be something like https://developers.facebook.com/apps/43819489128491/roles/) - but with the number of your page in the middle.) Keep this page open as you'll need it later.

Once you've deployed your app, you should be given a link to the bot in this sentence:

*On Facebook, this is as easy as going to an m.me link that points to your page ID: http://m.me/246458182109398*

At the moment only you will be able to chat with the bot, but you can add other users by going to that app settings page on Facebook I said to keep open. Switch to the **Roles** view and click *Add testers* to begin adding other users that you want to be able to use it.

Once you're happy to make it public, switch to the **App Review** view on that app settings page, and click **Start a submission** to go through an approval process. You can [find out more about this process on Dexter's help pages here](http://docs.rundexter.com/platforms/facebook/)

## Making further changes

When you want to make more changes to your bot you can do this on Dexter, remembering to click **Publish** on all topics that have been updated, and then switching to the *Platforms* view and clicking **Deploy** to deploy those changes to the version on Facebook itself.

## Broadcasts

You can set up your bot to send a 'broadcast' message once per day (but no more often). This is similar to the news alerts you may have seen from news organisations' bots. You can [find more information about how to set up broadcasts on the Dexter documentation](http://docs.rundexter.com/broadcasts/tutorial/).

## Using APIs

One of the most powerful ways you can use a bot is to connect it with an API that can deliver responses based on information supplied by the user. [Dexter's documentation outlines some examples here](http://docs.rundexter.com/writing/advanced/http-requests/)

One simple UK example to try is the postcodes.io API which returns information for a particular postcode (but the postcode must be without spaces):

```
+ postcode *
$ GET http://api.postcodes.io/postcodes/<star>
- <star> is in the local authority of ${{result.admin_district}}, the clinical commissioning group is ${{result.ccg}} and the constituency is ${{result.parliamentary_constituency}}
```
