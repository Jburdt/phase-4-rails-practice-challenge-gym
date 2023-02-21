class ClientSerializer < ActiveModel::Serializer
  attributes :id, :name, :age

  has_many :memberships, serializer: MembershipsSerializer
end