# How to turn spreadsheet data into bot scripts

One obvious way to use bots is as a way for people to ask questions of your data, such as:

* What is the data like in my area?
* How does the data relate to people like me?
* What does the data say about this time period?
* What does the data say about this type of thing?

Rather than write each individual **trigger**, and then each individual **response**, you can automate the creation of that script, using simple spreadsheet formulae. 

Here's how:

## Prepare your data

First, think about what you want your bot to be able to answer when asked a question. It's likely to be a standard response, where elements change depending on the particular thing being asked about. For example:

`- In [CITY A] the crime rate is [RATE A]`

You might also want to add a bit of context. For example:

`- In [CITY A] the crime rate is [RATE A], which is [ABOVE/BELOW] the national average of 10%`

It helps to start with a set of data where there is a row for each possible question. For example: a row with data for each local authority, or each type of crime.

Create a copy of that data, and remove any data you don't need.

Create a new column for any *new* data you might need - in the example above, you will need a new column saying whether each area's rate is "higher" or "lower" than the national average.

## Create a trigger column

Now create a new column for your triggers - an obvious name for that column would be **trigger**.

You are going to fill this column with a trigger for each row. The trigger for Hartlepool in RiveScript in Dexter, for example, might look like this:

`+ [ * ] hartlepool [ * ]`

Note that it begins with a plus sign. If your area names are in column A, you can generate this code in your trigger column by typing a formula like this:

`="+ [ * ] "&LOWER(A2)&" [ * ]"`

This formula does 4 things:

* Inserts a *string* of characters at the start and end of the code which is always the same: `="+ [ * ] "` and `" [ * ]"`
* Grab the area name: `A2`
* Turn that name lower case, using the `LOWER` function. This is because triggers cannot have capitals in Dexter. It is also worth noting that other special characters also cause problems, so you might want to add a `SUBSTITUTE` function or two, to replace full stops or similar characters with nothing. An example might be: `SUBSTITUTE(LOWER(A2),".","")`
* And inserts the result between the two strings of characters, using the ampersand operator: `&`

If you copy that formula down the column, it will repeat this for A3, A4, and so on until the end, so that you have hundreds of triggers.

## Create a response column

Now to do the same for your responses. Create another column, called **response**.

Let's say our response looks like this:

`- In Hartlepool the ratio of lower quartile house price to lower quartile gross annual workplace based earnings was 3.46 in 2016`

Note that it begins with a minus sign. This time we need to grab not just the area name, but the value associated with it. If that value was in column C, here's how a formula might look:

`="- In "&A2&" the ratio of lower quartile house price to lower quartile gross annual workplace based earnings was "&C2&" in 2016"`

This formula does 4 things:

* Inserts three different *strings* of characters: at the start, in the middle, and at the end.
* Grab the area name: `A2` - note we don't need to turn it lower case in the response.
* Grab the value for that area: `C2`
* Insert those cells between the strings of characters, using the ampersand operator: `&`

If you copy that formula down the column, it will give you another few hundred reponses.

## Combining triggers and responses

Now the tricky bit: in Dexter, we need each trigger to be above the corresponding response - but here they're next to each other.

You're going to need another two columns for this. Call the first one **trigger number** and in the first two cells, type `2`.
