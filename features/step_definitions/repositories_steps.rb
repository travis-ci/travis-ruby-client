Given /^I am using the ((?:\:?{2}\w+)+) client$/ do |class_name|
  @client = class_name.split('::').inject(Object) {|x,y| x = x.const_get(y)}    
end

Then /^I should get a collection of ((?:\:?{2}\w+)+) instances$/ do |class_name|
  expected_class = class_name.split('::').inject(Object) {|x,y| x = x.const_get(y)}
  @result.each do |element|
    element.should be_instance_of expected_class
  end
end

When /^I set the (\w+) to "([^"]*)"$/ do |method, value|
  @client = @client.send(method, value)
end

Then /^I should get a ((?:\:?{2}\w+)+)$/ do |class_name|
  @result.should be_instance_of class_name.split('::').inject(Object) {|x,y| x = x.const_get(y)}
end

Then /^the result should have the following values:$/ do |table|
  table.rows_hash.each_pair do |key, value|
    @result.send(key).should == value
  end
end

Then /^the result should have the following numeric values:$/ do |table|
  table.rows_hash.each_pair do |key, value|
    @result.send(key).should == value.to_f
  end
end

When /^I request (\w+\!?)$/ do |method|
  @result = @client.send(method)
end

When /^I request (\w+\!?) with the following params:$/ do |method, table|
  @result = @client.send(method, *table.raw.collect(&:first))
end

Then /^the result should respond to "([^"]*)" with a collection of ((?:\:?{2}\w+)+) instances$/ do |method, class_name|
  expected_class = class_name.split('::').inject(Object) {|x,y| x = x.const_get(y)}
  @result.send(method).each do |element|
    element.should be_instance_of expected_class
  end
end

Then /^the result should respond to "([^"]*)" with a ((?:\:?{2}\w+)+) instances$/ do |method, class_name|
  expected_class = class_name.split('::').inject(Object) {|x,y| x = x.const_get(y)}
  @result.send(method).should be_instance_of expected_class
end

