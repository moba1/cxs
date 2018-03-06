require "./*"
require "random"

module Cxs
    abstract class XorShift
        include Random

        private abstract def make_seed
        abstract def next_u
    end

    class XorShift32 < XorShift
        @state : Array(UInt32)

        private def make_seed
            Array.new(
                1,
                (Time.new.epoch_ms * Process.pid * Thread.current.object_id * self.hash).to_u32
            )
        end

        def initialize(@state = make_seed)
        end

        def next_u
            y = @state[0] ^ (@state[0] << 5)
            y >>= 27
            (@state[0] = y ^ (y << 25))
        end
    end

    class XorShift64 < XorShift
        @state : Array(UInt64)

        private def make_seed
            Array.new(
                1,
                (Time.new.epoch_ms * Process.pid * Thread.current.object_id * self.hash).to_u64
            )
        end

        def initialize(@state = make_seed)
        end

        def next_u
            y = @state[0] ^ (@state[0] << 33)
            y >>= 31
            (@state[0] = y ^ (y << 43))
        end
    end

    class XorShift96 < XorShift
        @state : Array(UInt32)

        private def make_seed
            core_seed = (Time.new.epoch_ms * Process.pid * Thread.current.object_id * self.hash).to_u32

            [
                core_seed,
                core_seed * Process.pid,
                core_seed * Thread.current.object_id
            ].map { |a| a.to_u32 }
        end

        def initialize(@state = make_seed)
        end

        def next_u
            x, y, z = @state

            t = (x ^ (x << 3)) ^ (y ^ (y >> 19)) ^ (z ^ (z << 6))
            @state[0] = y
            @state[1] = z
            (@state[2] = t)
        end
    end

    class XorShift128 < XorShift
        @state : Array(UInt32)

        private def make_seed
            core_seed = (Time.new.epoch_ms * Process.pid * Thread.current.object_id * self.hash).to_u32

            [
                core_seed,
                core_seed * Process.pid,
                core_seed * Thread.current.object_id,
                core_seed * self.hash
            ].map { |a| a.to_u32 }
        end

        def initialize(@state = make_seed)
        end

        def next_u
            x, y, z, w = @state

            t = (x ^ (x << 20)) ^ (y ^ (y >> 11)) ^ (z ^ (z << 27)) ^ (w ^ (w >> 6))
            @state[0] = y
            @state[1] = z
            @state[2] = w
            (@state[3] = t)
        end
    end
end
