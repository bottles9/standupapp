class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.references :account, foreign_key: true
      t.string :plan_id
      t.string :stripe_customer_id
      t.datetime :start
      t.string :status
      t.string :stripe_subscription_id
      t.string :stripe_token
      t.string :card_last4
      t.string :card_expiration
      t.string :card_type
      t.string :stripe_status
      t.string :idempotency_key

      t.timestamps
    end
  end
end
