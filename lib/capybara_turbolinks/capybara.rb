module Capybara
  module Node
    class Actions
      def click_turbolink(*args)
        click_link(*args)
        # if it's superfast then the fetch step is skipped.  Block still!
        page.has_css? 'body.page--fetch'
        expect(page).to have_css('body.page--complete')
      end
    end

    # rubocop:disable Style/ClassAndModuleChildren
    class Element
      def click_turbolink
        click
        session.has_css? 'body.page--fetch'
        session.has_css? 'body.page--complete'
        # expect(session).to have_css('body.page--fetch')
        # expect(session).to have_css('body.page--update')
      end
    end
  end
end
