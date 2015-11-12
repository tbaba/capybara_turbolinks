require 'capybara'

module CapybaraTurbolinks 
  FETCH_CSS_SELECTOR='body.page--fetch'
  COMPLETE_CSS_SELECTOR='body.page--complete'

  module ::Capybara
    module Node
      module Actions 
        class_eval do
          def click_turbolink(*args)
            click_link(*args)
            has_css? FETCH_CSS_SELECTOR
            has_css? COMPLETE_CSS_SELECTOR 
          end
        end
      end
      class Element < Base
        class_eval do 
          def turboclick 
            click
            session.has_css? FETCH_CSS_SELECTOR
            session.has_css? COMPLETE_CSS_SELECTOR
          end
        end
      end
    end
    class Session
      class_eval do
        define_method :click_turbolink do |*args, &block|
          @touched = true
          current_scope.send(:click_turbolink, *args, &block)
        end
      end
    end
    module DSL
      class_eval do
        define_method :click_turbolink do |*args, &block|
          page.send :click_turbolink, *args, &block
        end
      end
    end
  end
end

