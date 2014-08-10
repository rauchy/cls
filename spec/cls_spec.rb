require "cls"

class NamePresenter
  extend Cls
  attr_reader :name
  takes(:name)
  let(:yelled_name) { @name.upcase }
  let(:name_with_argument) { |other| }
  let(:increment) { @value ||= 0; @value += 1 }
end

class ProfilePresenter
  extend Cls
  attr_reader :name, :age
  takes(:name, required: [:age])
end

describe Cls do
  describe "initializers" do
    it "takes initializer arguments" do
      NamePresenter.new("Bob").name.should == "Bob"
    end

    it "errors when there are too many initializer arguments" do
      expect do
        NamePresenter.new("Bob", "Smith")
      end.to raise_error(ArgumentError)
    end

    it "errors when there are too few initializer arguments" do
      expect do
        NamePresenter.new
      end.to raise_error(ArgumentError)
    end
  end

  describe "initializers with keyword arguments" do
    it "takes required keyword arguments" do
      ProfilePresenter.new("Bob", age: 30).age.should == 30
    end

    it "errors when required keyword arguments are not passed" do
      expect do
        ProfilePresenter.new("Bob")
      end.to raise_error(ArgumentError)
    end
  end

  describe "let methods" do
    let(:presenter) { NamePresenter.new("Bob") }

    it "defines methods" do
      presenter.yelled_name.should == "BOB"
    end

    it "does not cache method return values" do
      presenter.increment.should_not == presenter.increment
    end

    it "errors when there are too many method arguments" do
      expect do
        presenter.yelled_name("extra argument")
      end.to raise_error(ArgumentError)
    end

    it "errors when there are too few method arguments" do
      expect do
        presenter.name_with_argument
      end.to raise_error(ArgumentError)
    end
  end

  it "doesn't pollute other classes" do
    expect do
      Class.new { takes :name }
    end.to raise_error(NameError)
  end
end

