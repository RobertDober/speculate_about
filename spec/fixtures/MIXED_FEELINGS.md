And that holds for construction too

```ruby
    expect{ OpenMap.new("verbose" => false) }
      .to raise_error(ArgumentError, %{the following keys are not symbols: ["verbose"]})
```
But many `Hash` methods are applicable to `OpenMap`

Given that

```ruby
    let (:dog) {OpenMap.new(name: "Rantanplan", breed: "You are kidding?")}
```
