
const_time_des_round_wide_imm.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<des_round>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	%edi, %eax
               	movq	%rax, %rcx
               	andq	$0x11111111, %rcx       # imm = 0x11111111
               	movq	%rax, %rdx
               	shrq	%rdx
               	andq	$0x11111111, %rdx       # imm = 0x11111111
               	movq	%rax, %rdi
               	shrq	$0x2, %rdi
               	andq	$0x11111111, %rdi       # imm = 0x11111111
               	shrq	$0x3, %rax
               	andq	$0x11111111, %rax       # imm = 0x11111111
               	movq	%rcx, %r8
               	shlq	$0x4, %r8
               	negq	%rcx
               	addq	%r8, %rcx
               	movq	%rdx, %r8
               	shlq	$0x4, %r8
               	subq	%rdx, %r8
               	movq	%rdi, %rdx
               	shlq	$0x4, %rdx
               	movq	%rdx, %r9
               	subq	%rdi, %r9
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	subq	%rax, %rdx
               	movl	%edx, %ebx
               	movq	%rbx, %rax
               	shlq	$0x4, %rax
               	movq	%rbx, %rdx
               	shrq	$0x1c, %rdx
               	orq	%rdx, %rax
               	movl	%ecx, %ecx
               	movq	%rcx, %rdi
               	shrq	$0x4, %rdi
               	movq	%rcx, %rdx
               	shlq	$0x1c, %rdx
               	movq	%rdi, %r12
               	orq	%rdx, %r12
               	movl	(%rsi), %edx
               	xorq	%rdx, %rax
               	movl	0x4(%rsi), %edx
               	xorq	%rdx, %rcx
               	movl	0x8(%rsi), %edx
               	xorq	%r8, %rdx
               	movl	0xc(%rsi), %edi
               	xorq	%r9, %rdi
               	movl	0x10(%rsi), %r8d
               	xorq	%rbx, %r8
               	movl	0x14(%rsi), %esi
               	movq	%r12, %r10
               	xorq	%rsi, %r10
               	movq	%r10, 0x38(%rsp)
               	movl	$0xec7ac69c, %esi       # imm = 0xEC7AC69C
               	andq	%rax, %rsi
               	movl	$0xefa72c4d, %r9d       # imm = 0xEFA72C4D
               	xorq	%rsi, %r9
               	movq	%rax, %rsi
               	andq	$0x500fb821, %rsi       # imm = 0x500FB821
               	movl	$0xaeaaedff, %ebx       # imm = 0xAEAAEDFF
               	xorq	%rsi, %rbx
               	movq	%rax, %rsi
               	andq	$0x40efa809, %rsi       # imm = 0x40EFA809
               	movq	%rsi, %r12
               	xorq	$0x37396665, %r12       # imm = 0x37396665
               	movl	$0xa5ec0b28, %esi       # imm = 0xA5EC0B28
               	andq	%rax, %rsi
               	movq	%rsi, %r13
               	xorq	$0x68d7b833, %r13       # imm = 0x68D7B833
               	movq	%rax, %rsi
               	andq	$0x252cf820, %rsi       # imm = 0x252CF820
               	movl	$0xc9c755bb, %r14d      # imm = 0xC9C755BB
               	xorq	%rsi, %r14
               	movq	%rax, %rsi
               	andq	$0x40205801, %rsi       # imm = 0x40205801
               	movq	%rsi, %r15
               	xorq	$0x73fc3606, %r15       # imm = 0x73FC3606
               	movl	$0xe220f929, %esi       # imm = 0xE220F929
               	andq	%rax, %rsi
               	movl	$0xa2a0a918, %r10d      # imm = 0xA2A0A918
               	xorq	%rsi, %r10
               	movq	%r10, 0xe8(%rsp)
               	movq	%rax, %rsi
               	andq	$0x44a3f9e1, %rsi       # imm = 0x44A3F9E1
               	movl	$0x8222bd90, %r10d      # imm = 0x8222BD90
               	xorq	%rsi, %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	%rax, %rsi
               	andq	$0x794f104a, %rsi       # imm = 0x794F104A
               	movl	$0xd6b6ac77, %r10d      # imm = 0xD6B6AC77
               	xorq	%rsi, %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	%rax, %rsi
               	andq	$0x26f320b, %rsi        # imm = 0x26F320B
               	movq	%rsi, %r10
               	xorq	$0x3069300c, %r10       # imm = 0x3069300C
               	movq	%r10, 0xd0(%rsp)
               	movq	%rax, %rsi
               	andq	$0x7640b01a, %rsi       # imm = 0x7640B01A
               	movq	%rsi, %r10
               	xorq	$0x6ce0d5cc, %r10       # imm = 0x6CE0D5CC
               	movq	%r10, 0xc8(%rsp)
               	movq	%rax, %rsi
               	andq	$0x238f1572, %rsi       # imm = 0x238F1572
               	movq	%rsi, %r10
               	xorq	$0x59a9a22d, %r10       # imm = 0x59A9A22D
               	movq	%r10, 0xc0(%rsp)
               	movq	%rax, %rsi
               	andq	$0x7a63c083, %rsi       # imm = 0x7A63C083
               	movl	$0xac6d0bd4, %r10d      # imm = 0xAC6D0BD4
               	xorq	%rsi, %r10
               	movq	%r10, 0xb8(%rsp)
               	movq	%rax, %rsi
               	andq	$0x11cca000, %rsi       # imm = 0x11CCA000
               	movq	%rsi, %r10
               	xorq	$0x21c83200, %r10       # imm = 0x21C83200
               	movq	%r10, 0xb0(%rsp)
               	movq	%rax, %rsi
               	andq	$0x202f69aa, %rsi       # imm = 0x202F69AA
               	movl	$0xa0e62188, %r11d      # imm = 0xA0E62188
               	xorq	%r11, %rsi
               	movq	%rax, %r10
               	andq	$0x51b33be9, %r10       # imm = 0x51B33BE9
               	movq	%r10, 0xa8(%rsp)
               	movq	0xa8(%rsp), %r10
               	movl	$0xaf7d655a, %r11d      # imm = 0xAF7D655A
               	xorq	%r11, %r10
               	movq	%r10, 0xa8(%rsp)
               	movq	%rax, %r10
               	andq	$0x3b0fe8ae, %r10       # imm = 0x3B0FE8AE
               	movq	%r10, 0xa0(%rsp)
               	movq	0xa0(%rsp), %r10
               	movl	$0xf0168aa3, %r11d      # imm = 0xF0168AA3
               	xorq	%r11, %r10
               	movq	%r10, 0xa0(%rsp)
               	movl	$0x90bf8816, %r10d      # imm = 0x90BF8816
               	andq	%rax, %r10
               	movq	%r10, 0x98(%rsp)
               	movq	0x98(%rsp), %r10
               	movl	$0x90aa30c6, %r11d      # imm = 0x90AA30C6
               	xorq	%r11, %r10
               	movq	%r10, 0x98(%rsp)
               	movq	%rax, %r10
               	andq	$0x9e34f9b, %r10        # imm = 0x9E34F9B
               	movq	%r10, 0x90(%rsp)
               	movq	0x90(%rsp), %r10
               	xorq	$0x5ab2750a, %r10       # imm = 0x5AB2750A
               	movq	%r10, 0x90(%rsp)
               	movq	%rax, %r10
               	andq	$0x103be88, %r10        # imm = 0x103BE88
               	movq	%r10, 0x88(%rsp)
               	movq	0x88(%rsp), %r10
               	xorq	$0x5391be65, %r10       # imm = 0x5391BE65
               	movq	%r10, 0x88(%rsp)
               	movq	%rax, %r10
               	andq	$0x49ac8e25, %r10       # imm = 0x49AC8E25
               	movq	%r10, 0x80(%rsp)
               	movq	0x80(%rsp), %r10
               	movl	$0x93372baf, %r11d      # imm = 0x93372BAF
               	xorq	%r11, %r10
               	movq	%r10, 0x80(%rsp)
               	movl	$0x922c313d, %r10d      # imm = 0x922C313D
               	andq	%rax, %r10
               	movq	%r10, 0x78(%rsp)
               	movq	0x78(%rsp), %r10
               	movl	$0xf288210c, %r11d      # imm = 0xF288210C
               	xorq	%r11, %r10
               	movq	%r10, 0x78(%rsp)
               	movq	%rax, %r10
               	andq	$0x70ef31b0, %r10       # imm = 0x70EF31B0
               	movq	%r10, 0x70(%rsp)
               	movq	0x70(%rsp), %r10
               	movl	$0x920af5c0, %r11d      # imm = 0x920AF5C0
               	xorq	%r11, %r10
               	movq	%r10, 0x70(%rsp)
               	movq	%rax, %r10
               	andq	$0x6a707100, %r10       # imm = 0x6A707100
               	movq	%r10, 0x68(%rsp)
               	movq	0x68(%rsp), %r10
               	xorq	$0x63d312c0, %r10       # imm = 0x63D312C0
               	movq	%r10, 0x68(%rsp)
               	movl	$0xb97c9011, %r10d      # imm = 0xB97C9011
               	andq	%rax, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x60(%rsp), %r10
               	xorq	$0x537b3006, %r10       # imm = 0x537B3006
               	movq	%r10, 0x60(%rsp)
               	movl	$0xa320c959, %r10d      # imm = 0xA320C959
               	andq	%rax, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x58(%rsp), %r10
               	movl	$0xa2efb0a5, %r11d      # imm = 0xA2EFB0A5
               	xorq	%r11, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%rax, %r10
               	andq	$0x6ea0ab4a, %r10       # imm = 0x6EA0AB4A
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	movl	$0xbc8f96a5, %r11d      # imm = 0xBC8F96A5
               	xorq	%r11, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	%rax, %r10
               	andq	$0x6953ddf8, %r10       # imm = 0x6953DDF8
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	movl	$0xfad176a5, %r11d      # imm = 0xFAD176A5
               	xorq	%r11, %r10
               	movq	%r10, 0x48(%rsp)
               	movl	$0xf74f3e2b, %r10d      # imm = 0xF74F3E2B
               	andq	%rax, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	xorq	$0x665a14a3, %r10       # imm = 0x665A14A3
               	movq	%r10, 0x40(%rsp)
               	movl	$0xf0306cad, %r11d      # imm = 0xF0306CAD
               	andq	%r11, %rax
               	movl	$0xf2eff0cc, %r11d      # imm = 0xF2EFF0CC
               	xorq	%r11, %rax
               	andq	%rcx, %rbx
               	xorq	%rbx, %r9
               	movq	%rcx, %rbx
               	andq	%r13, %rbx
               	xorq	%r12, %rbx
               	movq	%rcx, %r12
               	andq	%r15, %r12
               	xorq	%r14, %r12
               	movq	%rcx, %r13
               	andq	0xe0(%rsp), %r13
               	movq	%r13, %r10
               	movq	0xe8(%rsp), %r13
               	xorq	%r10, %r13
               	movq	%rcx, %r14
               	andq	0xd0(%rsp), %r14
               	movq	%r14, %r10
               	movq	0xd8(%rsp), %r14
               	xorq	%r10, %r14
               	movq	%rcx, %r15
               	andq	0xc0(%rsp), %r15
               	movq	%r15, %r10
               	movq	0xc8(%rsp), %r15
               	xorq	%r10, %r15
               	movq	%rcx, %r10
               	andq	0xb0(%rsp), %r10
               	movq	%r10, 0xe8(%rsp)
               	movq	0xb8(%rsp), %r10
               	xorq	0xe8(%rsp), %r10
               	movq	%r10, 0xe8(%rsp)
               	movq	%rcx, %r10
               	andq	0xa0(%rsp), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0xa8(%rsp), %r10
               	xorq	0xe0(%rsp), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	%rcx, %r10
               	andq	0x90(%rsp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0x98(%rsp), %r10
               	xorq	0xd8(%rsp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	%rcx, %r10
               	andq	0x80(%rsp), %r10
               	movq	%r10, 0xd0(%rsp)
               	movq	0x88(%rsp), %r10
               	xorq	0xd0(%rsp), %r10
               	movq	%r10, 0xd0(%rsp)
               	movq	%rcx, %r10
               	andq	0x70(%rsp), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0x78(%rsp), %r10
               	xorq	0xc8(%rsp), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	%rcx, %r10
               	andq	0x60(%rsp), %r10
               	movq	%r10, 0xc0(%rsp)
               	movq	0x68(%rsp), %r10
               	xorq	0xc0(%rsp), %r10
               	movq	%r10, 0xc0(%rsp)
               	movq	%rcx, %r10
               	andq	0x50(%rsp), %r10
               	movq	%r10, 0xb8(%rsp)
               	movq	0x58(%rsp), %r10
               	xorq	0xb8(%rsp), %r10
               	movq	%r10, 0xb8(%rsp)
               	andq	0x40(%rsp), %rcx
               	movq	%rcx, %r10
               	movq	0x48(%rsp), %rcx
               	xorq	%r10, %rcx
               	andq	%rdx, %rbx
               	xorq	%rbx, %r9
               	movq	%rdx, %rbx
               	andq	%r13, %rbx
               	xorq	%r12, %rbx
               	movq	%rdx, %r12
               	andq	%r15, %r12
               	xorq	%r14, %r12
               	andq	%rdx, %rsi
               	movq	%rsi, %r10
               	movq	0xe8(%rsp), %rsi
               	xorq	%r10, %rsi
               	movq	%rdx, %r13
               	andq	0xd8(%rsp), %r13
               	movq	%r13, %r10
               	movq	0xe0(%rsp), %r13
               	xorq	%r10, %r13
               	movq	%rdx, %r14
               	andq	0xc8(%rsp), %r14
               	movq	%r14, %r10
               	movq	0xd0(%rsp), %r14
               	xorq	%r10, %r14
               	movq	%rdx, %r15
               	andq	0xb8(%rsp), %r15
               	movq	%r15, %r10
               	movq	0xc0(%rsp), %r15
               	xorq	%r10, %r15
               	andq	%rdx, %rax
               	xorq	%rcx, %rax
               	movq	%rdi, %rcx
               	andq	%rbx, %rcx
               	xorq	%r9, %rcx
               	movq	%rdi, %rdx
               	andq	%rsi, %rdx
               	xorq	%r12, %rdx
               	movq	%rdi, %rsi
               	andq	%r14, %rsi
               	xorq	%r13, %rsi
               	andq	%rdi, %rax
               	xorq	%r15, %rax
               	andq	%r8, %rdx
               	xorq	%rdx, %rcx
               	andq	%r8, %rax
               	xorq	%rsi, %rax
               	movq	%rax, %r10
               	movq	0x38(%rsp), %rax
               	andq	%r10, %rax
               	xorq	%rcx, %rax
               	movq	%rax, %rcx
               	andq	$0x4, %rcx
               	shlq	$0x3, %rcx
               	movq	%rax, %rdx
               	andq	$0x4000, %rdx           # imm = 0x4000
               	shlq	$0x4, %rdx
               	orq	%rcx, %rdx
               	movq	%rax, %rcx
               	andq	$0x12020120, %rcx       # imm = 0x12020120
               	movq	%rcx, %rsi
               	shlq	$0x5, %rsi
               	shrq	$0x1b, %rcx
               	orq	%rsi, %rcx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x100000, %rdx         # imm = 0x100000
               	shlq	$0x6, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x8000, %rdx           # imm = 0x8000
               	shlq	$0x9, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x4000000, %rdx        # imm = 0x4000000
               	shrq	$0x16, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x1, %rdx
               	shlq	$0xb, %rdx
               	orq	%rcx, %rdx
               	movq	%rax, %rcx
               	andq	$0x20000200, %rcx       # imm = 0x20000200
               	movq	%rcx, %rsi
               	shlq	$0xc, %rsi
               	shrq	$0x14, %rcx
               	orq	%rsi, %rcx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x200000, %rdx         # imm = 0x200000
               	shrq	$0x13, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x40, %rdx
               	shlq	$0xe, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10000, %rdx          # imm = 0x10000
               	shlq	$0xf, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x2, %rdx
               	shlq	$0x10, %rdx
               	orq	%rcx, %rdx
               	movq	%rax, %rcx
               	andq	$0x40801800, %rcx       # imm = 0x40801800
               	movq	%rcx, %rsi
               	shlq	$0x11, %rsi
               	shrq	$0xf, %rcx
               	orq	%rsi, %rcx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x80000, %rdx          # imm = 0x80000
               	shrq	$0xd, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	shlq	$0x15, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x1000000, %rdx        # imm = 0x1000000
               	shrq	$0xa, %rdx
               	orq	%rcx, %rdx
               	movl	$0x88000008, %ecx       # imm = 0x88000008
               	andq	%rax, %rcx
               	movq	%rcx, %rsi
               	shlq	$0x18, %rsi
               	shrq	$0x8, %rcx
               	orq	%rsi, %rcx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	andq	$0x480, %rdx            # imm = 0x480
               	shrq	$0x7, %rdx
               	orq	%rdx, %rcx
               	andq	$0x442000, %rax         # imm = 0x442000
               	shrq	$0x6, %rax
               	orq	%rcx, %rax
               	movl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movl	$0xa5a5a5a5, %edi       # imm = 0xA5A5A5A5
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0xd2f51ac0, %edi       # imm = 0xD2F51AC0
               	leaq	<rip>, %rsi
               	callq	<addr>
               	xorq	%rax, %rbx
               	movl	$0x3849cf1f, %edi       # imm = 0x3849CF1F
               	leaq	<rip>, %rsi
               	callq	<addr>
               	xorq	%rax, %rbx
               	movl	$0xbabbd1f2, %edi       # imm = 0xBABBD1F2
               	leaq	<rip>, %rsi
               	callq	<addr>
               	xorq	%rax, %rbx
               	movl	$0xe4108a9, %edi        # imm = 0xE4108A9
               	leaq	<rip>, %rsi
               	callq	<addr>
               	xorq	%rax, %rbx
               	movl	$0xb7b0b9f4, %edi       # imm = 0xB7B0B9F4
               	leaq	<rip>, %rsi
               	callq	<addr>
               	xorq	%rax, %rbx
               	movl	$0x23539cc3, %edi       # imm = 0x23539CC3
               	leaq	<rip>, %rsi
               	callq	<addr>
               	xorq	%rax, %rbx
               	movl	$0xa72e9b46, %edi       # imm = 0xA72E9B46
               	leaq	<rip>, %rsi
               	callq	<addr>
               	xorq	%rax, %rbx
               	movl	$0x7580b9ed, %edi       # imm = 0x7580B9ED
               	leaq	<rip>, %rsi
               	callq	<addr>
               	xorq	%rax, %rbx
               	movl	$0xa631d268, %edi       # imm = 0xA631D268
               	leaq	<rip>, %rsi
               	callq	<addr>
               	xorq	%rax, %rbx
               	movl	$0x12f412a7, %edi       # imm = 0x12F412A7
               	leaq	<rip>, %rsi
               	callq	<addr>
               	xorq	%rax, %rbx
               	movl	$0x44916fda, %edi       # imm = 0x44916FDA
               	leaq	<rip>, %rsi
               	callq	<addr>
               	xorq	%rax, %rbx
               	movl	$0x96ac7d71, %edi       # imm = 0x96AC7D71
               	leaq	<rip>, %rsi
               	callq	<addr>
               	xorq	%rax, %rbx
               	movl	$0xdd35581c, %edi       # imm = 0xDD35581C
               	leaq	<rip>, %rsi
               	callq	<addr>
               	xorq	%rax, %rbx
               	movl	$0x53fb94cb, %edi       # imm = 0x53FB94CB
               	leaq	<rip>, %rsi
               	callq	<addr>
               	xorq	%rax, %rbx
               	movl	$0x455163ae, %edi       # imm = 0x455163AE
               	leaq	<rip>, %rsi
               	callq	<addr>
               	xorq	%rbx, %rax
               	movl	%eax, %eax
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	xorq	%rax, %rcx
               	movq	%rax, %rdx
               	shrq	$0x10, %rdx
               	xorq	%rdx, %rcx
               	shrq	$0x18, %rax
               	xorq	%rcx, %rax
               	andq	$0xff, %rax
               	popq	%rbx
               	leave
               	retq
