
class RubyTalkGUI
  def initialize
    @root = TkRoot.new { title "RubyTalkGUI" }
    @new_workspace_btn = TkButton.new(@root) do
      borderwidth 1
      state "normal"
      text "New Workspace"
      pack
    end
    @new_workspace_btn.command do
      new_workspace
    end

    @new_system_browser_btn = TkButton.new(@root) do
      borderwidth 1
      state "normal"
      text "System Browser"
      pack
    end
    @new_system_browser_btn.command do
      new_system_browser
    end
  end

  def new_workspace
    Workspace.new(@root)
  end

  def new_window
    TkToplevel.new(@root)
  end

  def root
    @root
  end
end
