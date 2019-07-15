def readhexnums(openable)
    File.open(openable) {|f| f.readlines.map {|line| line.to_i(16) } }
end

def productremaindertree(origfactors)
    return origfactors if origfactors.length == 1
    #print(origfactors)
    STDERR.print(origfactors.length,"\n",Time.now,"\n")
    onelevelup = (0...origfactors.length).step(2).to_a.map {|i| (i+1 < origfactors.length) ? origfactors[i] * origfactors[i+1] : origfactors[i]}
    #print(origfactors, onelevelup)
    oneleveluprems = productremaindertree(onelevelup)
    STDERR.print(Time.now, "\n")
    #print(origfactors, onelevelup, oneleveluprems)
    return (0...origfactors.length).to_a.map {|i| oneleveluprems[i / 2] % (origfactors[i] * origfactors[i]) }
end

def allgcds(origfactors)
    remainders = productremaindertree(origfactors)
    return (0...origfactors.length).to_a.map {|i| origfactors[i].gcd(remainders[i] / origfactors[i])}
end

STDOUT.print(allgcds(readhexnums('/dev/stdin')).map {|i| i.to_s(16)}.join("\n")) if __FILE__ == $0

