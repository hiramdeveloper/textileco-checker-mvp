require 'barby'
require 'barby/barcode/ean_13'
require 'barby/outputter/ascii_outputter'
require 'barby/outputter/html_outputter'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
