# Create RSpecs from Markdown Files

One could call this the Poor Man's Unitrusive Literal Testing Tool

## Terminology

* `Speculation` a markdown file containing code blocks marked as _speculate_.
* `Spec` a `RSpec` file created from the _speculations_ from a `Speculation`.



## Synopsis

Such an approach comes with advantages as well as with disadvantages

As we just create `RSpec` specifications it is up to the literal documenter
to assure compatibility with the used RSpec version (and that RSpec is used).

Then the `speculate` binary will just generate a Spec for each Speculation

Speculations are found in `spec/speculations` by default, which can be
overwritten by the `dir: ...` parameter.

All markdown files are considered Speculations, which can be overwritteb
by the `glob: ...` parameter (beware of the usually required shell escaping).

The resulting specs are created inside `spec/speculations` too.
If you do not like your speculations and specs to live side by side (in harmony)
you can change this with the `dest: ...` parameter.

## Examples

```ruby speculate
describe Speculate do
  let(:subject){ described_class }
  it 'is a module' do
    expect( subject ).to be_kind_of(Module)
  end
end
    
```
