class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :subdomain
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
