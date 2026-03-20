# Math & Philosophy Blog

A Dockerized [Quarto](https://quarto.org/) blog for mathematical and philosophical reflections.

## Prerequisites

- Docker

> **Note:** The Dockerfile builds an **ARM64** image (Apple Silicon). On x86\_64, swap the `.deb` URL in the Dockerfile to the `amd64` variant.

## Local Development

Build the image:

```bash
docker build -t quarto-blog .
```

Run the live-preview server:

```bash
docker run --rm -p 4200:4200 -v "$(pwd):/project" quarto-blog
```

Open [http://localhost:4200](http://localhost:4200). The preview auto-reloads on file changes thanks to the bind mount.

## Posts

Individual posts live in `posts/`, each in its own subfolder containing an `index.qmd` file. Editing any `.qmd` file does **not** require rebuilding the Docker image — the bind mount ensures changes are picked up immediately and the preview server auto-reloads the browser. You only need to rebuild the image if the Dockerfile itself changes (e.g., upgrading Quarto or adding system packages).

## Drafts

To mark a post as a draft, add `draft: true` to its YAML front matter:

```yaml
---
title: "Work in Progress"
draft: true
---
```

During local preview, drafts are **always visible** so you can work on them normally. On the published site, drafts are excluded by default. This can be changed in `_quarto.yml` via `draft-mode`: `gone` (default — empty page, not linked), `unlinked` (rendered but hidden from listings/nav/search), or `visible` (fully public).

## Render Static Site

To produce the final `_site/` output without starting a server:

```bash
docker run --rm -v "$(pwd):/project" quarto-blog render
```

## Deployment

Pushes to `main` trigger a GitHub Actions workflow that renders the site and deploys it to GitHub Pages.
