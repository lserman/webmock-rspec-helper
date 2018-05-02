module WebMock
  module RSpec
    class StubData
      attr_reader :directory, :name_without_extension

      def initialize(directory, name_without_extension)
        @directory = directory
        @name_without_extension = name_without_extension
      end

      def json
        JSON.parse raw :json
      end

      def raw(extension = '')
        extension = ".#{extension}" unless extension.empty?
        File.read directory.join("#{name_without_extension}#{extension}")
      end
    end
  end
end
