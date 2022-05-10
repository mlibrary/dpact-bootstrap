[![Ruby Style Guide](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/testdouble/standard)
[![CI](https://github.com/mlibrary/dpact-bootstrap/actions/workflows/ci.yml/badge.svg)](https://github.com/mlibrary/dpact-bootstrap/actions/workflows/ci.yml)

# Digital Preservation and Access Component Technologies (DPACT) Bootstrap

Digital Preservation and Access Component Technologies (DPACT) is a strategic initiative of the Library Information Technology division, and also the umbrella name for the technology solutions expected to emerge. It is a huge undertaking to make great systems and code for digital preservation and access. We need to understand the context for DPACT, and think strategically about how it relates to desired outcomes broadly considered. This includes our use of technology to positively impact humanity, and being conscientious in order to avoid doing the opposite.

Bootstrap is simply a repository to get the ball rolling.  A central location to dump files to be shared amoungst the team and a place to explore BDD using Ruby and Cucumber.  

## Installation

## Usage
### Build
```bash
docker-compose build dpact
docker-compose run --rm dpact bundle install
```
#### CI (default)
```bash
docker-compose run --rm dpact bundle exec rake
```
#### rubocop, rubocop:fix (or rubocop directly)
```bash
docker-compose run --rm dpact bundle exec rake rubocop
docker-compose run --rm dpact bundle exec rake rubocop:fix
docker-compose run --rm dpact bundle exec rubocop
```
#### spec (or rspec directly)
```bash
docker-compose run --rm dpact bundle exec rake spec
docker-compose run --rm dpact bundle exec rspec
```
#### cucumber (or cucumber directly)
```bash
docker-compose run --rm dpact bundle exec rake cucumber
docker-compose run --rm dpact bundle exec cucumber
```
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
