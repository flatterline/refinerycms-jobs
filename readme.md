# Refinery CMS Jobs

[![Build Status](https://travis-ci.org/bisscomm/refinerycms-jobs.svg?branch=master)](https://travis-ci.org/refinery/refinerycms) [![Code Climate](https://codeclimate.com/github/bisscomm/refinerycms-jobs/badges/gpa.svg)](https://codeclimate.com/github/bisscomm/refinerycms-jobs) [![Test Coverage](https://codeclimate.com/github/bisscomm/refinerycms-jobs/badges/coverage.svg)](https://codeclimate.com/github/bisscomm/refinerycms-jobs/coverage)

Jobs engine for [Refinery CMS](http://refinerycms.com) allows you to post vacancies to the jobs section of your website.

### In summary you can:
* Manage jobs
* Collect job applications
* Customise an auto responder email that is sent to the person making the job application
* Specify who is notified when a new job application comes in

When job applications come in, you and the candidate are generally notified. As we implemented spam filtering through the `filters_spam` plugin you will not get notified if an inquiry is marked as 'spam' (can be disable by config in jobs initializer).

## Requirements

This version of `refinerycms-jobs` supports Refinery 3.x and Rails 4.1.x.
To use Rails 3.x / Refinery 2.0.x use the [refinerycms-jobs "Refinery CMS 2-0 stable branch"](http://github.com/bisscomm/refinerycms-jobs/tree/2-0-stable).

* [Refinery CMS](http://refinerycms.com) version 3.0.0 or above.
* Paperclip has been removed in favor of using Refinery Resources dragonfly app
* Refinery-Resources
* Refinery-Settings

## Install

Open up your ``Gemfile`` and add at the bottom this line:

```ruby
gem 'refinerycms-jobs', github: 'bisscomm/refinerycms-jobs', branch: 'master'
```

Now, run ``bundle install``

Next, to install the jobs plugin run:

    rails generate refinery:jobs

Run database migrations:

    rake db:migrate

Finally seed your database and you're done.

    rake db:seed

## Developing & Contributing

The version of Refinery to develop this engine against is defined in the gemspec. To override the version of refinery to develop against, edit the project Gemfile to point to a local path containing a clone of refinerycms.

### Testing

Generate the dummy application to test against

    $ bundle exec rake refinery:testing:dummy_app

Run the test suite with [Guard](https://github.com/guard/guard)

    $ bundle exec guard start

Or just with rake spec

    $ bundle exec rake spec


## More Information
* Check out our [Website](http://refinerycms.com/)
* Documentation is available in the [guides](http://refinerycms.com/guides)
* Questions can be asked on our [Google Group](http://group.refinerycms.org)
* Questions can also be asked in our IRC room, [#refinerycms on freenode](irc://irc.freenode.net/refinerycms)
