server 'jsipsum.lunarlogic.io', user: 'lunar', roles: %w{web app db}
set :branch, ENV.fetch('BRANCH', 'master')
