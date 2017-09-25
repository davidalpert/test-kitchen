Feature: Suspending kitchen instances
  In order to better manage resources on my host
  As an operator
  I want to run a command to suspend my instances

  Background:
    Given a file named ".kitchen.yml" with:
    """
    ---
    driver:
      name: suspendabledummy

    provisioner:
      name: dummy

    verifier:
      name: dummy

    platforms:
      - name: beans

    suites:
      - name: client
    """

  @spawn
  Scenario: Suspending a single instance when suspend is supported

    When I successfully run `kitchen create client-beans`
    And I successfully run `kitchen list client-beans`
    Then the stdout should match /^client-beans\s+.+\s+Created\s+\<None\>\Z/
    When I run `kitchen suspend client-beans`
    Then the output should contain "Suspending <client-beans> ..."
    And the output should contain "Suspended <client-beans>."
    And the exit status should be 0
    When I successfully run `kitchen list client-beans`
    Then the stdout should match /^client-beans\s+.+\s+Suspended\s+\<None\>\Z/

  @spawn
  Scenario Outline: Suspending and resume a single instance doesn't change last action

    When I successfully run `kitchen <action> client-beans`
    And I successfully run `kitchen list client-beans`
    Then the stdout should match /^client-beans\s+.+\s+<last_action>\s+\<None\>\Z/
    When I run `kitchen suspend client-beans`
    Then the output should contain "Suspending <client-beans> ..."
    And the output should contain "Suspended <client-beans>."
    And the exit status should be 0
    When I successfully run `kitchen list client-beans`
    Then the stdout should match /^client-beans\s+.+\s+Suspended\s+\<None\>\Z/
    When I run `kitchen resume client-beans`
    Then the output should contain "Resuming <client-beans> ..."
    And the output should contain "Resumed <client-beans>."
    And the exit status should be 0
    When I successfully run `kitchen list client-beans`
    Then the stdout should match /^client-beans\s+.+\s+<last_action>\s+\<None\>\Z/

    Examples:
      | action   | last_action |
      | create   | Created     |
      | converge | Converged   |
      | setup    | Set Up      |
      | verify   | Verified    |

  @spawn
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
