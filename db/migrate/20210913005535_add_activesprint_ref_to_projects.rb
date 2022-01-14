class AddActivesprintRefToProjects < ActiveRecord::Migration[6.1]
  def change
    add_reference :projects, :active_sprint
  end
end
