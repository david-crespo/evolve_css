evolve_css
==========

Given a comp (a mockup) and some HTML that matches the structure of the mockup, I want to evolve CSS that when applied to the HTML, produces an image that matches the comp. I have _no idea_ what I'm doing.

## Ingredients

I'm using [phantomjs](http://phantomjs.org/) to render the HTML/CSS and take a screenshot, and [ImageMagick](http://www.imagemagick.org/) to diff the screenshot and the comp.

But the real meat of the project is the Haskell code that produces new generations of CSS files.

## The hard part: validity-preserving mutation and reproduction

The problem is how to sexually combine stylesheets and introduce random mutations in such a way that the resulting CSS is still valid.

First, consider the following Haskell definitions:

```haskell
type Selector = String
data Rule = Rule String String deriving Show
data Ruleset = Ruleset Selector [Rule] deriving Show
type Stylesheet = [Ruleset]
```

In other words, a `Selector` is a string, like `".box > p"` . A `Rule` is a pair of strings, like `"color"` and `"green"`. A `Ruleset` is a `Selector` and a list of `Rule`, such as:

```css
.box p {
    background-color: green;
    margin-left: 20px;
}
```

Finally, a `Stylesheet` is a list of `Ruleset`. [1]

Using the above definitions, it may be easier than it first appeared to characterize mutations that preserve CSS validity. 

### Mutation

Mutations could be any of the following:

* Add or remove a ruleset (possibly require it to be empty)
* Modify a selector (this might be the hardest one)
  * Add, remove, or modify elements, e.g., transform `div` to `div li`
* Add or remove a rule
* Modify a rule, which entails changing either the value or the property (making sure to maintain compatibility between the property and the value)

### Reproduction

Based on the considerations for mutation, some ideas for possible components of reproduction follow naturally. Given parents X and Y:

* Taking some combination of the rulesets from X and Y (keeping it simple is probably best to start with)
* Taking a random rule from X and putting it in a random ruleset from Y
* If X and Y have rules with the same property, take the value from Y and put in the ruleset where X had it
* etc.

## Fitness

The fitness of a given individual stylesheet will be based on

* Similarity to the comp, and 
* Some combination of measures of simplicity of the CSS, such as minimizing the
  * Number of selectors
  * Number of rules
  * Length of string representation


[1] For these definitions I am indebted to Jakub Arnold's excellent blog post, [Parsing CSS with Parsec](http://blog.jakubarnold.cz/2014/08/10/parsing-css-with-parsec.html).
