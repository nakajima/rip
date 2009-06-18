module Rip
  class DirPackage < Package
    handles do |source|
      File.directory? source
    end

    def initialize(source, *args)
      super
      @source = File.expand_path(source)
    end

    def exists?
      File.directory? source
    end

    memoize :name
    def name
      path.gsub(/-((?:\d+\.?)+\d+)$/, '')
    end

    def version
      if path.match(/-((?:\d+\.?)+\d+)$/)
        $1
      else
        "unversioned"
      end
    end

    def fetch!
      FileUtils.rm_rf cache_path
      FileUtils.cp_r "#{source}/.", cache_path
    end

    private

    def path
      File.basename(source)
    end
  end
end
