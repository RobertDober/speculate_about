[![Build Status](https://travis-ci.org/RobertDober/speculate_about.svg?branch=master)](https://travis-ci.org/RobertDober/speculate_about)
[![Code Climate](https://codeclimate.com/github/RobertDober/speculate_about/badges/gpa.svg)](https://codeclimate.com/github/RobertDober/speculate_about)
[![Issue Count](https://codeclimate.com/github/RobertDober/speculate_about/badges/issue_count.svg)](https://codeclimate.com/github/RobertDober/speculate_about)
[![Test Coverage](https://codeclimate.com/github/RobertDober/speculate_about/badges/coverage.svg)](https://codeclimate.com/github/RobertDober/speculate_about)
[![Gem Version](https://badge.fury.io/rb/speculate_about.svg)](http://badge.fury.io/rb/speculate_about)

# Speculate

Extract RSpec example groups from Markdown

## Introduction

Speculate allows to extract `RSpec` contexts, examples, `lets` and other macros, as well as `before`
blocks from a text file.

As a matter of fact this file is used to specify behavior of its own library simply by means of the following
code to be found in [an RSpec spec](spec/speculate_about/readme_spec.rb):

```ruby
  RSpec.describe "README.md" do

    speculate_about description

  end
```

Now what will the code above do?

It will extract code from this file which is annotated and inject it into the `RSpec::ExampleGroup` instance in
which `speculate_about` has been invoked.

And here is how we can generate this code:

## Examples

First of all if we create a code block marked with `ruby :example`, an `RSpec::Example` will be generated.
Here is such an example (pun intended):

```ruby :example
    list = []
    expect(list).to be_empty
```

If you run `rspec spec/speculate_about/readme_spec.rb --format doc`
the following output will be generated

```
README.md
  Speculations from README.md
    Example from README.md:40

Finished in 0.00259 seconds (files took 0.14353 seconds to load)
1 example, 0 failures
```


We can see from the above that `speculate_about` creates a _root_ context around all code it injects.

## Macros

If we want to have code that is executed at the `ExampleGroup` level we can create a code block and annotate it with
`ruby :include` so the following two code blocks will also create a passing example:

```ruby :include
    let(:answer){ 42 }
```

```ruby :example
    expect(answer - 42).to be_zero
```

If we now run `rspec spec/speculate_about/readme_spec.rb --format doc --example md:69` or all specs of course we can see
that that worked too.

Of course, if you think that in your context the spec should be explicitly included into your document you still can do
the following (with ` ```ruby :include `)

```ruby :include
  
  context "Lemmings" do
    let(:number) { 42 }
    before do
      @lemmings = [*1..number]
    end
    it "they can fall down" do
      move
      expect(@lemmings).to eq([*1..41])
    end

    def move
      @lemmings.pop
    end

  end
```

This gives a nicer output

```
    
README.md
  Speculations from README.md
    Example from README.md:40
    Example from README.md:69
    Lemmings
      they can fall down

Finished in 0.00327 seconds (files took 0.13579 seconds to load)
3 examples, 0 failures

```

but that is not the idea of this tool, we want just to assure that our documentation is correct.

In the spirit of this tool one would use a ` ```ruby :before`  block together with the `:include` and `:example` block as follows:

```ruby :before
  @lemmings = [*1..number]
    
```

```ruby :include
   let(:number){ 42 } 

   def move
     @lemmings.pop
   end
```

```ruby :example
   move 
   expect(@lemmings).to eq([*1..41])
```


## Contexts

And last but not least we can create contexts (just one level though, a limitation which we consider rather a feature)

Any headline (that is a line starting with one up to seven `#`) wich starts with the word context will create a new context.
It will also close an open context unless the open context is the root context.

Let us watch that in production:

### Context This is sooo coooool

First a let inside a ` ```ruby :include` block:
```ruby :include
  let(:temperature){ 0 }
  let(:just_right){ 42 }
```

Then we set up some heating, inside a ` ```ruby :before` block:

```ruby :before
  @current = temperature

  def heat
    @current += 1
  end
```

And now some philosohical observations, inside a ` ```ruby :example` block:

```ruby :example
  42.times{ heat }
  expect(@current).to eq(just_right)
```

After that the result will read like

```
README.md
  Speculations from README.md
    ...
    This is sooo coooool
      Example from README.md:166
```


## Debugging

## LICENSE

Copyright 2020 Robert Dober robert.dober@gmail.com

Apache-2.0 [c.f LICENSE](LICENSE)  
