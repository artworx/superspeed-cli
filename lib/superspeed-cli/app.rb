module SuperspeedCli
  class App
    attr_reader :page, :agent

    BASE_URL = "http://intern.loki.pitechnologies.ro/app_dev.php"
    LOGIN_URL = "#{BASE_URL}/login"
    MONTH_URL = "#{BASE_URL}/superspeed/report/index/%{year}/%{month}"
    CREATE_LOG_URL = "#{BASE_URL}/superspeed/report/log"
    CREDENTIALS_FILE = File.expand_path("~/.superspeed-cookies")

    def initialize(agent)
      @agent = agent
    end

    def login(username, password)
      @page = @agent.get(LOGIN_URL)

      login_form = @page.form
      login_form._username = username
      login_form._password = password

      @page = @agent.submit(login_form, login_form.buttons.first)
      raise "Login failed #{@page.search('//div[contains(@class, "alert")]').text}" if login_form_visible?

    end

    def save_credentials
      authenticate!

      @agent.cookie_jar.save_as CREDENTIALS_FILE, session: true, format: :yaml
    end

    def days
      authenticate!

      ExecJS.compile(script).exec('return days')
    end

    def companies
      authenticate!

      ExecJS.compile(script).exec('return companies')
    end

    def days_info
      authenticate!

      ExecJS.compile(script).exec('return daysInfo')
    end

    def script
      @page.search('//script')[6].content
    end

    def load_month(date = Date.today)
      authenticate!

      url = MONTH_URL % { year: date.year, month: date.month}
      @page = @agent.get(url)
    end

    def create_log(log)
      authenticate!

      @page = @agent.post CREATE_LOG_URL, log.to_json, {'accept' => 'application/json', 'Content-Type' => 'application/json'}
    end

    def authenticated?
      @agent.cookies.any? { |c| c.name == 'PHPSESSID' }
    end

    def login_form_visible?
      @page.content.match(/login_check/)
    end

    def load_credentials
      @agent.cookie_jar.load(CREDENTIALS_FILE)
    end

    def authenticate!
      raise "You need to login first" unless authenticated?
    end
  end
end

