# Capybara Issue 1047

This is an example of a (admittedly strange) situation in which the Capybara
connection-sharing advice is insufficient.

See: https://github.com/jnicklas/capybara/pull/1047

    bundle exec rake test:all PATCH=none
    bundle exec rake test:all PATCH=capybara
    bundle exec rake test:all PATCH=mperham
