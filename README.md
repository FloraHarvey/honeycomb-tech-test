# Honeycomb Engineering Test - Makers Edition

## The challenge

We have a system that delivers advertising materials to broadcasters.

Advertising Material is uniquely identified by a 'Clock' number e.g.

* `WNP/SWCL001/010`
* `ZDW/EOWW005/010`

Our sales team have some new promotions they want to offer so
we need to introduce a mechanism for applying Discounts to orders.

Promotions like this can and will change over time so we need the solution to be flexible.

### Broadcasters

These are the Broadcasters we deliver to

* Viacom
* Disney
* Discovery
* ITV
* Channel 4
* Bike Channel
* Horse and Country


### Delivery Products

* Standard Delivery: $10
* Express Delivery: $20

### Discounts

* Send 2 or more materials via express delivery and the price for express delivery drops to $15
* Spend over $30 to get 10% off

### What we want from you

Provide a means of defining and applying various discounts to the cost of delivering material to broadcasters.

We don't need any UI for this, we just need you to show us how it would work through its API.

## Examples

Based on the both Discounts applied, the following examples should be valid:

* send `WNP/SWCL001/010` to Disney, Discovery, Viacom via Standard Delivery and Horse and Country via Express Delivery
    based on the defined Discounts the total should be $45.00

* send `ZDW/EOWW005/010` to Disney, Discovery, Viacom via Express Delivery
     based on the defined Discounts the total should be $40.50

## Approach

There are two parts to this challenge, creating discounts and calculating discounts. In order to make the discount feature flexible, and to allow users in other parts of Honeycomb's business to add new discounts there needs to be a way for them to input the details of a promotion, and for that to automatically define a new discount. Second, current discounts need to be applied to the calculation of total order cost.

The following user stories break down the necessary features:

```
As a member of Honeycomb's marketing team,
So I can entice new customers
I want to be able to define a new discount at any given time

As a marketer,
So I can specify what the discount should apply to
I want to define the conditions and details of a discount

As a customer,
So I am charged the amount I am expecting
I want current discounts to be automatically applied to the total cost of my order
```

## Structure of the programme

- Discount class should allow user to define details of a new discount
- Current discounts should be passed into the order as arguments
- Total cost should automatically apply current discounts
- To consider: should multiple discounts be applied? In what order? Based on the example given, the delivery discount will need to be applied first, followed by the minimum spend discount.
