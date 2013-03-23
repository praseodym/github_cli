# encoding: utf-8

module GithubCLI
  class Commands::Milestones < Command

    namespace :milestone

    desc 'list <user> <repo>', 'List milestones for a repository'
    option :state, :type => :string, :default => "open",
      :desc => "open, closed, default: open"
    option :sort, :type => :string, :default => "due_date",
      :desc => "due_date, completeness, default: due_date"
    option :direction, :type => :string, :default => "desc",
      :desc => "asc, desc, default: desc"
    long_desc <<-DESC
      Parameters

        state - open, closed, default: open\n
        sort - due_date, completeness, default: due_date\n
        direction - asc, desc, default: desc\n
    DESC
    def list(user, repo)
      params = options[:params].dup
      params['state'] = options[:state] || 'open'
      params['sort']  = options[:sort] || 'due_date'
      params['direction'] = options[:direction] || 'desc'
      Milestone.all user, repo, params, options[:format]
    end

    desc 'get <user> <repo> <number>', 'Get a single milestone'
    def get(user, repo, number)
      Milestone.get user, repo, number, options[:params], options[:format]
    end

    desc 'create <user> <repo>', 'Create a milestone'
    option :title, :type => :string, :required => true
    option :state, :type => :string, :default => "open",
      :desc => "open, closed, default: open"
    option :desc, :type => :string
    option :due_on, :type => :string, :desc => "Optional string - ISO 8601 time"
    long_desc <<-DESC
      Parameters

        title - Required string\n
        state - Optional string - open or closed\n
        description - Optional string\n
        due_on - Optional string - ISO 8601 time\n

      Example

      ghc milestone create wycats thor --title=new
    DESC
    def create(user, repo)
      params = options[:params].dup
      params['title'] = options[:title]
      params['state'] = options[:state] if options[:state]
      params['description'] = options[:desc] if options[:desc]
      params['due_on'] = options[:due_on] if options[:due_on]
      Milestone.create user, repo, params, options[:format]
    end

    desc 'update <user> <repo> <number>', 'Update a milestone'
    option :title, :type => :string
    option :state, :type => :string, :default => "open",
      :desc => "open, closed, default: open"
    option :desc, :type => :string
    option :due_on, :type => :string, :desc => "Optional string - ISO 8601 time"
    long_desc <<-DESC
      Parameters

        title - Required string\n
        state - Optional string - open or closed\n
        description - Optional string\n
        due_on - Optional string - ISO 8601 time\n

      Example

      ghc milestone update wycats thor 1 --title=new
    DESC
    def update(user, repo, number)
      params = options[:params].dup
      params['title'] = options[:title] if options[:title]
      params['state'] = options[:state] if options[:state]
      params['description'] = options[:desc] if options[:desc]
      params['due_on'] = options[:due_on] if options[:due_on]
      Milestone.update user, repo, number, params, options[:format]
    end

    desc 'delete <user> <repo> <number>', 'Delete a milestone'
    def delete(user, repo, number)
      Milestone.delete user, repo, number, options[:params], options[:format]
    end

  end # Milestones
end # GithubCLI
