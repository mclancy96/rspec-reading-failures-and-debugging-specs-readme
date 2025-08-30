# RSpec:Reading Failures & Debugging Specs: Turning Red into Green (and Laughs)

Welcome to Lesson 5! If you’ve ever seen a wall of red text in your terminal and thought, “Uh oh, what did I break?”—congratulations, you’re a real developer! In this lesson, we’ll demystify RSpec’s output, show you how to read failures, and teach you how to use those failures to become a bug-squashing superhero. We’ll go step by step, with lots of examples, analogies, and encouragement. Debugging is a skill, and you’re about to level up!

---

## Why Reading Failures Matters

Every developer writes code that fails sometimes. (If you don’t, you’re probably a robot. Or lying.) The key is learning how to read those failures, understand what they’re telling you, and use them to fix your code. RSpec’s output is like a treasure map: follow the clues, and you’ll find the bug. Think of failures as your code’s way of waving a little flag and saying, “Hey! Something’s not right here!”

Debugging is not a sign of failure—it’s a sign you’re making progress. Every red message is a step closer to green.

## Visualizing RSpec Output: Red, Yellow, and Green

Here's what RSpec output might look like in your terminal:

```shell
Calculator
  adds two numbers (FAILED - 1)
  subtracts two numbers
  multiplies numbers (PENDING: Not yet implemented)

Failures:

  1) Calculator adds two numbers
     Failure/Error: expect(Calculator.new.add(2, 2)).to eq(5)

       expected: 5
            got: 4

       (compared using ==)
     # ./spec/calculator_spec.rb:4:in `block (2 levels) in <top (required)>'

Finished in 0.01 seconds (files took 0.1 seconds to load)
3 examples, 1 failure, 1 pending
```

**Legend:**

- **Red** = Failure (a test failed)
- **Yellow** = Pending/Skipped (a test is not implemented or was skipped)
- **Green** = Passing (all tests passed)

*Note: Your terminal will show these colors automatically!*

---

## Anatomy of a Failure (Step by Step)

Let’s look at a simple failing spec and break down what RSpec is trying to tell us, one piece at a time.

```ruby
# /spec/calculator_spec.rb
RSpec.describe Calculator do
  it "adds two numbers" do
    expect(Calculator.new.add(2, 2)).to eq(5)
  end
end
```

If you run this test, you’ll see something like:

```shell
Failures:

  1) Calculator adds two numbers
     Failure/Error: expect(Calculator.new.add(2, 2)).to eq(5)

       expected: 5
            got: 4

       (compared using ==)
     # ./spec/calculator_spec.rb:4:in `block (2 levels) in <top (required)>'
```

Let’s break it down, line by line:

- **Failures:** This section lists all the tests that didn’t pass. If you see this, don’t panic! It’s normal.
- **1) Calculator adds two numbers:** This is the description of the test that failed. It helps you find which example needs attention.
- **Failure/Error:** Shows the exact line of code that failed. This is your starting point for investigation.
- **expected: 5 got: 4:** What you wanted vs. what you got. (Oops! Time to check your logic.)
- **(compared using ==):** The matcher used for comparison. In this case, `eq` uses `==`.
- **File and line number:** Where to look in your code. Open this file, go to this line, and start sleuthing!

Think of the red output as a big, friendly stop sign. It’s not yelling at you—it’s just saying, “Pause! Let’s fix this together.”

---

## RSpec Matcher Variety: Different Matchers, Different Messages

Not all failure messages look exactly the same! RSpec matchers like `eq`, `be`, `include`, and others may produce slightly different output. For example:

```ruby
expect([1,2,3]).to include(4)
```

Might produce:

```shell
Failure/Error: expect([1,2,3]).to include(4)
  expected [1, 2, 3] to include 4
```

Reading the matcher-specific message helps you understand exactly what went wrong.

---

## Common Failure Types (With More Examples!)

Let’s look at the most common types of failures you’ll see in RSpec, with extra examples and what to do next.

### 1. Failing Expectations (Red)

This is the most common. Your code didn’t do what you expected. It’s like ordering a pizza and getting a salad—something’s off!

```ruby
# /spec/string_manipulator_spec.rb
expect(StringManipulator.new.reverse("abc")).to eq("cba")
```

If you get a failure, check:

- Did you call the right method? (Maybe you typed `revers` instead of `reverse`.)
- Are your arguments correct? (Did you pass the right string?)
- Is your expectation accurate? (Are you expecting the right result?)

Try changing the expectation to something you know will fail, just to see what the output looks like. The more you experiment, the more comfortable you’ll get!

#### Another Example

```ruby
# /spec/calculator_spec.rb
expect(Calculator.new.subtract(5, 3)).to eq(1) # Oops, should be 2!
```

### 2. Syntax Errors (Red, but Different)

RSpec will also show you if your Ruby code is invalid. This is like trying to bake a cake with the oven door open—something fundamental is wrong.

```ruby
# /spec/calculator_spec.rb
it "adds numbers" do
  expect(Calculator.new.add(2, 2).to eq(4) # Missing closing parenthesis!
end
```

RSpec output:

```shell
SyntaxError:
  unexpected end-of-input, expecting ')'
```

Check your parentheses, commas, and do/end blocks! If you see a SyntaxError, read the message carefully—it usually tells you exactly what’s missing.

#### One More Example

```ruby
# /spec/calculator_spec.rb
it "adds numbers" do
  expect(Calculator.new.add(2, 2)).to eq(4)
# Oops! Forgot the 'end' for the 'it' block
```

RSpec will complain about an unexpected end-of-input. Always count your `do`/`end` pairs!

### 3. Pending or Skipped Examples (Yellow)

Sometimes you’ll see yellow output. That means you have a pending or skipped test. It’s like putting a sticky note on your code: “Come back to this later!”

```ruby
# /spec/calculator_spec.rb
it "multiplies numbers" # No block given, so this is pending
```

Or you can skip a test on purpose:

```ruby
# /spec/calculator_spec.rb
xit "divides numbers" do
  expect(Calculator.new.divide(6, 2)).to eq(3)
end
```

Pending tests are a great way to remind yourself (or your teammates) what still needs to be done.

---

## Debugging Hierarchy: A Step-by-Step Flow

Here's a simple flowchart for debugging a failing spec:

```mermaid
flowchart TD
  A[See a failure?] --> B{Read the error message}
  B --> C[Check the file and line number]
  C --> D[Check your variables/values]
  D --> E[Add puts/p or comment out code]
  E --> F[Rerun the test]
  F --> G{Still failing?}
  G -- Yes --> H[Ask for help or take a break]
  G -- No --> I[Celebrate!]
```

---

## Debugging Tips (How to Be a Bug Detective)

Debugging is a skill you build with practice. Here are some tips to help you become a bug detective:

- **Read the error message slowly.** It’s trying to help you! Don’t just skim—read every word.
- **Check the file and line number.** Go straight to the source. Open the file, find the line, and see what’s happening.
- **Print out values with `puts` or `p`.** Sometimes seeing what your variables actually contain is all you need to spot the problem.
- **Comment out code.** If you’re not sure where the problem is, try commenting out parts of your code to narrow it down.
- **Rubber duck debugging.** Explain your code (and the error) out loud, even if it’s just to a rubber duck on your desk. You’ll be amazed how often you spot the issue just by talking it through.
- **Don’t panic!** Everyone gets failures. They’re your friends. Each failure is a clue, not a catastrophe.
- **Google the error message.** Chances are, someone else has seen it before. Stack Overflow is your friend.

---

## Common Beginner Pitfalls

Here are some mistakes almost everyone makes at first:

- Testing the wrong object (e.g., calling a method on the wrong variable)
- Misspelling method names (Ruby won’t warn you—your test just fails!)
- Forgetting to save your file before running the test
- Expecting the wrong value (double-check your math and logic)
- Not reading the full error message (the answer is often right there)

If you hit one of these, don’t worry—you’re learning! Every mistake is a step forward.

Getting stuck is part of the process! Here’s what to do:

1. Take a deep breath. Seriously. It helps.
2. Read the error message again, slowly.
3. Check the file and line number.
4. Try printing out values or adding temporary code to see what’s happening.
5. If you’re still stuck, ask a classmate, instructor, or even your favorite search engine.
6. Take a break and come back with fresh eyes. Sometimes the answer jumps out after a short walk!

## Practice Prompts

1. Write a spec that fails on purpose. What does the output tell you? Try changing the expectation to something you know will fail.
2. Introduce a syntax error in a spec (like a missing `end` or parenthesis). What does RSpec show? How do you fix it?
3. Try skipping a test by leaving off the block or using `xit`. What color does RSpec use? How does it show up in the output?
4. How can you use failure messages to improve your code? Write down a real example from your own code.
5. Pair up with a classmate and debug each other’s failing specs. What did you learn from the process?
6. Try explaining a failure message to someone else (or your rubber duck). Did you spot something new?

---

## Resources

- [RSpec Output and Failure Messages](https://relishapp.com/rspec/rspec-core/v/3-10/docs/formatters/documentation-formatter)
- [Debugging Ruby with Pry](https://github.com/pry/pry)
- [Ruby Error Messages Explained](https://www.rubyguides.com/2018/07/ruby-error-messages/)
- [Better Specs: Failures](https://www.betterspecs.org/#fail)

---

## What's Next?

Lab 2 is next! In Lab 2, you'll practice the Red/Green/Refactor cycle by TDD-ing a small Ruby class, like a Playlist, BankAccount, or TodoList. This lab reinforces the TDD principles from this lesson through step-by-step coding exercises, giving you hands-on experience with the workflow of writing, running, and fixing tests.

*Next: You’ll learn how to DRY up your specs with before/after hooks and instance variables!*
