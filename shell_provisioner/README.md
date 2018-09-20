# ITR VM

A collection of scripts to ease Vagrant box provisioning using the [shell](https://www.vagrantup.com/docs/provisioning/shell.html) method.

It will install the following on a Debian 8 (Jessie) Linux VM:

* PHP 7.1
    * Xdebug
    * Composer
    * PHPUnit
* Apache 2.4
* MySQL 5.6
* phpMyAdmin 4.7.0
* Yarn
* Gulp
* Drush + Drupal Console
* MailHog 1.0.0
* Optional:
    * Blackfire
    * ElasticSearch 5

## Extra software/utilities

By default, this VM includes the extras listed above.
In order to enable/install those, just run ```source set_vars.sh``` and ```source /vagrant/shell_provisioner/module/{module}``` and change ```{module}``` with:

    blackfire
    elasticsearch

And uncomment these in ```run.sh``` to install these by default.

Note: not all the scripts are idempotent. Using ```vagrant provision``` will cause problems

## Development tools

* phpMyAdmin at [phpmyadmin.jiracode.dev.intracto.com](https://phpmyadmin.jiracode.dev.intracto.com)
    * [Website](https://www.phpmyadmin.net/)
* MailHog at [mails.jiracode.dev.intracto.com](https://mails.jiracode.dev.intracto.com)
    * [Website](https://github.com/mailhog/MailHog)

