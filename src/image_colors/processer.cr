module ImageColors
  class Processer
    def initialize(@file : IO::FileDescriptor)
    end

    def convert
      p @file
    end
  end
end
