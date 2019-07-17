# Dangerous Dave for TIC-80

> [Dangerous Dave](https://en.wikipedia.org/wiki/Dangerous_Dave) remake in [TIC-80](https://tic.computer).

Dangerous Dave was originally written by [John Romero](https://en.wikipedia.org/wiki/John_Romero) back in 1988, and released on DOS in 1990. This is the first 9 levels of Dangerous Dave, with a re-designed final level. The remake was built with [TIC-80](https://tic.computer), as a thank you to John Romero.

[![Title Screen](src/Resources/TitleScreen.gif)](https://tic.computer/play?cart=880)

[Play Online](https://tic.computer/play?cart=880)


## Features

- 9 Levels from the Original
- New Redesigned Final Level
- Save and Continue
- Highscores
- Refined Physics

## Wishlist

- Warpzones
- Mimic Enemy Movement Patterns
- Additional Sound Effects
- Music
- AI Demo (screensaver)
- Color Palette
- Multiplayer

## Development

To compile the game, you'll need [Node.js](https://nodejs.org)...

```
npm it
```

The above will build *cart.wren*, which can then run through `tic80`.

```
tic80 cart.tic -code node_modules/cart.wren -sprites src/Resources/sprites.gif
```

## License

[GPL-3.0](LICENSE)
