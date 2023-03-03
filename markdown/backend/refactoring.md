## Refactoring: Improving the Design of Existing Code

[:arrow_backward:](backend_index)

Refactoring is the process of changing a software system in a way that does not alter the external behavior of the code yet improves its internal structure.

Brevity is the soul of wit, but clarity is the soul of evolvable software.

**Refactoring (noun)**: a change made to the internal structure of software to make it easier to understand and cheaper to modify without changing its observable behavior.

**Refactoring (verb)**: to restructure software by applying a series of refactorings without changing its observable behavior.

> The point of refactoring isn't to show how sparkly a code base is - it is purely economic. We refactor beacuse it makes us facter - faster to add features, faster to fix bugs.



#### Best practices

When doing refactorings in small steps with reruning automated tests after each change you don't need to debug.

If there is a need to do a long-term refactoring you may plan it in a way to gradually work on the problem in the next few weeks - make a lot of little improvements.

Refactoring in the process of code review is a good practice. You may be sitting one-on-one with the original author, going through the code and refactoring as we go. It's called *pair programming.*

Instead of speculating on what flexibility I will need in a future and what mechanimcs will best enable that, I build software that solves only the currently understood need, and I make this software excellently designed for those needs (*yagni - "you aren't going to need it"*). With refactoring we adapt the architecture to those new demands. If it's harder to refactor - maybe need to add a flexibility mechanim. 

Build program in a well-factored manner without paying attention to performance. Then use profilers that monitors the programm and tells where it is consuming time and space - we may see hot spots, small parts of the program that needs to be optimized. Make changes and run performance test again - revert if no significant result.



#### Cases

If we try to extract function (106) and we end up with passing so many parameters, then may use:

- replace temp with query (178)
- introduce parameter object (140)
- preserve whole object (319)
- heavy artillery - replace function with command (337)

Even a single line is worth extracting if it need explanation.



#### TDD

The Test-Driven Development relies on short cycles of writing a (failing) test, writing the code to make that test work, and refactoring to ensure the result is as clean as possible.