module Cls
  VERSION = "0.0.3"

  def takes(*args, **kwargs)
    define_initialize(args, kwargs[:required] || [], kwargs[:optional] || {})
  end

  def define_initialize(args, required_keyword_args, optional_keyword_args)
    arguments = args + required_keyword_args.map{ |a| "#{a.to_s}:" } +
                       optional_keyword_args.collect { |a, value| "#{a.to_s}: #{value.inspect}"}
    assignments = (args + required_keyword_args + optional_keyword_args.keys).map { |a| "@#{a} = #{a}" }.join("\n")

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

