
describe 'Inflector (no rules)', ->

  inflector = null

  beforeEach ->
    module 'kzo.inflector', (inflectorProvider) ->
      inflectorProvider.rules =
        plurals: []
        singular: []
        irregular: {}
        irregularInverse: {}
        uncountable: {}
      return

    inject (_$rootElement_, _$rootScope_, _inflector_) ->
      inflector = _inflector_
      $rootElement = _$rootElement_
      $rootScope = _$rootScope_
      scope = $rootScope.$new()

  it 'should add additional pluralization rules', ->
    expect(inflector.pluralize('cow')).toBe 'cow'
    inflector.plural(/$/, 's');
    expect(inflector.pluralize('cow')).toBe 'cows'

  it 'should add additional singularization rules', ->
    expect(inflector.singularize('cows')).toBe 'cows'
    inflector.singular(/s$/, '')
    expect(inflector.singularize('cows')).toBe 'cow'

  it 'should add additional uncountable rules', ->
    inflector.plural(/$/, 's');
    expect(inflector.pluralize('cow')).toBe 'cows'

    inflector.uncountable('cow');
    expect(inflector.pluralize('cow')).toBe 'cow'

  it 'should add additional irregular rules', ->
    inflector.singular(/s$/, '');
    inflector.plural(/$/, 's');

    expect(inflector.singularize('cows')).toBe 'cow'
    expect(inflector.pluralize('cow')).toBe 'cows'

    inflector.irregular('cow', 'kine');

    expect(inflector.singularize('kine')).toBe 'cow'
    expect(inflector.pluralize('cow')).toBe 'kine'

  it 'should add identical singular and pluralizations', ->
    inflector.singular(/s$/, '');
    inflector.plural(/$/, 's');

    expect(inflector.singularize('settings')).toBe 'setting'
    expect(inflector.pluralize('setting')).toBe 'settings'

    inflector.irregular('settings','settings');
    inflector.irregular('userPreferences','userPreferences');

    expect(inflector.singularize('settings')).toBe 'settings'
    expect(inflector.pluralize('settings')).toBe 'settings'

    expect(inflector.singularize('userPreferences')).toBe 'userPreferences'
    expect(inflector.pluralize('userPreferences')).toBe 'userPreferences'

describe 'Inflector (basic rules)', ->

  inflector = null

  beforeEach ->
    module 'kzo.inflector'

    inject (_$rootElement_, _$rootScope_, _inflector_) ->
      inflector = _inflector_
      $rootElement = _$rootElement_
      $rootScope = _$rootScope_
      scope = $rootScope.$new()

  it 'should pluralize', ->
    expect(inflector.pluralize('person')).toBe 'people'
    expect(inflector.pluralize('user')).toBe 'users'
    expect(inflector.pluralize('group')).toBe 'groups'
    expect(inflector.pluralize('media')).toBe 'media'
    expect(inflector.pluralize('medium')).toBe 'media'

  it 'should singularize', ->
    expect(inflector.singularize('people')).toBe 'person'
    expect(inflector.singularize('users')).toBe 'user'
    expect(inflector.singularize('media')).toBe 'medium'
    expect(inflector.singularize('data')).toBe 'datum'