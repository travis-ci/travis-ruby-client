require './spec/spec_helper'
require './spec/travis/api/shared_entity_examples'

module Travis
  
  module API

    describe Entity do

      describe 'when initialized without attributes' do

        before(:each) do
          @attributes = {}
          @entity = Entity.new
        end
          
        it_should_behave_like 'An Entity'

        it 'should be successfully initialized' do
          @entity.should be_instance_of Entity
        end

      end

      describe 'when initialized with valid attributes' do
  
        before(:each) do
          @attributes = {
            'number' => 1,
            'string' => "string",
            'array'  => [1,2,3]
          }

          @entity = Entity.new(@attributes)
        end
        
        it_should_behave_like 'An Entity'

      end
    
    end

  end

end

