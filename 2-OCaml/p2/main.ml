let split_on_2 str = let i = String.index str ' ' in 
                        (String.sub str 0 i, String.sub str (i+1) ((String.length str)-i-1));;

let read_until_end ic = 
    let rec aux acc = try
        let (s, n) = input_line ic
                |> split_on_2 in
        aux ((s, int_of_string n)::acc)
    with
        _ -> close_in_noerr ic; List.rev acc
    in aux [];;

let process_list l = let rec aux x y aim = function
    | ("forward", n)::t -> aux (x+n) (y+n*aim) aim t
    | ("down", n)::t -> aux x y (aim+n) t
    | ("up", n)::t -> aux x y (aim-n) t
    | [] -> (x, y)
    | _ -> raise (Failure "Unreacheable") in
    aux 0 0 0 l;;

let print_result (x, y) = Printf.printf "X = %d; Y = %d; result = %d\n" x y (x*y);;

let _ =
    open_in "input.txt"
    |> read_until_end
    |> process_list
    |> print_result;;