require 'childprocess'

module Vagrant
  module Reins
    class Harness
      def initialize(path)
        @path = path

        @status_dirty = true
        check_status
      end

      def status
        check_status if @status_dirty
        @status
      end

      def up(opts)
        begin
          cmd = "vagrant up"
          cmd += "--provision" if opts[:provision] == true
          cmd += "--no-provision" if opts[:provision] == false

          command "vagrant up", 300
        rescue VagrantRuntimeError
          return false
        else
          @status_dirty = true
          return true
        end
      end

      # Run commands on the vagrant host.
      def run(cmd, opts)
        # TODO


      end

      private

      def check_status
        begin
          output = command "vagrant status --machine-readable", 5
        rescue VagrantRuntimeError
          raise VagrantEnvironmentError, "No Vagrantfile found"
        else
          output.each_line do |line|
            _, target, type, value = line.split ','
            if target == 'default' and type == 'state'
              @status = :preinit
            end
            if target == 'default' and type == 'provider-name'
              @provider = value
            end
          end
        end
        @status_dirty = false
        return @status
      end

      def command(cmd, timeout=10)
        r, w = IO.pipe
        process = ChildProcess.build("bash", "-c", cmd)
        process.io.stdout = w
        process.io.stderr = w

        process.cwd = @path

        process.start
        begin
          process.poll_for_exit(timeout)
        rescue ChildProcess::TimeoutError
          process.stop
        end
        w.close

        raise VagrantRuntimeError, r if process.exit_code != 0
        return r
      end
    end
  end
end
