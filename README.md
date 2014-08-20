evolve_css
==========

Given a comp (a mockup) and some HTML that matches the structure of the mockup, I want to evolve CSS that when applied to the HTML, produces an image that matches the comp. I have _no idea_ what I'm doing.

## Ingredients

I'm using [phantomjs](http://phantomjs.org/) to render the HTML/CSS and take a screenshot, and [ImageMagick] to diff the screenshot and the comp.

But the real meat of the project is the Haskell code that produces new generations of CSS files.

## The hard part: mutation and reproduction

The problem is how to sexually combine stylesheets and introduce random mutations in such a way that the resulting CSS is still valid.

First, consider the following Haskell definitions:

```haskell
type Selector = String
data Rule = Rule String String deriving Show
data Ruleset = Ruleset Selector [Rule] deriving Show
type Stylesheet = [Ruleset]
```

In other words, a `Selector` is a string, like `".box > p"` . A `Rule` is a pair of strings, like `"color"` and `"green"`. A `ruleset` is a `Selector` and a list of `Rule`s.


Using the above definitions, it may be easier than it first appeared to characterize mutations that preserve CSS validity. 

### Mutations



## Fitness

The fitness of a given individual stylesheet will be based on

* Similarity to the comp, and 
* Some combination of measures of simplicity of the CSS, such as minimizing the
  * Number of selectors
  * Number of rules
  * Length of string representation
