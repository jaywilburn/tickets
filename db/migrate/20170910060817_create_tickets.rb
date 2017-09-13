class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.string :subject
      t.text :description
      t.string :category
      t.string :priority
      t.string :status, default: 'open'
      t.string :external_identifier
      t.integer :requester_id
      t.integer :assigned_id

      t.timestamps
    end

    add_index :tickets, :requester_id
    add_index :tickets, :assigned_id
    add_index :tickets, :external_identifier, unique: true
    add_index :tickets, :subject
  end
end
