# Self-Hosted Digital Garden
This project aims to self-host your Obsidian Digital Garden. This idea is based on the [Obsidian Digital Garden plug-in](https://dg-docs.ole.dev/), that allows you to publish your Obsidian pages into a website.
The plug-in uses GitHub and Vercel to host your pages. However, this project takes away the Vercel aspect, for those who prefer to self-host your pages. The plugin still requires the use of GitHub, but you can use a private repository.

## Why Self-Host?
You may not want to rely on a third-party service that may change pricing at any time, or you may not want your pages to be public, but instead host them in a private setting, like a company, school, or home-lab. This is where self-hosting (and this project) can help out!

## How it works
This project makes use of the [Digital Garden code](https://github.com/oleeskild/digitalgarden), but hosts it privately with Docker. A wrapper script monitors the GitHub repository for changes, pulls them, and rebuilds the container.
The script also tears down your container when you exit the script.

## Getting started
### Setting up your git repo
1) Copy the [Digital Garden repo](https://github.com/oleeskild/digitalgarden) to your own GitHub repo. For example by migrating to your personal git, or copying all files to a new repo
2) Create an access token you wish to use for this repository

### Setting up your vault
1) Install the Digital Garden plug-in
2) Open the settings and configure these
3) Select your home page, and add `dg-home: true` and `dg-publish: true` to the FrontMatter

### Deploy your garden
1) Clone your project to './site': `git clone <project> site`
2) Configure your `.env` file as desired
3) Manage the container with `garden`. `./garden up` will start your container.

**Note:** You can name your garden directory as something else as well, but then you have to change this setting in the `.env` file. 
**NOTE:** Run `./garden help` for more commands. `./garden down` will stop your container.
