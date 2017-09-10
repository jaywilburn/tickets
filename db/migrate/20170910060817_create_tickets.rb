class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.string :subject
      t.string :description
      t.string :category
      t.string :priority
      t.string :status
      t.string :external_identifier
      t.integer :requester_id
      t.integer :assignee_id

      t.timestamps
    end

    add_index :tickets, [:requester_id]
    add_index :tickets, [:assignee_id]
    add_index :tickets, [:external_identifier]
    add_index :tickets, [:subject, :description]
    add_index :tickets, [:category, :priority, :status]
  end
end
