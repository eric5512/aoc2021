class Point
    attr_accessor :x, :y
    def initialize(x, y)
        @x = x
        @y = y
    end

    def self.parse(string)
        nums = string.strip.split(",")
        Point.new(nums[0].to_i, nums[1].to_i)
    end

    def hash
        return (x+y)*y+x
    end

    def eql?(p)
        return ((self.x == p.x) && (self.y == p.y))
    end

    def ==(p)
        return ((self.x == p.x) && (self.y == p.y))
    end

    def <=>(p)
        if self.x == p.x
            return (self.y < p.y ? (self.y..p.y) : (p.y..self.y)).map {|y| Point.new(self.x, y)}
        elsif self.y == p.y
            return (self.x < p.x ? (self.x..p.x) : (p.x..self.x)).map {|x| Point.new(x, self.y)}
        else
            return []
        end
    end

    def to_s
        return "x:#{self.y} y:#{self.x}"
    end
end

def parse(file_name)
    f = File.read(file_name)
    lines = f.strip.split("\n")

    return lines.map{|line| line.split("->")}.map{|l1,l2| [Point.parse(l1), Point.parse(l2)]}
end

def solve
    points = parse("input.txt")
    hm = {}
    for p1, p2 in points do
        for point in p1<=>p2 do
            if hm[point]==nil
                hm[point] = 1
            else
                hm[point] += 1
            end
        end
    end

    return hm.select{ |_, v| v > 1 }.length
end

puts solve