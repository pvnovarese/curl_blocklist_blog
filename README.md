# curl_example

This repository has a few files to illustrate the concept of a package blacklist in Anchore and also to explore techniques for building more robust policies that go beyond simple blacklists.  A blog post is forthcoming that will reference this repo.

Contents of this repository:

Dockerfile - same as xx_Dockerfile_simple
Jenkinsfile - 
simple_policy.json - a policy that blacklists the curl package
xx_Dockerfile_multistage - a multistage build where curl is installed in the build stage but isn't present in the final image
xx_Dockerfile_simple - a simple alpine-based image that has curl installed with some other build tools
