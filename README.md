### Tophatter Merchant API
Full documentation is available [here](https://tophatter.readme.io/v1/docs).

### Console Testing (Development)
echo http://tophatter.dev/merchant_api/v1 > .api_host
echo a42880c4b7d0809300bed27c453f883d > .access_token
bin/console

#### Authentication
```ruby
TophatterMerchant.access_token = <YOUR ACCESS TOKEN>
```

### Products

#### List the product definition.
```ruby
TophatterMerchant::Product.schema
```

#### List all of the products in your inventory.
```ruby
TophatterMerchant::Product.all(page: 1, per_page: 100)
```

#### Search for products.
```ruby
TophatterMerchant::Product.search(query: 'Shirt', page: 1, per_page: 100)
```

#### Retrieve a specific product.
```ruby
TophatterMerchant::Product.retrieve('WAH5282')
```

#### Create a product.
```ruby
TophatterMerchant::Product.create(
  identifier: '6631A',
  category: 'Electronics|Hardware (Computers/Tablets/Phones)|Mobile',
  title: 'Apple iPhone 6S',
  description: 'This is the description.',
  condition: 'Refurbished - Manufacturer',
  starting_bid: 1,
  buy_now_price: 150,
  cost_basis: 75,
  shipping_price: 5.0,
  shipping_origin: 'United States',
  weight: 6,
  days_to_fulfill: 3,
  days_to_deliver: 5,
  variations: {
    '6631A-WHITE': { identifier: '6631A-WHITE', color: 'White', quantity: 1 },
    '6631A-BLACK': { identifier: '6631A-BLACK', color: 'Black', quantity: 2 }
  },
  primary_image: 'https://d38eepresuu519.cloudfront.net/b2aa7d2708324f756ffee551ba43a74f/original.jpg',
  extra_images: 'https://d38eepresuu519.cloudfront.net/e615c55184c06f391dbd768f855904e6/original.jpg|https://d38eepresuu519.cloudfront.net/7cd125f0fa42c965675eabaf3309aa6d/original.jpg'
)
```

#### Update a product.
```ruby
TophatterMerchant::Product.update('6631A', buy_now_price: 100)
```

#### Disable an enabled product.
```ruby
TophatterMerchant::Product.disable('6631A')
```

#### Enable a disabled product.
```ruby
TophatterMerchant::Product.enable('6631A')
```

### Variations

#### Retrieve a specific variation.
```ruby
TophatterMerchant::Variation.retrieve('6631A-BLACK')
```

#### Create a variation.
```ruby
TophatterMerchant::Variation.create(product_identifier: '6631A', identifier: '6631A-PINK', color: 'Pink', quantity: 33)
```

#### Update a variation.
```ruby
TophatterMerchant::Variation.update('6631A-PINK', quantity: 999)
```

### Orders

#### List all orders.
```ruby
TophatterMerchant::Order.all(filter: 'unfulfilled', page: 1, per_page: 100)
```

#### Retrieve a specific order.
```ruby
TophatterMerchant::Order.retrieve(1035509247)
```

#### Fulfill an order.
```ruby
TophatterMerchant::Order.fulfill(1035509247, carrier: 'USPS', tracking_number: '9400111899562173406594')
```

#### Refund an order.
```ruby
TophatterMerchant::Order.refund(1035509249, type: 'full', reason: 'other')
```
