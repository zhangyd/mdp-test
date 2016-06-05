class ChangeDataTypeForDependencyId < ActiveRecord::Migration
  def self.up
    change_table :vulnerabilities do |t|
      t.change :dependency_id, :string
    end
  end
  def self.down
    change_table :vulnerabilities do |t|
      t.change :dependency_id, :integer
    end
  end
end
