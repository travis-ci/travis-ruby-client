require './spec/spec_helper'
require './spec/travis/api/shared_entity_examples'

module Travis

  module API

    class Entity

      describe Repository do

        describe 'when initialized without attributes, owner or name' do

          before(:each) do
            @attributes = {}
            @entity = Repository.new
          end
          
          it_should_behave_like 'An Entity'

          it 'should be successfully initialized' do
            @entity.should be_instance_of Repository
          end

        end

        describe 'when initialized with valid attributes' do

          before(:each) do
            @attributes = {
              "id"                     => 10,
              "last_build_id"          => 100,
              "last_build_number"      => "255",
              "last_build_status"      => 1,
              "last_build_start_at"    => "2011-08-08T21:45:13Z",
              "last_build_finished_at" => "2011-08-08T21:48:00Z",
              "slug"                   => "johndoe/travis-ci",
              "status"                 => "unstable"
            }
          end

          describe 'whithout owner/name' do 
            
            before(:each) do
              @entity = Repository.new(@attributes)
            end
            
            it_should_behave_like 'An Entity'

            it 'should recognize the name and the owner from the slug' do
              @entity.owner.should == 'johndoe'
              @entity.name.should == 'travis-ci'
            end

          end

          describe 'with owner/name' do

            before(:each) do
              @repository_owner = 'johndoe'
              @repository_name = 'travis-ci'

              @entity = Repository.new(@attributes, @repository_owner, @repository_name)
            end

            it_should_behave_like 'An Entity'

          end

        end

      end

    end

  end

end

