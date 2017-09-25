# -*- encoding: utf-8 -*-
#
# Author:: Fletcher Nichol (<fnichol@nichol.ca>)
#
# Copyright (C) 2012, 2013, 2014 Fletcher Nichol
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

require "kitchen"
require "kitchen/driver/dummy"

module Kitchen
  module Driver
    # Suspendable dummy driver for Kitchen. This driver extends the Dummy driver
    # with stubbed support for suspend and resume.  Like the base class, it does
    # nothing but report what would happen if this driver did anything of
    # consequence. As a result it may be a useful driver to use when debugging
    # or developing new features or plugins which need to support suspending
    # and resuming an instance.
    #
    # @author David Alpert <david@spinthemoose.com>
    class Suspendabledummy < Kitchen::Driver::Dummy
      # (see Base#supports_suspend?)
      def supports_suspend?
        true
      end

      # (see Base#suspend)
      def suspend(state)
        report(:suspend, state)
      end
    end
  end
end
