# Meal Tracker

A command-line tool for doing meal tracking.

Research shows that meal tracking is the absolute best thing you can do to lose weight. [A 2008 study][meal-tracking-study] showed that the simple act of recording what you eat helps keep one mindful of your eating habits, making changing them easier:

> Keeping a food diary doesn't have to be a formal thing. Just the act of scribbling down what you eat on a Post-It note, sending yourself e-mails tallying each meal, or sending yourself a text message will suffice. It's the process of reflecting on what you eat that helps us become aware of our habits, and hopefully change our behavior ...
>
> *-- Keith Bachman, MD*

> The more food records people kept, the more weight they lost ...
>
> *-- Jack Hollis, PhD, lead author of the study*

## Installation

If you already have [Elixir][elixir-lang] installed, the current released version can be installed locally without cloning the repository using:

<!--
The version number in this block should be automatically updated by script/bump.
-->
```shell
mix escript.install github lee-dohm/meal-tracker v0.1.2
```

If you want the latest development version, leave off the version tag.

[elixir-lang]: https://elixir-lang.org

## Use

### Adding an item to your daily log

Once the tool is built and placed somewhere on your `PATH`, execute the following to add a single item to your log:

```
track add [food]
```

Where `food` follows one of the following patterns:

* `Ceasar Salad`
* `3x Apple`
* `355 milliliter Pepsi`

The new food item will be added to your log at `~/meal-tracker/[date].md`. Your log will look something like this:

```markdown
# 2019-07-21

* 10 ounce Rib Eye Steak
```

### Printing today's information

Print today's log with:

```
track status
```

### Other commands

You can get the list of common commands with:

```
track help
```

## Configuration

Configuration of the Meal Tracker app is stored in `~/.meal-tracker`. The following values are supported:

* `root` The directory where the Meal Tracker data will be stored, _default:_ `~/meal-tracker`

## Common Tasks

This project follows the [GitHub "scripts to rule them all" pattern][scripts-to-rule-them-all]. The contents of the `scripts` directory are scripts that cover all common tasks:

* `script/bootstrap` &mdash; Performs first-time project setup (beyond installing the Elixir environment)
* `script/build` &mdash; Builds the project
* `script/test` &mdash; Runs automated tests
* `script/clean` &mdash; Deletes all generated files
* `script/console` &mdash; Start the REPL for the project with appropriate libraries already loaded
* `script/doc` &mdash; Generate and open the developer documentation for the project
* `script/install` &mdash; Installs the executable on the system `PATH`

## Acknowledgements

This tool is heavily influenced by [todo.txt][todo-txt] by [Gina Trapani][gina-trapani]. Many thanks for reaffirming the power of plain text with such a great tool and awesome ideas!

## License

[MIT](LICENSE.md)

[gina-trapani]: http://ginatrapani.org/
[meal-tracking-study]: http://www.sciencedaily.com/releases/2008/07/080708080738.htm
[scripts-to-rule-them-all]: https://github.com/github/scripts-to-rule-them-all
[todo-txt]: http://todotxt.com/
