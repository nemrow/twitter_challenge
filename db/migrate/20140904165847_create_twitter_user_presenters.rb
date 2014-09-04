class CreateTwitterUserPresenters < ActiveRecord::Migration
  def change
    create_table :twitter_user_presenters do |t|

      t.timestamps
    end
  end
end
