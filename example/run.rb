#!/usr/bin/env ruby

require './models/broadcaster'
require './models/delivery'
require './models/material'
require './models/order'
require './models/discount'

standard_delivery = Delivery.new(:standard, 10.0)
express_delivery = Delivery.new(:express, 20.0)

broadcaster_1 = Broadcaster.new(1, 'Viacom')
broadcaster_2 = Broadcaster.new(2, 'Disney')
broadcaster_3 = Broadcaster.new(3, 'Discovery')
broadcaster_4 = Broadcaster.new(4, 'ITV')
broadcaster_5 = Broadcaster.new(5, 'Channel 4')
broadcaster_6 = Broadcaster.new(6, 'Bike Channel')
broadcaster_7 = Broadcaster.new(7, 'Horse and Country')

material1 = Material.new('WNP/SWCL001/010')
material2 = Material.new('ZDW/EOWW005/010')

express15 = Discount.new(:delivery_price_reduction, 15, :express)
express15.define_min_deliveries(2)

spend30 = Discount.new(:percent_off, 10)
spend30.define_min_spend(30)

current_discounts = [express15, spend30]

order1 = Order.new(material1, current_discounts)

order1.add broadcaster_1, standard_delivery
order1.add broadcaster_2, standard_delivery
order1.add broadcaster_3, standard_delivery
order1.add broadcaster_7, express_delivery

order2 = Order.new(material2, current_discounts)

order2.add broadcaster_1, express_delivery
order2.add broadcaster_2, express_delivery
order2.add broadcaster_3, express_delivery

print order1.output
print "\n"

print order2.output
print "\n"
