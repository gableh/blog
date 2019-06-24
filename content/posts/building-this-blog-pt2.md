+++
title = "Building this Blog - Part 2"
description = "Static site generators and Continuous Delivery"
date = 2019-06-24T10:34:05+08:00
weight = 20
draft = false
+++

### Considerations
Ideally, I would've liked an out of the box static site generator that
would take the git repo that the blog was hosted in as the single source
of truth and just refreshed whenever I posted something new. Since i'm
not sure if something like this can even be called a static site anymore, 
I decided to settle on Hugo instead. Why hugo? Cause of this nice looking
theme obviously. 

Interestingly, it turns out that this theme is actually behind the latest by
a major version. Never thought that even UI can have breaking changes haha. 
Kinda makes sense though now that I think about it.

### Setting up Hugo
Since I'm currently running a cluster, everything I deploy has to be in the
form of an image. So the first task is to write a Dockerfile to build a hugo
image. In the end, I decided to put in the blog repo itself because I was
planning to eventually have the image be redeployed on every commit ala 
continuous delivery. I _could_ have used a shell script or set up another server
to watch for changes but it would've made things a lot less interesting.

### Setting up continous delivery through Kubernetes
Traditonally, continuous delivery is done through pipelines, usually after running a
bunch of tests. This still hasn't changed but I was looking for a more native solution.
Something that will hopefully have less overhead than Bamboo.

Interesting, Jenkins now has this cloud native option called Jenkins X. Its stated
requirements are _at least_ 4 vCPUS not including the master node though, so thats
out of the question. So whats a guy with only 3 vCPUS to do?

Introducing argoCD, a CD tool built from the ground up for kubernetes. I think it almost perfectly
fits this use case because I was just looking for a way to deploy and static sites have no need for CI anyway.

![ArgoCD](/images/argocd2.png)

Its pretty neat actually, it shows everything that was created as part of the deployment and shows when a sync is
necessary due to changes are made to the master branch. One caveat however, is that it only compares between YAML 
files since it is primarily meant to be used as a tool to deploy to Kubernetes.
Ideally, I would've liked the option to redeploy as long as changes are made to the repo.
The workaround here is simply to use helm to generate a random number within the YAML files to
ensure that there is always a difference when argoCD attempts to compare changes. The issue that
arises from this is that the version will always be out of sync every time argoCD polls for changes.
This however, occurs a lot less frequently than I expected since I think there is some caching going on
and argoCD will only go out of sync on a hard refresh or when the cache expires. Perfect.