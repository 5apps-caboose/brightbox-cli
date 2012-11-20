Shindo.tests('test_helper', 'meta') do

  tests('#formats_kernel') do

    tests('returns true') do

      test('when format of value matches') do
        formats_kernel({:a => :b}, {:a => Symbol})
      end

      test('when format of nested array elements matches') do
        formats_kernel({:a => [:b, :c]}, {:a => [Symbol]})
      end

      test('when format of nested hash matches') do
        formats_kernel({:a => {:b => :c}}, {:a => {:b => Symbol}})
      end

      test('when format of an array') do
        formats_kernel([{:a => :b}], [{:a => Symbol}])
      end

      test('non strict extra data') do
        formats_kernel({:a => :b, :b => :c}, {:a => Symbol}, true, false)
      end

    end

    tests('returns false') do

      test('when format of value does not match') do
        !formats_kernel({:a => :b}, {:a => String})
      end

      test('when not all keys are checked') do
        !formats_kernel({:a => :b}, {})
      end

      test('when some keys do not appear') do
        !formats_kernel({}, {:a => String})
      end

      test('when an array is expected but another data type is found') do
        !formats_kernel({:a => 'not an array'}, {:a => []})
      end

      test('when a hash is expected but another data type is found') do
        !formats_kernel({:a => 'not a hash'}, {:a => {}}, true, false)
      end


      test('non strict extra data') do
        !formats_kernel({:a => :b, :b => :c}, {:z => Symbol}, true, false)
      end

    end

  end

end
