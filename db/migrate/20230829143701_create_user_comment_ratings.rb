class CreateUserCommentRatings < ActiveRecord::Migration[7.0]
  def change
      create_table :user_comment_ratings do |t|
        t.references :user, foreign_key: true
        t.references :comment, foreign_key: true
        t.integer :rating
        # add other columns if needed

        t.timestamps
    end
  end
end
