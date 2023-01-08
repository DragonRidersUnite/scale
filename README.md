# Scale

![repeating red dragon scale pixel art](https://user-images.githubusercontent.com/928367/204090457-0d096cbe-21cc-4753-9c63-f7786d165cfa.png)

**Simple DragonRuby Game Toolkit Game Starter Template**

Status: usable but not yet stable! This is pre-v1 software.

Quickly start a new DragonRuby Game Toolkit game with useful conventions and helpful extensions.

Looking for a simpler version? Check out [the `simple` release](https://github.com/DragonRidersUnite/scale/releases/tag/simple) that's just `app/main.rb` with some constants and helper methods.

## Bugs / Features

Last tested against DragonRuby Game Toolkit v4.0.

- Functional approach to the code, namespaced in modules
- Driven by `args.state`
- Menus and pause screen
- Defined location for where to put scenes
- Settings that persist to disk
- Displays framerate in the upper-right hand corner of the game when running in development mode
- `#debug?` helper to easily check if the game is running in development mode; useful for custom commands
- Reload all sprites in development using the `i` key
- Reset the game with `r` key, calls `$gtk.reset`
- Put all debug-only code in `#debug_tick`
- `#init` method that gets run once on game boot
- `CHEATSHEET.md` with common APIs from DRGTK and Scale
- `#version` to get the version of your game
- Constants for various values and enums: `FPS`, `BLEND_*`, `ALIGN_*`
- Tests for the methods!

## Use It

There are two main ways you can use the Scale template for your games.

[📺 Video demo showing how to get started](https://www.youtube.com/watch?v=eek3a3aO-zo)

### Download the Zip

The fastest way to get started is to download the template zip file and put it into your unzipped DragonRuby Game Toolkit folder.

1. Download and unzip the DragonRuby Game Toolkit engine zip
2. Delete the `mygame` directory
3. [Download Scale](https://github.com/DragonRidersUnite/scale/archive/refs/heads/main.zip)
4. Unzip the `scale-main.zip`
5. Move the `scale-main` folder into the DRGTK folder
6. Rename `scale-main` to `mygame`
7. Start DragonRuby, and make an awesome game!

### Use GitHub's Template System

If you're going to track your game with Git and use GitHub, the baked-in template system will get you going quickly.

1. View the project on GitHub: https://github.com/DragonRidersUnite/scale
2. Click "Use this template"
3. Click "Create a new repository"
4. Fill out the details and create the repository
5. Unzip the DragonRuby Game Toolkit engine zip
6. Delete the `mygame` directory
7. Clone your new repository into the DRGTK engine folder with the folder name `mygame`, example: `git clone git@github.com:USERNAME/REPO.git mygame`
7. Start DragonRuby, and make an awesome game!

### Updating

Because Scale is a template with all of its source as part of your game, updating the framework's source code in your game isn't an easy thing to do.

I generally would say: don't worry about it! Take ownership over the code in your game and change what Scale provides you without concern. When it comes time to start your next game, Scale will be updated and improved.

But if you do find yourself wanting to keep it updated, [watch the GitHub repo](https://github.com/DragonRidersUnite/scale) for releases. You could pull in just the changes you want. Or you could set an upstream in your repo to the template and merge the changes in.

## Documentation

Coming soon!

## Release Approach & Versioning

Code on the `main` branch is intended to be stable because Scale is a template. When significant changes have been made, a tag and release are created. This allows progress to be tracked and previous versions to be easily downloaded.

Scale uses a simplified major.minor versioning scheme. Major version bumps means there are breaking changes to the API (the methods and structure). Minor bumps mean non-breaking additions and fixes.

## Template License

The template source code falls under the [Unlicense](https://unlicense.org/), meaning it is dedicated to the public domain and you are free to do with it what you want.

## Contribute

Conributions are welcome!

Open an issue or submit PRs if you notice something isn't working.

If you find yourself adding the same files, methods, constants, etc. to your DRGTK games, submit a PR to add it to Scale.

---

[Clear this README out and add your own details!]

## Debug Shortcuts

- <kbd>0</kbd> — display debug details (ex: framerate)
- <kbd>i</kbd> — reload sprites from disk
- <kbd>r</kbd> — reset the entire game state
