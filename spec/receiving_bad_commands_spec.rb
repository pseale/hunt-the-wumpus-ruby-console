require_relative 'spec_helper'
require 'require_all'
require_all 'lib'

describe "Receiving bad commands from the client" do
  before :each do
    @game = HuntTheWumpus.new(10)
  end

  it "errors out" do
    expect { @game.receive_command(nil) }.to raise_error InvalidCommandError
  end
end
