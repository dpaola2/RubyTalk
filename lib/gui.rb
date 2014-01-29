
class RubyTalkGUI
  def initialize
    @root = TkRoot.new { title "RubyTalk" }
    @dock = RubyTalkDock.new(@root)
  end
end
