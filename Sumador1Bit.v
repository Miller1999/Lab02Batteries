module Sumador1Bit (
    input A,
    input B,
    input Cin,
    output S,
    output Cout
);

    wire x_ab;
    wire cout_t;
    wire a_ab;
    
    xor(x_ab,A, B);
    and(cout_t,x_ab, Cin);
    and(a_ab,A, B);
    xor(S,x_ab,Cin);
    or(Cout,cout_t,a_ab);

endmodule

