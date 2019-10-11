module Tensorflow
  module Keras
    module Datasets
      module FashionMNIST
        def self.load_data
          base_url = "https://storage.googleapis.com/tensorflow/tf-keras-datasets"
          files = [
            "train-labels-idx1-ubyte.gz", "train-images-idx3-ubyte.gz",
            "t10k-labels-idx1-ubyte.gz", "t10k-images-idx3-ubyte.gz"
          ]

          paths = []
          files.each do |file|
            paths << Utils.get_file(file, "#{base_url}/#{file}", cache_subdir: "datasets/fashion-mnist")
          end

          x_train, y_train, x_test, y_test = nil

          Zlib::GzipReader.open(paths[0]) do |gz|
            gz.read(8) # move to offset
            y_train = Numo::UInt8.from_string(gz.read)
          end

          Zlib::GzipReader.open(paths[1]) do |gz|
            gz.read(16) # move to offset
            x_train = Numo::UInt8.from_string(gz.read, [y_train.shape[0], 28, 28])
          end

          Zlib::GzipReader.open(paths[2]) do |gz|
            gz.read(8) # move to offset
            y_test = Numo::UInt8.from_string(gz.read)
          end

          Zlib::GzipReader.open(paths[3]) do |gz|
            gz.read(16) # move to offset
            x_test = Numo::UInt8.from_string(gz.read, [y_test.shape[0], 28, 28])
          end

          [[x_train, y_train], [x_test, y_test]]
        end
      end
    end
  end
end
