# Honeycomb Engineering Test - Makers Edition

## The challenge

We have a system that delivers advertising materials to broadcasters.

Advertising Material is uniquely identified by a 'Clock' number e.g.

* `WNP/SWCL001/010`
* `ZDW/EOWW005/010`

Our sales team have some new promotions they want to offer so
we need to introduce a mechanism for applying Discounts to orders.

Promotions like this can and will change over time so we need the solution to be flexible.

### Delivery Products

* Standard Delivery: $10
* Express Delivery: $20

### Discounts

* Send 2 or more materials via express delivery and the price for express delivery drops to $15
* Spend over $30 to get 10% off

## Examples

Based on the both Discounts applied, the following examples should be valid:

* send `WNP/SWCL001/010` to Disney, Discovery, Viacom via Standard Delivery and Horse and Country via Express Delivery
    based on the defined Discounts the total should be $45.00

* send `ZDW/EOWW005/010` to Disney, Discovery, Viacom via Express Delivery
     based on the defined Discounts the total should be $40.50

## Approach

I identified two parts to this challenge, creating discounts and calculating discounts. In order to make the discount feature flexible, and to allow users in other parts of Honeycomb's business to add new discounts there needs to be a way for them to input the details of a promotion, and add it to the list of current promotions. Current discounts then need to be applied to the calculation of total order cost.

The following user stories break down the necessary features:

```
As a member of Honeycomb's sales team,
So I can entice new customers
I want to be able to define a new discount at any given time

As a salesperson,
So I can specify what the discount should apply to
I want to define the conditions and details of a discount

As a customer,
So I am charged the amount I am expecting
I want current discounts to be automatically applied to the total cost of my order
```

## Structure

- Discount class allows user to add details of a new discount by passing in arguments: type of discount, value of discount (either as a percentage or reduced price), and optionally, the item type the reduced price refers to
- Current discounts should be passed into the order as arguments
- Total cost automatically applies current discounts, in the order they have been passed
- This solution is flexible, as salespeople can add new discounts with different offers such as 10%/20% off or reducing the express or standard delivery price to any amount. They can add conditions to the offer, such as a minimum spend, or a minimum number of materials sent by either standard or express delivery, but these conditions are optional.
- They can then add any created discounts to a list of current promotions, which can then optionally be applied to new orders.


## How to use
- Clone this repo
- Run `ruby run.rb` to view example output
- Run `rspec` to view the tests

## Example
Below is the output from the examples provided in the spec.

![output](https://github.com/FloraHarvey/honeycomb-tech-test/blob/master/example_output.png)

## Improvements to the code

- I looked into views around using instance variables to hold details vs using self.property plus `attr_accessor`, and found conflicting opinions. I decided to go with self to maintain consistency with existing code, but I felt that it may not be necessary to expose public accessors at this stage as discount (and order) properties are only modified within a specific instance, therefore I would consider changing these back to instance variables without `attr_accessor`. I made the attr_accessors private so properties would not be exposed to modification.
-  I don't particularly like the use of double-bang when checking if the discount conditions have been met due to lack of clarity, but it is a concise way of returning a boolean, rather than nil if the condition hasn't been specified.
- I debated how to calculate total cost with discount given multiple discounts and decided on a while loop which passes the new order total after each discount has been applied to the next one in the list. It does the job despite being a bit lengthy - I would like to explore some other ways to do this, which would require a different way of structuring the Discount class.


## Ideas for extension

- The programme currently only supports two types of discount (percent-off and delivery price reduction) given in the example - further code would have to be written to allow more flexible offers such as 2 for 1, but this could be addressed when the need arises.
- To extend this project, I would suggest adding a current promotions class to allow salespeople to manage the list of current discounts - there could be functions to add/remove/save created discounts.
