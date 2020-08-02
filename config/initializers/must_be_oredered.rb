# config/initializers/must_be_ordered.rb
 
MustBeOrdered.enabled = !Rails.env.production?
 
# ↓はお好みでON/OFF
MustBeOrdered.raise = true
MustBeOrdered.must_be_ordered_logger = true
MustBeOrdered.rails_logger = true