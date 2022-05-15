+++
title = "My blog"
description = "Finally in production!"
date = 2019-06-15T15:39:16+08:00
draft = false
bref = ""
toc = true
+++

![My first attempt](/images/old-blog.png "It took awhile but i'm finally here")

Ahh, its been awhile. When i first started working on a blog to post my thoughts on technical stuff,
 the CMS I was planning to build would have used Flask, pgSQL and nginx probably hosted directly on a VPS, maybe an EC2 instance
somewhere in Oregon where its supposedly cheaper. 

This blog however, was built using Hugo on top of a single node kubernetes cluster (well, if you still consider it 
a cluster). The younger me would probably have scoffed at the fact that I wasn't building a CMS from scratch 
but eh at least its on kubernetes and what does he know anyway. The cluster still uses nginx to handle incoming
connections so at least some things never change haha. 

I briefly considered using hakyll but hugo won out in the end due to its nicer looking themes out of the box. After attempting to work
with GHCJS and Servant to build a website, i'm not even sure if I still want to use haskell for anything
web related anymore though. Well, maybe Servant but probably not GHCJS. The amount of memory it uses due to template haskell
at compile time is a bit too much for my poor docker container to handle haha. 

![Really impressed by the size of the stack builder image though!](/images/stack-builder-image.png "What an absolute unit")
*Always incredibly impressed by the size of the stack builder image though!*

Thats about it for now, in the coming days or weeks (hopefully days), i'll write a bit more about how this blog got set up and the issues
I ran into.
