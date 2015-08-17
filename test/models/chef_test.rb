require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@chef = Chef.new(chefname: "john", email: "john@exameple.com")
  end

  test "chef should be valid" do
  	assert @chef.valid?
  end

  test "chefname should be present" do 
  	@chef.chefname = " " 
  	assert_not @chef.valid?
  end

  test "email address should be unique" do
  	dup_chef = @chef.dup 
  	dup_chef.email = @chef.email.upcase 
  	@chef.save
  	assert_not dup_chef.valid? 
  end

  test "email validation should accept valid address" do 
  	valid_addresses =  %w[user@eee.com R_TDD-DS@eee.hello.org user@example.com first.last@eem.au laura_joe@monk.cm]
  	valid_addresses.each do |va| 
  		@chef.email = va 
  		assert @chef.valid?  , '#{va.inspect} should be valid '
  	end
  end

  test "email validation should reject invalid address" do 
  	invalid_addresses = %w[user@xample,com user_at_eee.org user.name@xample. eee@i_am.com foo@ee_aar.com]
  	invalid_addresses.each do |invalid|
  		@chef.email = invalid 
  		assert_not @chef.valid?, '#{invalid.inspect} is invalid '
   	end  
  end


end
