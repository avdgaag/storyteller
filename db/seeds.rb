# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
ActiveRecord::Base.transaction do
  User.delete_all
  Story.delete_all
  Comment.delete_all
  Epic.delete_all

  user = User.create! email: 'arjan@kabisa.nl', password: 'welkom12345', password_confirmation: 'welkom12345' do |u|
    u.confirmed_at = 5.minutes.ago
  end

  30.times do |i|
    story = Story.create! title: "Example story #{i}", body: 'Lorem ipsum dolor sit amet'
    10.times do |j|
      story.comments.create! body: "Foo bar baz and bla bla bla #{j}" do |c|
        c.user = user
      end
    end
  end

  5.times do |i|
    epic = Epic.create! title: "Example epic #{i}", body: 'Lorem ipsum' do |e|
      e.author = user

      5.times do |j|
        story = Story.create! title: "Example story #{j}", body: 'Lorem ipsum dolor sit amet'
        3.times do |k|
          story.comments.create! body: "Foo bar baz and bla bla bla #{k}" do |c|
            c.user = user
          end
        end
      end
    end
  end
end
