PGDMP      )                |            berthdb1    15.9 (Debian 15.9-1.pgdg120+1)    17.0 0    L           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            M           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            N           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            O           1262    32885    berthdb1    DATABASE     s   CREATE DATABASE berthdb1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';
    DROP DATABASE berthdb1;
                     admin    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                     pg_database_owner    false            P           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                        pg_database_owner    false    4            �            1255    32914    generate_id_admin()    FUNCTION     �   CREATE FUNCTION public.generate_id_admin() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    new_id VARCHAR(10);
BEGIN
    new_id := 'admin-' || LPAD(NEXTVAL('admin_seq')::TEXT, 3, '0');
    NEW.id_admin := new_id;
    RETURN NEW;
END;
$$;
 *   DROP FUNCTION public.generate_id_admin();
       public               admin    false    4            �            1255    32934    generate_id_kapal()    FUNCTION       CREATE FUNCTION public.generate_id_kapal() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    declare
        new_id varchar(10);
    begin
        new_id := 'kpl-' || lpad(nextval('kapal_seq')::text, 3,'0');
        new.id_kapal := new_id;
        return new;
    end;
    $$;
 *   DROP FUNCTION public.generate_id_kapal();
       public               admin    false    4            �            1255    32900    generate_id_pelanggan()    FUNCTION       CREATE FUNCTION public.generate_id_pelanggan() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    new_id VARCHAR(10);
BEGIN
    new_id := 'CUS-' || LPAD(NEXTVAL('pelanggan_seq')::TEXT, 3, '0');
    NEW.id_pelanggan := new_id;
    RETURN NEW;
END;
$$;
 .   DROP FUNCTION public.generate_id_pelanggan();
       public               admin    false    4            �            1259    32906    admin    TABLE     �   CREATE TABLE public.admin (
    id_admin character varying(20) NOT NULL,
    nama_admin character varying(50) NOT NULL,
    username character varying(100) NOT NULL,
    password character varying(100),
    phone_number character varying(20) NOT NULL
);
    DROP TABLE public.admin;
       public         heap r       admin    false    4            �            1259    32913 	   admin_seq    SEQUENCE     r   CREATE SEQUENCE public.admin_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
     DROP SEQUENCE public.admin_seq;
       public               admin    false    4            �            1259    32928    kapal    TABLE     �   CREATE TABLE public.kapal (
    id_kapal character varying(20) NOT NULL,
    nama_kapal character varying(30) NOT NULL,
    tujuan character varying(20) NOT NULL,
    kapasitas character varying(10) NOT NULL
);
    DROP TABLE public.kapal;
       public         heap r       admin    false    4            �            1259    32933 	   kapal_seq    SEQUENCE     r   CREATE SEQUENCE public.kapal_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
     DROP SEQUENCE public.kapal_seq;
       public               admin    false    4            �            1259    32922    kelas    TABLE     �   CREATE TABLE public.kelas (
    id_kelas integer NOT NULL,
    jenis_kelas character varying(20) NOT NULL,
    cabin character varying(50) NOT NULL
);
    DROP TABLE public.kelas;
       public         heap r       admin    false    4            �            1259    32921    kelas_id_kelas_seq    SEQUENCE     �   CREATE SEQUENCE public.kelas_id_kelas_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.kelas_id_kelas_seq;
       public               admin    false    4    219            Q           0    0    kelas_id_kelas_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.kelas_id_kelas_seq OWNED BY public.kelas.id_kelas;
          public               admin    false    218            �            1259    32936 	   kelas_seq    SEQUENCE     r   CREATE SEQUENCE public.kelas_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
     DROP SEQUENCE public.kelas_seq;
       public               admin    false    4            �            1259    32886 	   pelanggan    TABLE     <  CREATE TABLE public.pelanggan (
    id_pelanggan character varying(10) NOT NULL,
    phone_number character varying(15) NOT NULL,
    username character varying(50) NOT NULL,
    password text NOT NULL,
    status smallint DEFAULT 0,
    fullname character varying(30) NOT NULL,
    birthdate date NOT NULL,
    email character varying(100),
    nik character varying(50) NOT NULL,
    CONSTRAINT email_check CHECK (((email)::text ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'::text)),
    CONSTRAINT pelanggan_status_check CHECK ((status = ANY (ARRAY[0, 1])))
);
    DROP TABLE public.pelanggan;
       public         heap r       admin    false    4            �            1259    32899    pelanggan_seq    SEQUENCE     v   CREATE SEQUENCE public.pelanggan_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.pelanggan_seq;
       public               admin    false    4            �            1259    41136    schedule    TABLE       CREATE TABLE public.schedule (
    id_schedule integer NOT NULL,
    day character varying(10) NOT NULL,
    dep_time time without time zone NOT NULL,
    arr_time time without time zone NOT NULL,
    id_kapal character varying(10) NOT NULL,
    id_kelas integer NOT NULL
);
    DROP TABLE public.schedule;
       public         heap r       admin    false    4            �            1259    41135    schedule_id_schedule_seq    SEQUENCE     �   CREATE SEQUENCE public.schedule_id_schedule_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.schedule_id_schedule_seq;
       public               admin    false    4    224            R           0    0    schedule_id_schedule_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.schedule_id_schedule_seq OWNED BY public.schedule.id_schedule;
          public               admin    false    223            �           2604    32925    kelas id_kelas    DEFAULT     p   ALTER TABLE ONLY public.kelas ALTER COLUMN id_kelas SET DEFAULT nextval('public.kelas_id_kelas_seq'::regclass);
 =   ALTER TABLE public.kelas ALTER COLUMN id_kelas DROP DEFAULT;
       public               admin    false    218    219    219            �           2604    41139    schedule id_schedule    DEFAULT     |   ALTER TABLE ONLY public.schedule ALTER COLUMN id_schedule SET DEFAULT nextval('public.schedule_id_schedule_seq'::regclass);
 C   ALTER TABLE public.schedule ALTER COLUMN id_schedule DROP DEFAULT;
       public               admin    false    224    223    224            A          0    32906    admin 
   TABLE DATA           W   COPY public.admin (id_admin, nama_admin, username, password, phone_number) FROM stdin;
    public               admin    false    216   A9       E          0    32928    kapal 
   TABLE DATA           H   COPY public.kapal (id_kapal, nama_kapal, tujuan, kapasitas) FROM stdin;
    public               admin    false    220   �9       D          0    32922    kelas 
   TABLE DATA           =   COPY public.kelas (id_kelas, jenis_kelas, cabin) FROM stdin;
    public               admin    false    219   �:       ?          0    32886 	   pelanggan 
   TABLE DATA           |   COPY public.pelanggan (id_pelanggan, phone_number, username, password, status, fullname, birthdate, email, nik) FROM stdin;
    public               admin    false    214   �:       I          0    41136    schedule 
   TABLE DATA           \   COPY public.schedule (id_schedule, day, dep_time, arr_time, id_kapal, id_kelas) FROM stdin;
    public               admin    false    224   :>       S           0    0 	   admin_seq    SEQUENCE SET     7   SELECT pg_catalog.setval('public.admin_seq', 1, true);
          public               admin    false    217            T           0    0 	   kapal_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('public.kapal_seq', 28, true);
          public               admin    false    221            U           0    0    kelas_id_kelas_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.kelas_id_kelas_seq', 3, true);
          public               admin    false    218            V           0    0 	   kelas_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('public.kelas_seq', 1, false);
          public               admin    false    222            W           0    0    pelanggan_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.pelanggan_seq', 27, true);
          public               admin    false    215            X           0    0    schedule_id_schedule_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.schedule_id_schedule_seq', 24, true);
          public               admin    false    223            �           2606    32910    admin admin_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (id_admin);
 :   ALTER TABLE ONLY public.admin DROP CONSTRAINT admin_pkey;
       public                 admin    false    216            �           2606    32912    admin admin_username_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_username_key UNIQUE (username);
 B   ALTER TABLE ONLY public.admin DROP CONSTRAINT admin_username_key;
       public                 admin    false    216            �           2606    32904    pelanggan email_unique 
   CONSTRAINT     R   ALTER TABLE ONLY public.pelanggan
    ADD CONSTRAINT email_unique UNIQUE (email);
 @   ALTER TABLE ONLY public.pelanggan DROP CONSTRAINT email_unique;
       public                 admin    false    214            �           2606    32932    kapal kapal_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.kapal
    ADD CONSTRAINT kapal_pkey PRIMARY KEY (id_kapal);
 :   ALTER TABLE ONLY public.kapal DROP CONSTRAINT kapal_pkey;
       public                 admin    false    220            �           2606    32927    kelas kelas_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.kelas
    ADD CONSTRAINT kelas_pkey PRIMARY KEY (id_kelas);
 :   ALTER TABLE ONLY public.kelas DROP CONSTRAINT kelas_pkey;
       public                 admin    false    219            �           2606    32894    pelanggan pelanggan_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.pelanggan
    ADD CONSTRAINT pelanggan_pkey PRIMARY KEY (id_pelanggan);
 B   ALTER TABLE ONLY public.pelanggan DROP CONSTRAINT pelanggan_pkey;
       public                 admin    false    214            �           2606    32898     pelanggan pelanggan_username_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.pelanggan
    ADD CONSTRAINT pelanggan_username_key UNIQUE (username);
 J   ALTER TABLE ONLY public.pelanggan DROP CONSTRAINT pelanggan_username_key;
       public                 admin    false    214            �           2606    41141    schedule schedule_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_pkey PRIMARY KEY (id_schedule);
 @   ALTER TABLE ONLY public.schedule DROP CONSTRAINT schedule_pkey;
       public                 admin    false    224            �           2620    32915    admin admin_id_trigger    TRIGGER     �   CREATE TRIGGER admin_id_trigger BEFORE INSERT ON public.admin FOR EACH ROW WHEN ((new.id_admin IS NULL)) EXECUTE FUNCTION public.generate_id_admin();
 /   DROP TRIGGER admin_id_trigger ON public.admin;
       public               admin    false    216    216    226            �           2620    32935    kapal kapal_id_trigger    TRIGGER     �   CREATE TRIGGER kapal_id_trigger BEFORE INSERT ON public.kapal FOR EACH ROW WHEN ((new.id_kapal IS NULL)) EXECUTE FUNCTION public.generate_id_kapal();
 /   DROP TRIGGER kapal_id_trigger ON public.kapal;
       public               admin    false    227    220    220            �           2620    32901    pelanggan pelanggan_id_trigger    TRIGGER     �   CREATE TRIGGER pelanggan_id_trigger BEFORE INSERT ON public.pelanggan FOR EACH ROW WHEN ((new.id_pelanggan IS NULL)) EXECUTE FUNCTION public.generate_id_pelanggan();
 7   DROP TRIGGER pelanggan_id_trigger ON public.pelanggan;
       public               admin    false    214    214    225            �           2606    49330    schedule fk_kapal    FK CONSTRAINT     �   ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT fk_kapal FOREIGN KEY (id_kapal) REFERENCES public.kapal(id_kapal) ON UPDATE CASCADE;
 ;   ALTER TABLE ONLY public.schedule DROP CONSTRAINT fk_kapal;
       public               admin    false    224    220    3241            �           2606    41147    schedule fk_kelas    FK CONSTRAINT     w   ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT fk_kelas FOREIGN KEY (id_kelas) REFERENCES public.kelas(id_kelas);
 ;   ALTER TABLE ONLY public.schedule DROP CONSTRAINT fk_kelas;
       public               admin    false    3239    224    219            A   3   x�KL����500�LJ,��/ʇцFƜ� ICN �����+F��� ��      E   �   x�]�AN�0EדS��8i�]$�D��ذ�`�1��jb����H�ߟ?o�?gE!��JvFIP+�ݓ(�"�O��:H���[�j�[V��I�R���|��P�S�HxE�0�Ƿ�g7��i��a�;+�-��bpq��5:�����g~�˯�3�0LW���o���s��E�D��8�]�p���[EAM㮨C���ъD����	����W��nɔ���A� CL,/�����b��<˲��z      D   6   x�3�L�������t4�2�L�,��,�t4�2�t�,*.Qp�I,
s��qqq A��      ?   \  x�m��n�6���O� AR�]�����a'�M��d�ѮV�6�����Lذ��}+�s��O���p��T��_2u��N�#Sk��J8��v������ʩNt��i:v���D�R��BK!8��[�P�2/ʪV�3��b����%\hY��гϮ@���T���v��y��?�!L�/[k�Ō�y9��W�g�^��\Rɝ�y��I��!N��v�kC�-Jٟ��"�SXC��FP�LSDH�	����y6Z�(�d7�`G�S�T�����J�,�H"�f��jN>ȿ����x>r�v���L��V�';̶�1$��bvg`s�T�1�B�^֣��4�Iy����J@zbv�-�E����R:3�v=b�iV�jқ�����;P�w�<ZǂS�%�����Ҩ*D)b����nY�lC�Գ|Ah�)��ro`�#�4���|;��
�YE�-�ك����8�Ìn6;9i�d��9$����1��}/f���!"D���\o�I�����i`�`'�_��绦r�xi�}�fSȓ<�Ir���ؚ-dJ@�dH-�wY��l�u�D��/)BNN�mގM��F����tZ�s3tǨ"��!� ��6	K�^�����`1C\�I�	���^:b`��!���n͢tȺG1{�Vw�T仝-��$�y��{��κ
� Þ=A�[\%F2�aۜ��$�i5Y�
�~���q"?B!�q�Ȑ��?��$�
i��f��m����G�gw��C�� ��	�w�~��H�D�!R�m9����ў�x��x@������g�?���������A���̽G7����S���T×��>ˇ���p�+��\      I   �   x�}��j�0���̻4�Y���몁l�	$����^��;�-A4��A���{<��H�g{������$
�	!$�HI9�(�)
�$��I�C����ZFi��}�]U�����MU�:��_U����0��r���$��83�@ӹ7b ��J�0���iqǱy��ɥ7,b!�u��қ�L~e\*���g��!sա�*��V���w���el�\zkk(�����������c��9��     