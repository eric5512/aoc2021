use std::fs;

type Carton = Vec<Vec<i32>>;

#[derive(Default, Debug)]
struct Bingo {
    numbers: Vec<i32>,
    cartones: Vec<Carton>
}

impl Bingo {
    fn someone_won(&self) -> Vec<usize> {
        let mut ret: Vec<usize> = vec![];
        for (ncarton, carton) in (&self.cartones).into_iter().enumerate() {
            let mut pushed = false;
            for fila in carton {
                if fila.into_iter().all(|x| *x == -1i32) {
                    ret.push(ncarton);
                    pushed = true;
                    break;
                }
            }

            if !pushed {
                for i in 0..carton[0].len() {
                    let mut aux: bool = true;
    
                    for fila in carton {
                        if fila[i] != -1 {
                            aux = false;
                            break;
                        }
                    }
    
                    if aux {
                        ret.push(ncarton);
                        break;
                    }
                }
            }
        }
        return ret;
    }

    fn suma_carton(&self, n: usize) -> i32 {
        return (&self.cartones[n]).into_iter().map(|x| x.into_iter().filter(|x| **x != -1).sum::<i32>()).sum::<i32>();
    }

    fn draw_number(&mut self, number: i32) {
        for carton in &mut self.cartones {
            for i in 0..carton.len() {
                carton[i] = (&carton[i]).into_iter().map(|x| if *x == number { -1 } else { *x } ).collect();
            }
        }
    }

    fn play(&mut self) -> Vec<(i32, i32)> {
        let mut aux: Vec<i32> = vec![];
        let mut ret: Vec<(i32, i32)> = vec![];
        aux.extend_from_slice(&self.numbers);
        for n in aux {
            self.draw_number(n);
            let mut winners = self.someone_won();
            for el in &winners {
                ret.push((n, self.suma_carton(*el)));
            }
            
            winners.reverse();
            for el in winners {
                self.cartones.remove(el);
            }
        }

        return ret;
    }
}

fn parse_file() -> Bingo {
    let text = fs::read_to_string("input.txt").expect("Can't read file");
    let lines: Vec<&str> = text.split("\n").collect();

    let numbers: Vec<i32> = lines[0].trim().split(",")
                                    .collect::<Vec<&str>>()
                                    .into_iter()
                                    .map(|x| x.parse::<i32>().unwrap())
                                    .collect();

    let mut cartones: Vec<Carton> = vec![];

    let mut carton: Carton = Carton::default();
    for l in lines[2..].into_iter() {
        if l.trim() == "" {
            cartones.push(carton);
            carton = Carton::default();
        } else {
            carton.push(l.trim().split_whitespace().collect::<Vec<&str>>().into_iter().map(|x| x.parse::<i32>().unwrap()).collect());
        }
    }

    Bingo {
        numbers,
        cartones
    }
}

fn main() {
    let mut bingo: Bingo = parse_file();
    if let Some((last, sum)) = bingo.play().pop() {
        println!("Last: {}\nSum carton: {}\nResult: {}", last, sum, last*sum);
    } else {
        println!("ERROR");
    }
}