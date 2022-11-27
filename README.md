# Scale

![repeating red dragon scale pixel art](https://user-images.githubusercontent.com/928367/204090457-0d096cbe-21cc-4753-9c63-f7786d165cfa.png)

**DragonRuby Game Toolkit Game Starter Template**

_Scale is currently a work in progress!_

Quickly start a new DragonRuby Game Toolkit game with helpful extensions.

## Bugs / Features

- Displays framerate in the upper-right hand corner of the game when running in development mode
- `#debug?` helper to easily check if the game is running in development mode; useful for custom commands
- Reload all sprites in development using the `i` key, requires use of `SPATHS` constant
- Reset the game with `r` key, calls `$gtk.reset`
- Put all debug-only code in `#debug_tick`
- `#init` method that gets run once on game boot

## Use It

There are two main ways you can use the Scale template for your games.

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

## Template License

The template source code falls under the [Unlicense](https://unlicense.org/), meaning it is dedicated to the public domain and you are free to do with it what you want.

## Contribute

Conributions are welcome!

Open an issue or submit PRs if you notice something isn't working.

If you find yourself adding the same files, methods, constants, etc. to your DRGTK games, submit a PR to add it to Scale.

---

[Clear this README out and add your own details!]
