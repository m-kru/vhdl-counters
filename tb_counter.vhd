library work;
   use work.counters.all;

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
      constant WIDTH : integer := 8;
      variable c : counter_t;
   begin
      c := init_width(WIDTH);
      assert c.min = 0;
      assert c.val = 0;
      assert c.max = 255;
      c := init_width(WIDTH, true);
      assert c.min = 0;
      assert c.val = 255;
      assert c.max = 255;
      wait;
   end process;


   test_equal : process is
      constant MAX : integer := 1023;
      variable c : counter_t := init(MAX);
   begin
      assert equal(c, 0);
      c := inc(c);
      assert equal(c, 1);
      c := inc(c, 1000);
      assert equal(c, 1001);
      wait;
   end process;


   test_is_zero : process is
      constant MAX : integer := 1023;
      variable c : counter_t := init(MAX);
   begin
      assert is_zero(c);
      c := inc(c);
      assert not is_zero(c);
      wait;
   end process;


   test_is_min : process is
      constant MAX : integer := 1023;
      constant VAL : integer := 1023;
      constant MIN : integer := 1023;
      variable c : counter_t := init(MAX, VAL, MIN);
   begin
      assert is_min(c);
      c := inc(c);
      assert not is_min(c);
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


   test_inc : process is
      constant MAX : integer := 15;
      variable c : counter_t := init(MAX);
   begin
      c := inc(c);
      assert equal(c, 1);
      c := inc(c, 4);
      assert equal(c, 5);
      c := inc(c, 12);
      assert equal(c, 1);
      c := inc(c, 32);
      assert equal(c, 1);
      c := inc(c, 15);
      assert equal(c, 0);
      wait;
   end process;


   test_inc_if : process is
      constant MAX : integer := 15;
      variable c : counter_t := init(MAX);
   begin
      c := inc_if(c, true, 3);
      assert equal(c, 3);
      c := inc_if(c, false);
      assert equal(c, 3);
      c := inc_if(c, false, 3);
      assert equal(c, 3);
      wait;
   end process;


   test_rst_min : process is
      constant MAX : integer := 15;
      constant MIN : integer := 7;
      variable c : counter_t := init(MAX, MIN, MIN);
   begin
      assert is_min(c);
      c := inc(c);
      assert not is_min(c);
      c := rst_min(c);
      assert is_min(c);
      wait;
   end process;


   test_rst_min_if : process is
      constant MAX : integer := 15;
      constant MIN : integer := 7;
      variable c : counter_t := init(MAX, MAX, MIN);
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
      constant MAX : integer := 15;
      constant MIN : integer := 7;
      variable c : counter_t := init(MAX, MAX, MIN);
   begin
      assert is_max(c);
      c := inc(c);
      assert not is_max(c);
      c := rst_max(c);
      assert is_max(c);
      wait;
   end process;


   test_rst_max_if : process is
      constant MAX : integer := 15;
      constant MIN : integer := 7;
      variable c : counter_t := init(MAX, MIN, MIN);
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
      assert is_zero(c);
      c := set(c, MIN);
      assert is_min(c);
      c := set(c, MAX);
      assert is_max(c);
      c := set(c, 3);
      assert equal(c, 3);
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
