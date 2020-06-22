# flux-challenge-elm

A solution to [flux-challenge](https://github.com/staltz/flux-challenge) written in Elm.

## First time setup

From the root of the repo:

```
$ yarn && cd backend && yarn
```

## Starting the app

You need to start both the backend and the frontend server.

### The frontend server

Responsible for serving Elm code.

```
$ yarn start
```

### The backend server

Responsible for serving siths & planets server.

```
$ cd backend && yarn start
```

## Running tests

```
$ yarn elm-test
```

### Automatically re-run tests on code changes

```
$ yarn elm-test --watch
```

## Formatting the Elm code

`yarn format` formats the code using [elm-format](https://github.com/avh4/elm-format). You can set
up [an editor integration](https://github.com/avh4/elm-format#editor-integration) so that your
editor is going to run it automatically on save.

## Solution

To view the complete solution to this challenge, start the servers and then go to
[http://localhost:8000/solution/staltz/](http://localhost:8000/solution/staltz/).
