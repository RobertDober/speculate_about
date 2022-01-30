# `And` will create setup code **before** `Then` and example code **after** `Then`

## Context: Level 2

Given a number
```ruby
    let(:number) { 42 }
```

And another number
```ruby
    let(:another_number) { 1 }
```

Then their product is
```ruby
    expect(number * another_number).to eq(42)
```

And their difference is
```ruby
    expect(number - another_number).to eq(41)
```
