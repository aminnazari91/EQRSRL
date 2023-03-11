function Receiver=findReceiver(Model,Sender,D)

    Receiver = find(D(:, Sender) ~= inf)';
    Receiver(Receiver == Sender) = [];
    Receiver(Receiver < Model.n*Model.m) = [];
end
