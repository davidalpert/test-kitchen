# -*- encoding: utf-8 -*-
#
# Author:: David Alpert (<david@spinthemoose.com>)
#
# Copyright (C) 2013, Fletcher Nichol
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "kitchen/command"
require "json"

module Kitchen
  module Command
    # Command to list one or more instances.
    #
    # @author David Alpert <david@spinthemoose.com>
    class Suspend < Kitchen::Command::Base
      # Invoke the command.
      def call
        results = parse_subcommand(args.first)

        die "Argument `#{args.first}' returned no results." if results.empty?

        results.each { |instance| instance.suspend }
      end
    end
  end
end
