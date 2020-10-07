# Rails Engine

Rails Engine is a service-oriented application that builds and exposes multiple API endpoints to the frontend of the application, Rails Driver. The link for the Rails Driver repo is [here](https://github.com/dborski/rails_driver).

Created by [Derek Borski](https://github.com/dborski) for the Backend Engineering Program at the Turing School of Software & Design.

## API Endpoints

### Record Endpoints

#### Items

- Single Item Record
```
/items/:item_id
```
- All Item Records
```
/items/
```
- Create Item
```
post /item
```
- Update Item
```
patch /item
```
- Destroy Item
```
delete /item
```

#### Merchants

- Single Merchant Record
```
/merchants/:merchant_id
```
- All Merchant Records
```
/merchants/
```
- Create Merchant
```
post /merchant
```
- Update Merchant
```
patch /merchant
```
- Destroy Merchant
```
delete /merchant
```

### Relationship Endpoints

#### Items

- Item-Merchant (single merchant associated with given item)
```
/items/:item_id/merchant
```

#### Merchants

- Merchant-Items (collection of all items associated with given merchant)
```
/merchants/:merchant_id/items
```

### Find Endpoints

All find endpoints can accept multiple query parameters to refine results.

### Items

- Find Single Item By Query Parameter
```
/items/find?parameter=value
```
- Find Multiple Items by Query Parameter
```
/items/find_all?parameter=value
```
Supported Parameters:
parameter | description | value type/format
-- | -- | --
id | search based on the primary key | integer
name | search based on the name attribute | string (case-insensitive)
description | search based on the description attribute | string (case-insensitive)
merchant_id | search based on the merchant_id foreign key | integer
unit_price | search based on the unit_price attribute | float with 2 decimal places
created_at | search based on created_at timestamp | YYYY-MM-DD HH:MM:SS
updated_at | search based on updated_at timestamp | YYYY-MM-DD HH:MM:SS

### Merchants

- Find Single Merchant By Query Parameter
```
/merchants/find?parameter=value
```
- Find Multiple Merchants by Query Parameter
```
/merchants/find_all?parameter=value
```
Supported Parameters:
parameter | description | value type/format
-- | -- | --
id | search based on the primary key | integer
name | search based on the name attribute | string (case-insensitive)
created_at | search based on created_at timestamp | YYYY-MM-DD HH:MM:SS
updated_at | search based on updated_at timestamp | YYYY-MM-DD HH:MM:SS

### Business Intelligence Endpoints

- Top `x` Merchants Ranked by Total Revenue
```
/merchants/most_revenue?quantity=x
```
- Total Revenue Generated on Date: start and end = `x` Across All Merchants
```
/merchants/revenue?start=x&end=x
```
- Top `x` Favorite Customers for a Merchant by Total Spent
```
/merchants/:merchant_id/favorite_customers?quantity=x
```
- Top `x` Merchants with Most Items Sold
```
/merchants/most_items?quantity=x
```
- Total Revenue for Single Merchant
```
/merchants/:merchant_id/revenue
```
