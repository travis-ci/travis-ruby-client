require './spec/spec_helper'
require './spec/travis/api/shared_entity_examples'

module Travis

  module API

    class Entity

      describe Build do

        describe 'when initialized without attributes, owner or name' do

          before(:each) do
            @attributes = {}
            @entity = Build.new
          end
          
          it_should_behave_like 'An Entity'

          it 'should be successfully initialized' do
            @entity.should be_instance_of Build
          end

        end

        describe 'when initialized with valid attributes' do

          before(:each) do
            @attributes = {
              'number'        => 100,
              'committed_at'  => '2011-08-08T21:40:05Z', 
              'commit'        => 'df44d6862626d383ce755d02cd3de234bee72df9',
              'finished_at'   => '2011-08-08T21:48:00Z', 
              'config'        => %{{"bundler_args":"--without development","script":"bundle exec rake","rvm":"ruby-head","notifications":{"irc":"irc.freenode.org#john"},".configured":"true"}}, 
              'author_name'   => 'John Doe', 
              'log'           => %{Just the good ol' boys, never meanin' no harm. Beats all you've ever saw, been in trouble with the law since the day they was born. Straight'nin' the curve, flat'nin' the hills. Someday the mountain might get 'em, but the law never will. Makin' their way, the only way they know how, that's just a little bit more than the law will allow. Just good ol' boys, wouldn't change if they could, fightin' the system like a true modern day Robin Hood.}, 
              'branch'        => 'master', 
              'id'            => 1, 
              'parent_id'     => 3, 
              'started_at'    => '2011-08-08T20:48:00Z',
              'author_email'  => 'john@doe.com', 
              'status'        => 1, 
              'repository_id' => 1, 
              'message'       => 'Changing this and that', 
              'compare_url'   => 'https://github.com/johndoe/travis-ci/compare/132df3e...hf44365', 
            }


          end

          describe 'whithout repository owner/name' do
            
            before(:each) do
              @entity = Build.new(@attributes)
            end

            it_should_behave_like 'An Entity'

          end

          describe 'with repository owner/name' do

            before(:each) do
              @repository_owner = 'johndoe'
              @repository_name = 'travis-ci'
            
              @entity = Build.new(@attributes, @repository_owner, @repository_name)
            end

            it_should_behave_like 'An Entity'

          end

        end

      end

    end

  end

end

