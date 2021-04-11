# Readme `Postman` and `Newman`

There is a command-line collection runner for `Postman` called `Newman`. It is an open-source `Node.js` application and it is available as an `npm` package.

This Docker image **does not** come with any pre-installed `Newman` version by intention. That allows keeping the image slimmer. However, you can install `Newman` easily if you need it.

## Installing `Newman`

First you have to install `Node.js` and `npm`:

```shell
sudo apt-get update
sudo apt-get -y install nodejs npm
```

Then you can install the Newman package globally:

```shell
sudo npm -g install newman
```

You can check the versions by

```shell
node -v
npm -v
npx -v
newman -v
```

## What next

You can start by visiting the [Postman Learning Center](https://learning.postman.com/docs/getting-started/introduction/) and reading the article about [using Newman](https://learning.postman.com/docs/running-collections/using-newman-cli/command-line-integration-with-newman/). You can also check the [Newman project on GitHub](https://github.com/postmanlabs/newman).
