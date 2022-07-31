class TestWorker
    @queue = :test_queue
    def self.perform id
        puts "Running worker with #{id}"
        post = Post.find 1
        post.update body: post.body + " #{DateTime.now} \n"
    end

end
