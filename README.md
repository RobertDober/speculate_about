[![Issue Count](https://codeclimate.com/github/RobertDober/speculate_about/badges/issue_count.svg)](https://codeclimate.com/github/RobertDober/speculate_about)
[![Gem Version](https://badge.fury.io/rb/speculate_about.svg)](http://badge.fury.io/rb/speculate_about)
[![CI](https://github.com/robertdober/speculate_about/workflows/CI/badge.svg)](https://github.com/robertdober/speculate_about/actions)
[![Coverage Status](https://coveralls.io/repos/github/RobertDober/speculate_about/badge.svg?branch=master)](https://coveralls.io/github/RobertDober/speculate_about?branch=master)
[![Gem Downloads](https://img.shields.io/gem/dt/speculate_about.svg)](https://rubygems.org/gems/speculate_about)

# Speculate About


## What is it?

A Literate Programming TDD/BDD intented as a [QED](https://github.com/rubyworks/qed/) replacement

Like [QED](https://github.com/rubyworks/qed/) Markdown files are used to present the user with
readable, verified documentation, however instead of depending on [ae](https://rubygems.org/gems/ae/) as
a testing framework _Speculate About_ creates an `RSpec` file for each markdown file.

This has some advantages

  - easy debugging in case of problems inside the Markdown file
  - reparsing of the Markdown file for a test run is only needed in case the compiled RSpec file is out of date
  - CI does not even know about `speculate_about`, in theory it could be removed from the Gemfile and CI would still work


The inconvenience is that you need to run `bundle exec speculate` to assure the compiled RSpec files are up to date, and you need to dedicate
the directory `spec/speculation` to the generated RSpec files.

For me it is a little prize to pay, and for you?

## Installation

```sh
gem install speculate_about
```

With bundler

```ruby
group :development, :test do
  gem 'speculate_about'
end
```

## Introduction

Speculate allows to extract `RSpec` contexts, examples, `lets` and other macros, as well as `before`
blocks from any text file.

As a matter of fact this file's speculations are tested with `speculate_about` meaning: _itself!_

```sh
  speculate a_relative_path # --> creates spec/speculations#{a_relative_path}_spec.rb

  speculate **/*.md # which is the default and can therefore be omitted →

  speculate
```

Now what will the code above do?

Given a markdown file `doc/desc.md` contains the following code

    # Hello

    ## Context An Adder

    Given an adder, like so
    ```ruby
      before { @a = 41 }
      let(:adder) { :succ.to_proc }
    ```
    Then we can assume
    ```ruby
      expect(adder.(@a)).to eq(42)
    ```

then the `speculate` binary will create a file `spec/speculations/doc/desc_rspec.rb` with the following content

     # DO NOT EDIT!!!
     # This file is generated from "doc/desc.md" with the speculate_about gem, if you modify this file
     # one of two bad things will happen
     # - your documentation specs are not correct
     # - your modifications will be overwritten by the speculate CLI
     # YOU HAVE BEEN WARNED
     RSpec.describe "doc/desc.md" do

        # from lines #3...
        context "An Adder" do

           # from lines #7...
           before { @a = 41 }
           let(:adder) { :succ.to_proc }

           # from lines #12...
           it "we can assume" do
             expect(adder.(@a)).to eq(42)
           end
        end
     end

### How to write Markdown files containing Speculations

Actually it is very simple, there are only three concepts

#### Contexts

we can create contexts with header lines that start with `Context` or  `Context:` they get nested according to the level of the headers

#### Inline Code

this is code which is generated inside the context or global `RSpec.describe` code (as in lines 7 onward in the example above) this code
is triggered by a normal markdown line starting with one of the following words:
- `Given`
- `When`
which needs to be immediately followed by a ` ~~~ruby` code block (backticks are fine too of course)

#### Examples

this is code that is wrapped by an `it ...`  block (as in lines 12 onward in the example above)
it is triggered by a normal markdown text line starting with one of the following words:

- `Then`
- `And`
- `Or`
- `But`
- `Example`
- `Also`
which, needs to be immediately followed by a ` ~~~ruby` code block (backticks are fine too of course) again,

## LICENSE

Copyright 202[0-2] Robert Dober robert.dober@gmail.com

Apache-2.0 [c.f LICENSE](LICENSE)
<!-- SPDX-License-Identifier: Apache-2.0 -->
