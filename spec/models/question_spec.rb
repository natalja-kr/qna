require 'rails_helper'

RSpec.describe Question, :type => :model do
  it { should validate_presence_of :title}
  it { should validate_presence_of :body}
  it { should belong_to :user}
  it { should ensure_length_of(:title).is_at_least(15) }
  it { should ensure_length_of(:title).is_at_most(200) }
end
