# Minitest Before/After Examples

Are you using minitest?  Do you have a test setup that is too
expensive to be repeated for each test?  Would you rather setup once
before a set of tests and teardown afterwards?  Have a look at these
examples.

The examples in this repository illustrate 16 cases for setup/teardown
before/after all test cases in a describe block.  [Issue 61 of
minitest](https://github.com/seattlerb/minitest/issues/61) inspired
me to create the examples.

The set of examples is not prescriptive, it is descriptive.  Please
apply them juduciously and _Don't Do Anything I Wouldn't Do (tm)_.
When you find a better way for any case, file a pull request.

Run the examples by `bundle`.  For example, to run example file
`spec-eager-flat.rb`, run in your shell the following commands.

```
bundle install
bundle exec rake spec-eager-flat.rb
```

## Examples

- Spec file
  - Eager evaluation
    - Flat describe block
      - With `minitest-hooks`: [spec-eager-flat-hooks.rb](spec-eager-flat-hooks.rb)
      - Without `minitest-hooks`: [spec-eager-flat.rb](spec-eager-flat.rb)
    - Nested describe blocks
      - With `minitest-hooks`: [spec-eager-nested-hooks.rb](spec-eager-nested-hooks.rb)
      - Without `minitest-hooks`: [spec-eager-nested.rb](spec-eager-nested.rb)
      -  **Semantics differ.**
        - Without `minitest-hooks`, the before/after executes before/after ALL
          describe blocks.
        - With `minitest-hooks`, each before(:all)/after(:all) executes
          before/after each nested describe block.  Using `||=` in
          `before(:all)` does not make a difference because the context
	  of each run of `before(:all)` is not the same.  Try
          [spec-eager-nested-hooks-whatfor.rb](spec-eager-nested-hooks-whatfor.rb).
  - Lazy evaluation
    - Flat describe block
      - With `minitest-hooks`: [spec-lazy-flat-hooks.rb](spec-lazy-flat-hooks.rb)
      - Without `minitest-hooks`:
        [spec-lazy-flat.rb](spec-lazy-flat.rb), this corresponds to [the second
        approach](https://github.com/seattlerb/minitest/issues/61#issuecomment-4581115)
        that zenspider explains in issue 61.
    - Nested describe blocks
      - With `minitest-hooks`: [spec-lazy-nested-hooks.rb](spec-lazy-nested-hooks.rb)
      - Without `minitest-hooks`: [spec-lazy-nested.rb](spec-lazy-nested.rb)
- Subclassing of Minitest::Spec
  - Eager evaluation
    - Flat describe block
      - With `minitest-hooks`: [class-eager-flat-hooks.rb](class-eager-flat-hooks.rb)
      - Without `minitest-hooks`: [class-eager-flat.rb](class-eager-flat.rb)
    - Nested describe blocks
      - With `minitest-hooks`: [class-eager-nested-hooks.rb](class-eager-nested-hooks.rb)
      - Without `minitest-hooks`: [class-eager-nested.rb](class-eager-nested.rb)
      - **Semantics differ just like corresponding case for Spec files.**
  - Lazy evaluation
    - Flat describe block
      - With `minitest-hooks`: [class-lazy-flat-hooks.rb](class-lazy-flat-hooks.rb)
      - Without `minitest-hooks`: [class-lazy-flat.rb](class-lazy-flat.rb)
    - Nested describe blocks
      - With `minitest-hooks`: [class-lazy-nested-hooks.rb](class-lazy-nested-hooks.rb)
      - Without `minitest-hooks`: [class-lazy-nested.rb](class-lazy-nested.rb)

## Avoid class variables for Spec examples

minitest Spec files and class variables do not get along very well,
only well.  For example, consider the spec that is like
[spec-lazy-flat.rb](spec-lazy-flat.rb) but with the class instance
variable substituted with a class variable.

```ruby
require 'minitest/autorun'

describe "spec file, lazy evaluation, flat describe block" do

  @@expensive ||= begin
                   puts 'executing something expensive'
                   'woah! expensive!'
                 end

  Minitest.after_run do
    puts "cleaning expensive value: #{@@expensive}"
  end

  it 'test1' do
    puts "test1: #{@@expensive}"
  end

  it 'test2' do
    puts "test2: #{@@expensive}"
  end

end
```

The example runs without failures or errors but with the following
warnings

```
/Users/ruslan/code/minitest-before-after-examples/spec-lazy-flat.rb:8:
warning: class variable access from toplevel
executing something expensive
/Users/ruslan/code/minitest-before-after-examples/spec-lazy-flat.rb:5:
warning: class variable access from toplevel
Run options: --seed 40780

# Running:

/Users/ruslan/code/minitest-before-after-examples/spec-lazy-flat.rb:15:
warning: class variable access from toplevel
test1: woah! expensive!
./Users/ruslan/code/minitest-before-after-examples/spec-lazy-flat.rb:19:
warning: class variable access from toplevel
test2: woah! expensive!
.

Finished in 0.001315s, 1521.1994 runs/s, 0.0000 assertions/s.

2 runs, 0 assertions, 0 failures, 0 errors, 0 skips
/Users/ruslan/code/minitest-before-after-examples/spec-lazy-flat.rb:11:
warning: class variable access from toplevel
cleaning expensive value: woah! expensive!
```

To avoid these ugly warnings, the Spec examples use class instance
variables instead of class variables.

Class examples do not produce warnings when they use class variables.