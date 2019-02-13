module TweetsHelper
	def get_tagged(tweet)
	#search through the tweet's message word-by-word
      #if the word is a tag, do the following:
      #see if the tag already exitsts
      #if it doesnt, create a new tag in the tag table
      #if it does, grab the tag fom the tags table
      #then link the tweet and the tag using a new entry in the join table
      #finally, replace the tag in the tweets message with a link to  a new page

    message_arr = tweet.message.split
    message_arr.each_with_index do |word, index|
      if word[0] == "#"
        if Tag.pluck(:phrase).include?(word.downcase)
          tag = Tag.find_by(phrase: word.downcase)
        else
          tag = Tag.create(phrase: word.downcase)
        end
        TweetTag.create(tweet_id: tweet.id, tag_id: tag.id)
        message_arr[index] = "<a href='/tag_tweets?id=#{tag.id}'>#{word}</a>"
      end
    end

    	tweet.message = message_arr.join(" ")
    	return tweet 
	end
end
