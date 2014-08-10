module Cls
  VERSION = "0.0.3"

  def takes(*args)
    keyword_args = args[-1].is_a?(Hash) ? args.delete(args[-1]) : {}
    required_keyword_args = keyword_args[:required] || []
    define_initialize(args, required_keyword_args)
  end

  def define_initialize(args, required_keyword_args)
    assignments = (args + required_keyword_args).map { |a| "@#{a} = #{a}" }.join("\n")
    arguments = args + required_keyword_args.map { |a| "#{a.to_s}:" }

    self.class_eval %{
      def initialize(#{arguments.join(", ")})
                     #{assignments}
      end
    }
  end

  def let(name, &block)
    define_method(name, &block)
  end
end

