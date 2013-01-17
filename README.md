expressioncalculator
====================

An iOS expression calculator built upon DDMathParser.

Unlike a conventional calculator, this version works by parsing through "pretty print" expression strings similar 
to those found in high end graphing calculators. This allows the user to see and enter relatively complex expressions.

instructions
============
Most symbols and buttons are self-explanatory (for English speakers, at least). The normal button pane contains mostly
standard operators. The secondary pane (accessed by swiping horizontally across the bottom of the button pane)
contains functions to calculate min, max, avg, and trigonometric relationships and the like.

You can use parenthesis to increase the precedence of lower order operations, or to execute functions. The parser
does understand expressions like 3(4), i.e. 3 x 4. Further examples:

3(4) == 3 x 4.
Functions accepting multiple parameters (like min, max, avg) work in accordance with the following example:
min(2.4, 7, 5.95) will return 2.4.
% represents the modulo operator.
^ represents exponentiation.
<< is the backspace/delete key.
& and | are bitwise and and bitwise or, respectively (results are currently displayed in base 10).

I expect to add persistent storage of past expressions shortly. I would eventually like to extend the calculator's
functionality to include variables and an algebraic solver (this is more an issue of UI design than parser capability).
