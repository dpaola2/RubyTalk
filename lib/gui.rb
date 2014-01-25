
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

class Workspace
  def initialize(root)
    @window = TkToplevel.new(root) do
      title "Workspace"
    end
    @workspace = TkText.new(@window) do
      width 30
      height 20
      borderwidth 1
      pack("side" => "right", "padx" => "5", "pady" => 5)
    end
    @eval_button = TkButton.new(@window) do
      text "Do it"
      borderwidth 1
      state "normal"
      pack("side" => "left", "padx" => "50", "pady" => "10")
    end
    @eval_button.command do
      @workspace.insert("insert", eval(@workspace.get("1.0", "end")))
    end 
  end
end
