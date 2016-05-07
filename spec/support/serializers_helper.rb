def equal_keys(keys)
  keys.each do |key|
    it "has proper #{key}" do
      expect(subject[key]).to eq(object[key])
    end
  end
end
