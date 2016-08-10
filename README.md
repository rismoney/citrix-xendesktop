citrix-xendesktop
=================

completely automated xendestop deployment via puppet

status
======
This is a fork of an internal repo demonstrating how I manage an
entire Citrix XenDesktop 7 environment using Puppet

This is meant to be a starting point for an experienced sysadmin
interested in learning how to deploy a complex ecosystem app
like Citrix XD7.

Interesting concepts leveraged
==============================

Default User Profile management

Complete powershell scripts for storefront, DDC, etc

Built around Windows 2012 and optimizations included!

Our multi-os pattern

Fun tidbits, like hiera_include, create_resources, registry provider,
hints at our host impersonation patterns and lots of hard things
made easy!


at this point it is simply not forkliftable to use in your environment
but it will be one day.

Things missing but not for long-
hieradata
chocopackage source

How you might be able to use it-
Start by grep the repository for example.com on things to change
Review...Review...Review all the things!

help it get there?  Submit a PR!

