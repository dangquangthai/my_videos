# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :registerable, :recoverable, :rememberable and :omniauthable
  devise :database_authenticatable, :validatable

  has_many :follows, as: :followable, dependent: :destroy
  has_many :followers, through: :follows, source: :user
  has_many :videos, dependent: :destroy
end
