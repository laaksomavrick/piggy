# frozen_string_literal: true

# Create dev user
admin = User.create(email: 'admin@example.com', password: 'Qweqwe1!', first_name: 'Joe', last_name: 'Sixpack')
org = admin.organization

member = User.new(email: 'member@example.com', password: 'Qweqwe1!', first_name: 'Jane', last_name: 'America')
member.organizations << org
member.save
