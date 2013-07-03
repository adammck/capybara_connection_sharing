# Capybara Issue 1047

This is an example of a (admittedly strange) situation in which the Capybara
connection-sharing advice is insufficient.

See: https://github.com/jnicklas/capybara/pull/1047

    git clone https://github.com/adammck/capybara_connection_sharing.git
    cd capybara_connection_sharing
    bundle

    bin/rake test:all PATCH=none     # FAIL
    bin/rake test:all PATCH=capybara # FAIL
    bin/rake test:all PATCH=mperham  # PASS
