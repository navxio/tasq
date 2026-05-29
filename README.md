# tasq

A tiny FIFO task queue for the terminal.

tasq is intentionally simple: tasks are stored as plain text, the first task is always the current task, and completing a task removes it from the front of the queue.

No databases. No priorities. No due dates. No synchronization. Just a queue.

## Why?

Many task managers encourage maintaining large lists of tasks. tasq takes the opposite approach.

The task at the front of the queue is the task you should be focusing on right now.

text Fix CI pipeline Write release notes Publish v0.7

When you're done:

bash tasq d

The next task automatically becomes your current focus.

## Features

- Single-file task storage
- FIFO (First In, First Out) workflow
- Plain text format
- Zero dependencies
- Fast startup
- Unix-friendly

## Installation

Clone the repository:

bash git clone <https://github.com/yourusername/tasq.git> cd tasq

Make the script executable:

bash chmod +x tasq

Optionally place it somewhere on your PATH:

bash sudo cp tasq /usr/local/bin/

Verify installation:

bash tasq

## Usage

### Show the current task

bash tasq

or

bash tasq current

Example:

text Implement OAuth flow

### Add a task

bash tasq add "Implement OAuth flow"

Short form:

bash tasq a "Implement OAuth flow"

Output:

text added: Implement OAuth flow

### Complete the current task

bash tasq done

Short form:

bash tasq d

Output:

text done: Implement OAuth flow

### List all tasks

bash tasq list

Short form:

bash tasq l

Example:

text 1. Implement OAuth flow 2. Write documentation 3. Publish release

### Clear the queue

bash tasq clear

### Show help

bash tasq help

## Storage

Tasks are stored in:

text $XDG_DATA_HOME/qo/tasks.txt

or, if XDG_DATA_HOME is not set:

text ~/.local/share/qo/tasks.txt

Because the format is plain text, you can inspect or edit the queue using standard Unix tools:

bash cat ~/.local/share/qo/tasks.txt vim ~/.local/share/qo/tasks.txt sed -n '1,5p' ~/.local/share/qo/tasks.txt

## Philosophy

tasq follows a few simple ideas:

- The current task should be obvious.
- Focus is more valuable than organization.
- Plain text is a feature.
- Good tools disappear into the background.
- The best productivity system is the one you actually use.

## Example Workflow

Start the day:

bash tasq a "Review pull requests" tasq a "Implement OAuth flow" tasq a "Write release notes"

Check what to work on:

bash tasq

text Review pull requests

Finish it:

bash tasq d

Now:

bash tasq

text Implement OAuth flow

Repeat until the queue is empty.

## License

MIT
