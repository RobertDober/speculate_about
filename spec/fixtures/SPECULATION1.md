# A short but feature complete speculation

## This does nothing...

as the headline did not start with `Context`

So let us put a global `let` here which will exist on the
root level

```ruby :include
  let(:value){ 42 }
```

The following will create a context however

### Context no config

Now we can create an example:
```ruby :example
  expect(value).to eq(42)
```

Let us change context

### Context with config

```ruby :before
  @half = value / 2
```

Now an example like the following will pass:

```ruby :example
  expect(@half).to eq(21)
```

However this will not apply anymore if we change the context

### Context without `@half`, overriding value

```ruby :include
  let(:value){ 0 }
```
```ruby :example
  expect(@half).to be_nil
```
```ruby :example
  expect(value).to be_zero
```
