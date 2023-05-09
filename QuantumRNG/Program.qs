namespace QuantumRNG {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;

    operation GenerateRandomBit() : Result {
        // Aloca um qubit
        use q = Qubit();
        // Coloca o qubit em superposição
        H(q);
        // Agora há 50% de chance do qubit estar no estado 1 ou 0
        // Mede-se o qubit
        return M(q);
    }

    // A operação SampleRandomNumberInRange recebe dois inteiros e retorna um inteiro
    operation SampleRandomNumberInRange(min : Int, max : Int) : Int {
        mutable output = 0; // declara a variável mutable, ou seja, poderá mudar durante o programa
        // repete esse laço até que output seja menor ou igual ao max e maior ou igual a min
        repeat {
            mutable bits = []; // declara um vetor com o nome bits, que mudará durante o programa
            // 1..BitSizeI(max) gera um intervalo de números inteiros de 1 até o tamanho em bits do parâmetro max, ou seja, até a quantidade de dígitos em bits do parâmetro max
            for idxBit in 1..BitSizeI(max) { // gera n bits aleatórios, onde n é o tamanho em bits do parâmetro max
                // incrementa o vetor bits com um bit gerado aleatoriamente pela função chamada GenerateRandomBit()
                set bits += [GenerateRandomBit()];
            }
            // ResultArrayAsInt converte a cadeia de caracteres de bits (tipo Result) em um inteiro positivo
            set output = ResultArrayAsInt(bits);
        } until (output <= max and output >= min);
        return output;
    }

    // O @EntryPoint indica que o código começa a executar a partir daqui
    @EntryPoint()
    operation SampleRandomNumber() : Int {
        let max = 50;
        let min = 10;
        Message($"Gerando um número aleatório entre {min} e {max}: ");
        return SampleRandomNumberInRange(min, max);
    }

}
