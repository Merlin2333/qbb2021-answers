Overall it is clear that you have a good understanding of the concepts and how to put them together into a functional program that answers the question being asked.

Good use of comments, although convention is to try and keep lines shorter than 120 characters (or 80) so they fit easily on a screen without scrolling. THis makes the code more readable. SO, consider putting your comments on the line before the code they go with.

On line 42, you check to see if the mutation is closer to the start of `gene[current_index]` or `gene[current_index + 1]`. But what happens if the mutation is 100 away from the start of the second gene, 200 away from the start of the first gene, but 50 away from the end of the first gene?

It's also really important to thing about what happens when the data is technically valid but presents a rare (edge) case. For example what will your code do if the mutation is past the end of the last gene? What happens if the gene list only contains one gene? If you can make you code general enough to handle edge cases, it will prove much more useful in the long run. It also helps you feel out the boundaries of the problem having to think of these cases.

Also, I really like that you wrote a function for finding the distance and around your main code. I was sad to see that you didn't use the distance function everywhere you calculated the distance. 

% completion: 100%

Great job. Keep it up!