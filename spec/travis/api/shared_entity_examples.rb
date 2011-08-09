shared_examples_for "An Entity" do

  it 'should respond to any of the attribute names' do
    @attributes.each_key do |method|
      @entity.should respond_to method
    end
  end

  it 'should return any of the attributes' do
    @attributes.each_key do |method|
      @entity.send(method).should equal @attributes[method]
    end
  end

end
  
