
class RubyTalkGUI
  def initialize
    @root = TkRoot.new { title "RubyTalk" }
    @dock_btn = TkButton.new(@root) do
      text "Show Dock"
      pack
    end
    @dock_btn.command do
      RubyTalkDock.new(@root)
    end
  end
end
