library counters;
  use counters.counters.all;

entity tb_counter is
end entity;

architecture test of tb_counter is
begin

  test_init : process is
    constant MIN : integer := -7;
    constant MAX : integer := 8917;
    constant VAL : integer := 147;
    variable c : counter_t;
  begin
    c := init(MAX);
    assert c.min = 0;
    assert c.val = 0;
    assert c.max = MAX;
    c := init(MAX, VAL);
    assert c.min = 0;
    assert c.val = VAL;
    assert c.max = MAX;
    c := init(MAX, VAL, MIN);
    assert c.min = MIN;
    assert c.val = VAL;
    assert c.max = MAX;
    wait;
  end process;


  test_init_width : process is
    variable c : counter_t;
  begin
    c := init_width(8);
    assert c.min = 0;
    assert c.val = 0;
    assert c.max = 255;
    c := init_width(8, true);
    assert c.min = 0;
    assert c.val = 255;
    assert c.max = 255;
    wait;
  end process;


  test_equal_integer : process is
    variable c : counter_t := init(1001);
  begin
    assert c = 0;
    c := inc(c);
    assert c = 1;
    c := inc(c, 1000);
    assert c = 1001;
    wait;
  end process;


  test_inequal_integer : process is
    variable c : counter_t := init(10);
  begin
    assert c /= 1;
    c := inc(c);
    assert c /= 0;
    wait;
  end process;


  test_less_than_integer : process is
    variable c : counter_t := init(10);
  begin
    assert c < 1;
    c := inc(c);
    assert c < 2;
    wait;
  end process;


  test_less_than_equal_integer : process is
    variable c : counter_t := init(10);
  begin
    assert c <= 0;
    c := inc(c);
    assert c <= 2;
    wait;
  end process;


  test_greater_than_integer : process is
    variable c : counter_t := init(10);
  begin
    assert c > -1;
    c := inc(c);
    assert c > 0;
    wait;
  end process;


  test_greater_than_equal_integer : process is
    variable c : counter_t := init(10);
  begin
    assert c >= 0;
    c := inc(c);
    assert c >= 0;
    wait;
  end process;


  test_equal_counter : process is
    variable c1 : counter_t := init(6);
    variable c2 : counter_t := init(17);
  begin
    assert c1 = c2;
    c1 := inc(c1);
    c2 := inc(c2);
    assert c1 = c2;
    wait;
  end process;


  test_inequal_counter : process is
    variable c1 : counter_t := init(10);
    variable c2 : counter_t := init(20);
  begin
    c1 := inc(c1);
    assert c1 /= c2;
    wait;
  end process;


  test_less_than_counter : process is
    variable c1 : counter_t := init(10);
    variable c2 : counter_t := init(10);
  begin
    c2 := inc(c2);
    assert c1 < c2;
    wait;
  end process;


  test_less_than_equal_counter : process is
    variable c1 : counter_t := init(5);
    variable c2 : counter_t := init(5);
  begin
    assert c1 <= c2;
    c2 := inc(c2);
    assert c1 <= c2;
    wait;
  end process;


  test_greater_than_counter : process is
    variable c1 : counter_t := init(10);
    variable c2 : counter_t := init(10);
  begin
    c1 := inc(c1);
    assert c1 > c2;
    wait;
  end process;


  test_greater_than_equal_counter : process is
    variable c1 : counter_t := init(10);
    variable c2 : counter_t := init(10);
  begin
    assert c1 >= c2;
    c1 := inc(c1);
    assert c1 > c2;
    wait;
  end process;


  test_is_min : process is
    variable c : counter_t := init(1023, 1023, 1023);
  begin
    assert is_min(c);
    c := inc(c);
    assert is_min(c);
    wait;
  end process;


  test_is_max : process is
    constant MAX : integer := 1023;
    variable c : counter_t := init(MAX);
  begin
    assert not is_max(c);
    c := inc(c, MAX);
    assert is_max(c);
    wait;
  end process;


  test_dec : process is
    variable c : counter_t := init(15);
  begin
    c := dec(c);
    assert c = 15;
    c := dec(c, 5);
    assert c = 10;
    c := dec(c, 16);
    assert c = 10;
    c := dec(c);
    assert c = 9;
    c := dec(c, 17);
    assert c = 8;
    wait;
  end process;


  test_dec_positive_max_negative_min : process is
    variable c : counter_t := init(15, 0, -16);
  begin
    c := dec(c);
    assert c = -1;
    c := dec(c, 10);
    assert c = -11;
    c := dec(c, 32);
    assert c = -11;
    c := dec(c, 5);
    assert c = -16;
    c := dec(c);
    assert c = 15;
    wait;
  end process;


  test_dec_max_and_min_negative : process is
    variable c : counter_t := init(-10, -15, -20);
  begin
    c := dec(c);
    assert c = -16;
    c := dec(c, 4);
    assert c = -20;
    c := dec(c);
    assert c = -10;
    c := dec(c, 11);
    assert c = -10;
    wait;
  end process;


  test_dec_if : process is
    variable c : counter_t := init(15);
  begin
    c := dec_if(c, true, 3);
    assert c = 13;
    c := dec_if(c, false);
    assert c = 13;
    c := dec_if(c, true);
    assert c = 12;
    wait;
  end process;


  test_inc : process is
    variable c : counter_t := init(15);
  begin
    c := inc(c);
    assert c = 1;
    c := inc(c, 4);
    assert c = 5;
    c := inc(c, 12);
    assert c = 1;
    c := inc(c, 32);
    assert c = 1;
    c := inc(c, 15);
    assert c = 0;
    wait;
  end process;


  test_inc_positive_max_negative_min : process is
    variable c : counter_t := init(15, 0, -16);
  begin
    c := inc(c);
    assert c = 1;
    c := inc(c, 4);
    assert c = 5;
    c := inc(c, 12);
    assert c = -15;
    c := inc(c, 1);
    assert c = -14;
    c := inc(c, 14);
    assert c = 0;
    wait;
  end process;


  test_inc_if : process is
    variable c : counter_t := init(15);
  begin
    c := inc_if(c, true, 3);
    assert c = 3;
    c := inc_if(c, false);
    assert c = 3;
    c := inc_if(c, true);
    assert c = 4;
    wait;
  end process;


  test_rst_min : process is
    variable c : counter_t := init(15, 7, 7);
  begin
    assert is_min(c);
    c := inc(c);
    assert not is_min(c);
    c := rst_min(c);
    assert is_min(c);
    wait;
  end process;


  test_rst_min_if : process is
    variable c : counter_t := init(15, 15, 7);
  begin
    assert not is_min(c);
    c := rst_min_if(c, true);
    assert is_min(c);
    c := inc(c);
    assert not is_min(c);
    c := rst_min_if(c, true);
    assert is_min(c);
    wait;
  end process;


  test_rst_max : process is
    variable c : counter_t := init(15, 15, 7);
  begin
    assert is_max(c);
    c := inc(c);
    assert not is_max(c);
    c := rst_max(c);
    assert is_max(c);
    wait;
  end process;


  test_rst_max_if : process is
    variable c : counter_t := init(15, 7, 7);
  begin
    assert not is_max(c);
    c := rst_max_if(c, true);
    assert is_max(c);
    c := inc(c);
    assert not is_max(c);
    c := rst_max_if(c, true);
    assert is_max(c);
    wait;
  end process;

  test_set : process is
    constant MAX : integer := 15;
    constant MIN : integer := -15;
    variable c : counter_t := init(MAX, MIN, MIN);
  begin
    c := set(c, 0);
    assert c = 0;
    c := set(c, MIN);
    assert is_min(c);
    c := set(c, MAX);
    assert is_max(c);
    c := set(c, 3);
    assert c = 3;
    wait;
  end process;


  test_set_if : process is
    variable c : counter_t := init(8);
  begin
    c := set_if(c, 5, false);
    assert c = 0;
    c := set_if(c, 5, true);
    assert c = 5;
    c := set_if(c, 8, true);
    assert c = 8;
    wait;
  end process;


  test_to_strig : process is
    variable c1 : counter_t := init(255);
    variable c2 : counter_t := init(1023, 151, -127);
  begin
    report to_string(c1);
    report to_string(c2);
    wait;
  end process;

end architecture;
