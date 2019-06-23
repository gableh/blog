+++
title = "Building this Blog - Part 1"
description = "Setting up a single node cluster"
date = 2019-06-23T21:28:05+08:00
weight = 20
draft = true
+++

### Introduction
As I've recently started learning about Kubernetes and Terraform, I thought it would
be cool to do a personal project with it. Kubernetes lends itself really well to building
and maintaining containers at scale so naturally I thought that doing a small blog where I
write about stuff would fit. :)

### Selecting a VPS
Kubernetes on major cloud providers is really expensive, the minimum requirements needed to run
kubeadm without it complaining is 2 vCPUS. This sets the minimum cost at ~15 USD/mth and thats
just for the master node! Eventually I started looking at less well known VPS providers
and settled on Scaleway, which offers a package of 3 vCPUS and 4 GB of RAM for ~9 USD/mth. Its
pretty reasonable for shared hosting and I havent run into any major issues with it so far.

### Building a single node cluster
Following a tutorial on building a kubernetes cluster on a budget 
[here](https://itsilesia.com/kubernetes-for-poor-how-to-run-your-cluster-and-not-go-bankrupt/),
which uses a single node as both the control and data plane. This is obviously not recommended for serious,
revenue generating environments but works quite well for people who are on a budget.

While the guide recommends running kubeadm init with the `--apiserver-advertise-address=$PUBLIC_IP` flag,
I found that running kubeadm with the following command
```bash
kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-cert-extra-sans=$PUBLIC_IP
```
worked much better instead. Interestingly, it seems that kubeadm will work without either `apiserver`
flag but without `--apiserver-cert-extra-sans`, there will be errors related to HTTPS.

The tutorial linked is pretty good and I suggest taking a look at it since it offers explanations
on how kubernetes works under the hood as well.

### Setting up HTTPS

To enable HTTPS, I used [cert-manager](https://github.com/jetstack/cert-manager) to provision and renew TLS
certificates. Setting up HTTPS through the http01 challenge included just updating the yaml files that were 
provided with my email address and dns. Attempting to set up wildcard certification for *.gable.dev through
a dns01 challenge though seemed a lot more complicated especially since Namecheap isn't a supported DNS01
challenge provider, probably due to its pay-walled API or something. I might consider moving to a supported
provider in the future like Cloudflare but probably only when I have so many subdomains that issuing individual
requests is too unwieldy.
