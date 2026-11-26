
const_time_des_round_wide_imm.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x18, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movl	%edi, %r8d
               	movq	%r8, %rax
               	andq	$0x11111111, %rax       # imm = 0x11111111
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	subq	%rax, %rdx
               	movq	%r8, %rax
               	shrq	$0x3, %rax
               	andq	$0x11111111, %rax       # imm = 0x11111111
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	subq	%rax, %rcx
               	movl	%ecx, %r10d
               	rorxl	$0x1c, %r10d, %eax
               	movl	(%rsi), %ecx
               	xorq	%rcx, %rax
               	movl	$0xec7ac69c, %ecx       # imm = 0xEC7AC69C
               	andq	%rax, %rcx
               	movl	$0xefa72c4d, %r9d       # imm = 0xEFA72C4D
               	xorq	%r9, %rcx
               	movl	%edx, %r11d
               	movl	0x4(%rsi), %edx
               	xorq	%r11, %rdx
               	movq	%rax, %rdi
               	andq	$0x500fb821, %rdi       # imm = 0x500FB821
               	movq	%r10, 0x10(%rsp)
               	movl	$0xaeaaedff, %r10d      # imm = 0xAEAAEDFF
               	xorq	%r10, %rdi
               	andq	%rdx, %rdi
               	xorq	%rdi, %rcx
               	movq	0x10(%rsp), %r10
               	movq	%r8, %r9
               	shrq	%r9
               	andq	$0x11111111, %r9        # imm = 0x11111111
               	movq	%r9, %rdi
               	shlq	$0x4, %rdi
               	subq	%r9, %rdi
               	movl	0x8(%rsi), %r9d
               	xorq	%r9, %rdi
               	movq	%rax, %r9
               	andq	$0x40efa809, %r9        # imm = 0x40EFA809
               	xorq	$0x37396665, %r9        # imm = 0x37396665
               	movl	$0xa5ec0b28, %ebx       # imm = 0xA5EC0B28
               	andq	%rax, %rbx
               	xorq	$0x68d7b833, %rbx       # imm = 0x68D7B833
               	andq	%rdx, %rbx
               	xorq	%rbx, %r9
               	andq	%rdi, %r9
               	xorq	%r9, %rcx
               	shrq	$0x2, %r8
               	andq	$0x11111111, %r8        # imm = 0x11111111
               	movq	%r8, %r9
               	shlq	$0x4, %r9
               	subq	%r8, %r9
               	movl	0xc(%rsi), %r8d
               	xorq	%r8, %r9
               	movq	%rax, %r8
               	andq	$0x252cf820, %r8        # imm = 0x252CF820
               	movq	%r11, 0x10(%rsp)
               	movl	$0xc9c755bb, %r11d      # imm = 0xC9C755BB
               	xorq	%r11, %r8
               	movq	%rax, %rbx
               	andq	$0x40205801, %rbx       # imm = 0x40205801
               	xorq	$0x73fc3606, %rbx       # imm = 0x73FC3606
               	andq	%rdx, %rbx
               	xorq	%rbx, %r8
               	movl	$0xe220f929, %ebx       # imm = 0xE220F929
               	andq	%rax, %rbx
               	movl	$0xa2a0a918, %r11d      # imm = 0xA2A0A918
               	xorq	%r11, %rbx
               	movq	%rax, %r12
               	andq	$0x44a3f9e1, %r12       # imm = 0x44A3F9E1
               	movl	$0x8222bd90, %r11d      # imm = 0x8222BD90
               	xorq	%r11, %r12
               	andq	%rdx, %r12
               	xorq	%r12, %rbx
               	andq	%rdi, %rbx
               	xorq	%rbx, %r8
               	andq	%r9, %r8
               	xorq	%r8, %rcx
               	movl	0x10(%rsi), %r8d
               	movq	0x10(%rsp), %r11
               	xorq	%r8, %r10
               	movq	%rax, %r8
               	andq	$0x794f104a, %r8        # imm = 0x794F104A
               	movq	%r11, 0x10(%rsp)
               	movl	$0xd6b6ac77, %r11d      # imm = 0xD6B6AC77
               	xorq	%r11, %r8
               	movq	%rax, %rbx
               	andq	$0x26f320b, %rbx        # imm = 0x26F320B
               	xorq	$0x3069300c, %rbx       # imm = 0x3069300C
               	andq	%rdx, %rbx
               	xorq	%rbx, %r8
               	movq	%rax, %rbx
               	andq	$0x7640b01a, %rbx       # imm = 0x7640B01A
               	xorq	$0x6ce0d5cc, %rbx       # imm = 0x6CE0D5CC
               	movq	%rax, %r12
               	andq	$0x238f1572, %r12       # imm = 0x238F1572
               	xorq	$0x59a9a22d, %r12       # imm = 0x59A9A22D
               	andq	%rdx, %r12
               	xorq	%r12, %rbx
               	andq	%rdi, %rbx
               	xorq	%rbx, %r8
               	movq	%rax, %rbx
               	andq	$0x7a63c083, %rbx       # imm = 0x7A63C083
               	movl	$0xac6d0bd4, %r11d      # imm = 0xAC6D0BD4
               	xorq	%r11, %rbx
               	movq	%rax, %r12
               	andq	$0x11cca000, %r12       # imm = 0x11CCA000
               	xorq	$0x21c83200, %r12       # imm = 0x21C83200
               	andq	%rdx, %r12
               	xorq	%r12, %rbx
               	movq	%rax, %r12
               	andq	$0x202f69aa, %r12       # imm = 0x202F69AA
               	movl	$0xa0e62188, %r11d      # imm = 0xA0E62188
               	xorq	%r11, %r12
               	andq	%rdi, %r12
               	xorq	%r12, %rbx
               	andq	%r9, %rbx
               	xorq	%rbx, %r8
               	movq	0x10(%rsp), %r11
               	andq	%r10, %r8
               	xorq	%r8, %rcx
               	rorl	$0x4, %r11d
               	movl	0x14(%rsi), %esi
               	xorq	%rsi, %r11
               	movq	%rax, %rsi
               	andq	$0x51b33be9, %rsi       # imm = 0x51B33BE9
               	movq	%r10, 0x10(%rsp)
               	movl	$0xaf7d655a, %r10d      # imm = 0xAF7D655A
               	xorq	%r10, %rsi
               	movq	0x10(%rsp), %r10
               	movq	%rax, %r8
               	andq	$0x3b0fe8ae, %r8        # imm = 0x3B0FE8AE
               	movq	%r11, 0x10(%rsp)
               	movl	$0xf0168aa3, %r11d      # imm = 0xF0168AA3
               	xorq	%r11, %r8
               	andq	%rdx, %r8
               	xorq	%r8, %rsi
               	movl	$0x90bf8816, %r8d       # imm = 0x90BF8816
               	andq	%rax, %r8
               	movl	$0x90aa30c6, %ebx       # imm = 0x90AA30C6
               	xorq	%r8, %rbx
               	movq	%rax, %r8
               	andq	$0x9e34f9b, %r8         # imm = 0x9E34F9B
               	xorq	$0x5ab2750a, %r8        # imm = 0x5AB2750A
               	andq	%rdx, %r8
               	xorq	%r8, %rbx
               	andq	%rdi, %rbx
               	xorq	%rbx, %rsi
               	movq	%rax, %r8
               	andq	$0x103be88, %r8         # imm = 0x103BE88
               	xorq	$0x5391be65, %r8        # imm = 0x5391BE65
               	movq	%rax, %rbx
               	andq	$0x49ac8e25, %rbx       # imm = 0x49AC8E25
               	movl	$0x93372baf, %r11d      # imm = 0x93372BAF
               	xorq	%r11, %rbx
               	andq	%rdx, %rbx
               	xorq	%rbx, %r8
               	movl	$0x922c313d, %ebx       # imm = 0x922C313D
               	andq	%rax, %rbx
               	movl	$0xf288210c, %r11d      # imm = 0xF288210C
               	xorq	%r11, %rbx
               	movq	%rax, %r12
               	andq	$0x70ef31b0, %r12       # imm = 0x70EF31B0
               	movl	$0x920af5c0, %r11d      # imm = 0x920AF5C0
               	xorq	%r11, %r12
               	andq	%rdx, %r12
               	xorq	%r12, %rbx
               	andq	%rdi, %rbx
               	xorq	%rbx, %r8
               	andq	%r9, %r8
               	xorq	%r8, %rsi
               	movq	%rax, %r8
               	andq	$0x6a707100, %r8        # imm = 0x6A707100
               	xorq	$0x63d312c0, %r8        # imm = 0x63D312C0
               	movl	$0xb97c9011, %ebx       # imm = 0xB97C9011
               	andq	%rax, %rbx
               	xorq	$0x537b3006, %rbx       # imm = 0x537B3006
               	andq	%rdx, %rbx
               	xorq	%rbx, %r8
               	movl	$0xa320c959, %ebx       # imm = 0xA320C959
               	andq	%rax, %rbx
               	movl	$0xa2efb0a5, %r11d      # imm = 0xA2EFB0A5
               	xorq	%r11, %rbx
               	movq	%rax, %r12
               	andq	$0x6ea0ab4a, %r12       # imm = 0x6EA0AB4A
               	movl	$0xbc8f96a5, %r11d      # imm = 0xBC8F96A5
               	xorq	%r11, %r12
               	andq	%rdx, %r12
               	xorq	%r12, %rbx
               	andq	%rdi, %rbx
               	xorq	%rbx, %r8
               	movl	$0xf74f3e2b, %ebx       # imm = 0xF74F3E2B
               	andq	%rax, %rbx
               	xorq	$0x665a14a3, %rbx       # imm = 0x665A14A3
               	andq	%rbx, %rdx
               	movq	%rax, %rbx
               	andq	$0x6953ddf8, %rbx       # imm = 0x6953DDF8
               	movl	$0xfad176a5, %r11d      # imm = 0xFAD176A5
               	xorq	%r11, %rbx
               	xorq	%rdx, %rbx
               	movl	$0xf0306cad, %r11d      # imm = 0xF0306CAD
               	andq	%r11, %rax
               	movl	$0xf2eff0cc, %r11d      # imm = 0xF2EFF0CC
               	xorq	%r11, %rax
               	andq	%rax, %rdi
               	xorq	%rdi, %rbx
               	andq	%rbx, %r9
               	xorq	%r9, %r8
               	andq	%r8, %r10
               	movq	0x10(%rsp), %r11
               	xorq	%r10, %rsi
               	andq	%rsi, %r11
               	xorq	%r11, %rcx
               	movq	%rcx, %rax
               	andq	$0x4, %rax
               	shlq	$0x3, %rax
               	movq	%rcx, %rdx
               	andq	$0x4000, %rdx           # imm = 0x4000
               	shlq	$0x4, %rdx
               	orq	%rdx, %rax
               	movq	%rcx, %rdx
               	andq	$0x12020120, %rdx       # imm = 0x12020120
               	rorl	$0x1b, %edx
               	orq	%rdx, %rax
               	movq	%rcx, %rdx
               	andq	$0x100000, %rdx         # imm = 0x100000
               	shlq	$0x6, %rdx
               	orq	%rdx, %rax
               	movq	%rcx, %rdx
               	andq	$0x8000, %rdx           # imm = 0x8000
               	shlq	$0x9, %rdx
               	orq	%rdx, %rax
               	movq	%rcx, %rdx
               	andq	$0x4000000, %rdx        # imm = 0x4000000
               	shrq	$0x16, %rdx
               	orq	%rdx, %rax
               	movq	%rcx, %rdx
               	andq	$0x1, %rdx
               	shlq	$0xb, %rdx
               	orq	%rdx, %rax
               	movq	%rcx, %rdx
               	andq	$0x20000200, %rdx       # imm = 0x20000200
               	rorl	$0x14, %edx
               	orq	%rdx, %rax
               	movq	%rcx, %rdx
               	andq	$0x200000, %rdx         # imm = 0x200000
               	shrq	$0x13, %rdx
               	orq	%rdx, %rax
               	movq	%rcx, %rdx
               	andq	$0x40, %rdx
               	shlq	$0xe, %rdx
               	orq	%rdx, %rax
               	movq	%rcx, %rdx
               	andq	$0x10000, %rdx          # imm = 0x10000
               	shlq	$0xf, %rdx
               	orq	%rdx, %rax
               	movq	%rcx, %rdx
               	andq	$0x2, %rdx
               	shlq	$0x10, %rdx
               	orq	%rdx, %rax
               	movq	%rcx, %rdx
               	andq	$0x40801800, %rdx       # imm = 0x40801800
               	rorl	$0xf, %edx
               	orq	%rdx, %rax
               	movq	%rcx, %rdx
               	andq	$0x80000, %rdx          # imm = 0x80000
               	shrq	$0xd, %rdx
               	orq	%rdx, %rax
               	movq	%rcx, %rdx
               	andq	$0x10, %rdx
               	shlq	$0x15, %rdx
               	orq	%rdx, %rax
               	movq	%rcx, %rdx
               	andq	$0x1000000, %rdx        # imm = 0x1000000
               	shrq	$0xa, %rdx
               	orq	%rdx, %rax
               	movl	$0x88000008, %edx       # imm = 0x88000008
               	andq	%rcx, %rdx
               	rorl	$0x8, %edx
               	orq	%rdx, %rax
               	movq	%rcx, %rdx
               	andq	$0x480, %rdx            # imm = 0x480
               	shrq	$0x7, %rdx
               	orq	%rdx, %rax
               	andq	$0x442000, %rcx         # imm = 0x442000
               	shrq	$0x6, %rcx
               	orq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq

<main>:
               	pushq	%rbx
               	movl	$0xa5a5a5a5, %edi       # imm = 0xA5A5A5A5
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0xd2f51ac0, %edi       # imm = 0xD2F51AC0
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	xorq	%rax, %rbx
               	movl	$0x3849cf1f, %edi       # imm = 0x3849CF1F
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	xorq	%rax, %rbx
               	movl	$0xbabbd1f2, %edi       # imm = 0xBABBD1F2
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	xorq	%rax, %rbx
               	movl	$0xe4108a9, %edi        # imm = 0xE4108A9
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	xorq	%rax, %rbx
               	movl	$0xb7b0b9f4, %edi       # imm = 0xB7B0B9F4
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	xorq	%rax, %rbx
               	movl	$0x23539cc3, %edi       # imm = 0x23539CC3
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	xorq	%rax, %rbx
               	movl	$0xa72e9b46, %edi       # imm = 0xA72E9B46
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	xorq	%rax, %rbx
               	movl	$0x7580b9ed, %edi       # imm = 0x7580B9ED
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	xorq	%rax, %rbx
               	movl	$0xa631d268, %edi       # imm = 0xA631D268
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	xorq	%rax, %rbx
               	movl	$0x12f412a7, %edi       # imm = 0x12F412A7
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	xorq	%rax, %rbx
               	movl	$0x44916fda, %edi       # imm = 0x44916FDA
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	xorq	%rax, %rbx
               	movl	$0x96ac7d71, %edi       # imm = 0x96AC7D71
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	xorq	%rax, %rbx
               	movl	$0xdd35581c, %edi       # imm = 0xDD35581C
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	xorq	%rax, %rbx
               	movl	$0x53fb94cb, %edi       # imm = 0x53FB94CB
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	xorq	%rax, %rbx
               	movl	$0x455163ae, %edi       # imm = 0x455163AE
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	xorq	%rbx, %rax
               	movl	%eax, %ecx
               	movq	%rcx, %rax
               	shrq	$0x8, %rax
               	xorq	%rcx, %rax
               	movq	%rcx, %rdx
               	shrq	$0x10, %rdx
               	xorq	%rdx, %rax
               	shrq	$0x18, %rcx
               	xorq	%rcx, %rax
               	andq	$0xff, %rax
               	popq	%rbx
               	retq
