Roster Runner
-------------
[rosterrunner.com](http://rosterrunner.com)

Are you a sports photographer? Roster Runner is here to help with your captions.
Using your favorite text expansion utility like
[Photo Mechanic](http://www.camerabits.com/site),
[Text Expander](http://www.smilesoftware.com/TextExpander/),
or [AutoHotKeys](http://www.autohotkey.com/),
Roster Runner allows you easily generate correct captions using short text
snippets.

Instead of writing this:

    Seattle Seahawks quarterback Charlie Whitehurst (6)

You can write this:

    s6

Snippets are automatically expanded with the correct player's team, position,
name, and number.

Snippets include:

  - `s6` Seattle Seahawks quarterback Charlie Whitehurst (6)
  - `s6f` Charlie
  - `s6l` Whitehurst
  - `s6p` quarterback Charlie Whitehurst
  - `s6t` Seattle Seahawks's Charlie Whitehurst
  - `s6n` Charlie Whitehurst (6)
  - `s6tp` Seattle Seahawks quarterback Charlie Whitehurst
  - `s6tn` Seattle Seahawks Charlie Whitehurst (6)
  - `s6pn` quarterback Charlie Whitehurst (6)
  - `s6tpn` Seattle Seahawks quarterback Charlie Whitehurst (6)
  - `s6s` [Whitehurst,Charlie],

What happens if a roster has two players with the same jersey number? Roster
Runner will handle that as well. Multiple entires are separated by `##` and
the duplicate entry may be removed after the expansion completes. For example,
the Seattle Seahawks has two players with the jersey number `69`:

    s69t

This snippet is expanded to:

    ##Seattle Seahawks's Jay Alford####Seattle Seahawks's Caz Piurowski##

Depending on the day's roster, we can remove the player that is not on the field.
We are left with:

    Seattle Seahawks's Jay Alford
