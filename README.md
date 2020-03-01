###  Dependents:
+ postgresql 11

## Project setup
```
bundle install
```

### Generate doc

```
yardoc 'lib/**/*.rb' 'app/**/*.rb'
```

### Start dev server
```
bundle exec rails s
```

### Run tests
```
bin/rspec
```

### Generate new operation
```
bundle exec rails g operation SomeAction
```

### Run linter check
```
bundle exec rubocop
```

####Swagger doc

/api-docs/index.html
