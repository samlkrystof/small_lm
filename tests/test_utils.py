from src.models.gpt2.config import GPT2Config
from src.models.gpt2.model import Block
from src.utils import make_copies


def test_make_copies():
    d_model = 128
    num_heads = 8
    activation = 'gelu'
    hidden_dim = d_model * 4
    num_copies = 5
    config = GPT2Config(d_model=d_model, num_heads=num_heads, hidden_dim=hidden_dim)

    block = Block(config)

    copies = make_copies(block, num_copies)

    assert len(copies) == num_copies

    block.d_model = 1234
    for i in range(num_copies):
        assert copies[i].d_model != block.d_model
