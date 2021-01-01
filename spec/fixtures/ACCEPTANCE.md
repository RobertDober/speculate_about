# A complex example

It serves a little bit like an acceptance test in the way that it
tries to cover most combinations of code and keywords, of course
many more tests of edge cases and translations will be needed for
a good test coverage.

However none of those shall be that verbose as this file and its
associated specs.

### Context Level 3

Given

```ruby
    let(:x){1}
    before {}
```

Some text shall not disturb
Then this shall not be the next example's title
But this shall be
```ruby
    expect( 1 ).to be_zero # Who cares?
```

## Context Level 2

This is a nice test as there is no context of level 1 and therfor this context must be attached to
the context of level 0 and the context attached to level 0 needs to be reattached to the new node

No includes, shall not be a problem

And therefore we have
```ruby
    a nice example # We do not check the code, RSpec will do that for us
```
