ThinkingSphinx::Index.define :question, with: :active_record do
  #fields
  indexes title, sortable: true
  indexes body
  indexes author.email, as: :author, sortable: true

  #attributes (поля по которым мы можем группировать. сортировать, по которым не делаем поиск)
  has author_id, created_at, updated_at
end