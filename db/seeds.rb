# Seed Users
# 5.times do |i|
#   User.create!(
#     email: "user#{i+1}@example.com",
#     fullname: "User #{i+1}".ljust(8, 'x'),
#     password: "password#{i+1}"
#   )
# end

# Seed Posts
5.times do |i|
  Post.create!(
    title: "Post #{i+1}",
    content: "This is the content of post #{i+1}. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    user_id: User.first.id # Assuming you have at least one user in the database
  )
end