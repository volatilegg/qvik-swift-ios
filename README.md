# Qvik's Swift utility collection

*This library contains Swift utilities for use in both Qvik's internal and customer projects.*

## Contributing 

Any Swift developer in the company may - and is encouraged to - contribute to this library. Any contributions have to meet the following criteria:

* Meaningfulness. Discuss whether what you are about to contribute indeed belongs to this library in the first place before submitting a pull request.
* Code style. Follow our [Swift style guide](https://github.com/qvik/swift) 100%.
* Stability. No code in the library must ever crash; never place *assert()*s or implicit optional unwrapping in library methods.
* Testing. Every method and function in the library must have unit tests, triggering both successful and unsuccessful calls.
* Logging. No code in the library must write logs. Unit tests should log with *println()*.

All merges to the **master** branch go through a *Pull Request* and MUST meet the above criteria.

