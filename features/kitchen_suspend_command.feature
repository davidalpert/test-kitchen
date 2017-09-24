Feature: Suspending kitchen instances
  In order to better manage resources on my host
  As an operator
  I want to run a command to suspend my instances

  @spawn @wip
  Scenario: Suspending a single instance when suspend is not supported
    Given a file named ".kitchen.yml" with:
    """
    ---
    driver:
      name: dummy

    provisioner:
      name: dummy

    verifier:
      name: dummy

    platforms:
      - name: beans

    suites:
      - name: client
    """

    When I successfully run `kitchen create client-beans`
    And I successfully run `kitchen list client-beans`
    Then the stdout should match /^client-beans\s+.+\s+Created\s+\<None\>\Z/
    When I run `kitchen suspend client-beans`
    Then the output should contain "Cannot suspend <client-beans> - the [Kitchen::Driver::Dummy] driver does not support suspending."
    And the exit status should be 0
    When I successfully run `kitchen list client-beans`
    Then the stdout should match /^client-beans\s+.+\s+Created\s+\<None\>\Z/
