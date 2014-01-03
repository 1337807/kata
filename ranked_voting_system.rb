#!/usr/bin/env ruby
puts "Enter number of votes and candidates space-delimited (V C):"
numbers = gets.strip
number_of_votes = numbers.split.first
number_of_candidates = numbers.split.last
puts "Enter list of candidate names (grace ada alan):"
names = gets.strip
candidates = names.split

@election = Election.new(candidates)

input = nil
while input != "\n" do
  input = gets.strip
  election.ballots << Ballot.new(input)
end

class Ballot
  attr_reader :votes

  def initialize(votes)
    @votes = votes
  end
end

class Election
  attr_accessor :ballots, :winner

  def initialize(candidates)
    @candidates = candidates
    @ballots = []
    @winner = nil
  end

  def calculate_rounds
    @candidates.length.times do |candidate|
      # calculate rounds here
    end

    round1 = percentages(@ballots.map(&:first))
    round2 = percentages(@ballots.map(&:second))
    round3 = percentages(@ballots.map(&:third))

    if clear_winner?(round1)
    elsif clear_winner?(round2)
    elsif clear_winner?(round3)
    else
      puts "No winner."
    end

    all_the_output
  end

  def clear_winner?(round)
  end

  def percentages(votes)
    counts = {}
    total = 0
    percentages = {}

    votes.each do |vote|
      total += 1
      counts[vote] ||= 0
      counts[vote] += 1
    end

    counts.each do |vote_index, vote_count|
      percentages[vote_index] = vote_count.to_f / total
    end

    percentages
  end
end

output = @election.calculate_rounds

puts output
puts @election.winner
