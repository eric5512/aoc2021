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
        ret = []
        sx = self.x <=> p.x
        sy = self.y <=> p.y
        x = p.x
        y = p.y
        until self.x == x and self.y == y do
            ret.append(Point.new(x, y))
            x += sx
            y += sy
        end
        ret.append(Point.new(x, y))
        return ret
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