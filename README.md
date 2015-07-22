# Qvik's Swift utility collection

*This library contains Swift utilities for use in both Qvik's internal and customer projects.*

## Usage

To use the library in your projects, add the following to your Podfile:
```ruby
use_frameworks!
source 'https://git.qvik.fi/qvik/QvikPodSpecs.git'

pod 'QvikSwift', '~> 1.0.0'
```

And the following to your source:

```ruby
import QvikSwift
```

## Contributing 

Any Swift developer in the company may - and is encouraged to - contribute to this library. Any contributions have to meet the following criteria:

* Meaningfulness. Discuss whether what you are about to contribute indeed belongs to this library in the first place before submitting a pull request.
* Code style. Follow our [Swift style guide](https://github.com/qvik/swift) 100%.
* Stability. No code in the library must ever crash; never place *assert()*s or implicit optional unwrapping in library methods.
* Testing. Every method and function in the library must have unit tests, triggering both successful and unsuccessful calls.
* Logging. No code in the library must write logs. Unit tests should log with *println()*.

### Submit your code

All merges to the **master** branch go through a *Pull Request* and MUST meet the above criteria.

In other words, follow the following procedure to submit your code into the library:

* Clone the library repository
* Create a feature branch for your code
* Code it, clean it up, test it thoroughly
* Push your branch
* Create a pull request

## Updating the pod

As a contributor you do not need to do this; we'll update the pod whenever needed by projects.

* Update QvikSwift.podspec and set s.version to match the upcoming tag
* Commit all your changes, merge all pending accepted *Pull Requests*
* Create a new tag following [Semantic Versioning](http://semver.org/); eg. `git tag -a 1.2.0 -m "Your tag comment"`
* `git push --tags`
* `pod repo push QvikPodSpecs QvikSwift.podspec`

## Contact

Any questions? Contact Matti.