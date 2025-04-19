# Self-Hosted Digital Garden
This project aims to self-host your Obsidian Digital Garden. This idea is based on the [Obsidian Digital Garden plug-in](https://dg-docs.ole.dev/), that allows you to publish your Obsidian pages into a website.
The plug-in uses GitHub and Vercel to host your pages. However, this project takes away the Vercel aspect, for those who prefer to self-host your pages. The plugin still requires the use of GitHub, but you can use a private repository.

## Getting started
### Setting up your git repo
1) Copy the [Digital Garden repo](https://github.com/oleeskild/digitalgarden) to your own GitHub repo. For example by migrating to your personal git, or copying all files to a new repo
2) Create an access token you wish to use for this repository

### Setting up your vault
1) Install the Digital Garden plug-in
2) Open the settings and configure these
3) Select your home page, and add `dg-home: true` and `dg-publish: true` to the FrontMatter.

### Deploy your garden
1) clone your project to './site': `git clone <project> site`
2) run `./run.sh`
