# curl_example

This repository has a few files to illustrate the concept of a package blacklist in Anchore and also to explore techniques for building more robust policies that go beyond simple blacklists.  A blog post is forthcoming that will reference this repo.

Contents of this repository:

- Dockerfile - same as xx_Dockerfile_simple
- Jenkinsfile - originally the blog post was going to use a Jenkins pipline in the examples but it's simpler without it, but I'm leaving the Jenkinsfile in case anyone wants to experiment with it.
- simple_policy.json - a policy that blacklists the curl package
- multistage_policy.json - a more complex policy that looks at Dockerfile instructions in addition to the package blacklist
- xx_Dockerfile_multistage - a multistage build where curl is installed in the build stage but isn't present in the final image
= xx_Dockerfile_simple - a simple alpine-based image that has curl installed with some other build tools
