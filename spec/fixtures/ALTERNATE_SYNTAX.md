# All Ruby blocks are taken into account, we are in Alternate Syntax Mode


Example: A nifty name

```ruby
    expect(1).to eq(1)
```

Example: Not an example, because

here is a line and not an include either

```ruby
    so_this_will_not_be_included
```

## Context New Alternate Syntax (~> 0.4.0)

However if we start a trigger line with Given or When

Given we have a variable

```ruby
    let(:variable) { true }
```

Then (now triggers an example, too)
```ruby
    expect( variable ).to be_truthy
```


Example: Another one

```ruby
    expect(1).not_to be_zero
```
