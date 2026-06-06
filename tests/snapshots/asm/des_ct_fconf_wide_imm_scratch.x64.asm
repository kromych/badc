
des_ct_fconf_wide_imm_scratch.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%esi, %rsi
               	movl	%edi, %eax
               	movq	%rax, %rcx
               	movq	%rcx, %r13
               	movq	%rsi, %rcx
               	shlq	%cl, %r13
               	movq	%r13, %rcx
               	movl	%ecx, %ecx
               	movl	$0x20, %edx
               	subq	%rsi, %rdx
               	movslq	%edx, %rdx
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rax
               	popq	%rcx
               	orq	%rcx, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x5f0, %rsp            # imm = 0x5F0
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	%edi, %eax
               	movq	%rax, %rcx
               	andq	$0x11111111, %rcx       # imm = 0x11111111
               	movq	%rax, %rdx
               	shrq	$0x1, %rdx
               	andq	$0x11111111, %rdx       # imm = 0x11111111
               	movq	%rax, %rdi
               	shrq	$0x2, %rdi
               	andq	$0x11111111, %rdi       # imm = 0x11111111
               	shrq	$0x3, %rax
               	andq	$0x11111111, %rax       # imm = 0x11111111
               	movl	%ecx, %ecx
               	movq	%rcx, %r8
               	shlq	$0x4, %r8
               	movl	%r8d, %r8d
               	movq	%rcx, %r10
               	movq	%r8, %rcx
               	subq	%r10, %rcx
               	movl	%ecx, %ecx
               	movl	%edx, %edx
               	movq	%rdx, %r8
               	shlq	$0x4, %r8
               	movl	%r8d, %r8d
               	movq	%rdx, %r10
               	movq	%r8, %rdx
               	subq	%r10, %rdx
               	movl	%edx, %edx
               	movl	%edi, %edi
               	movq	%rdi, %r8
               	shlq	$0x4, %r8
               	movl	%r8d, %r8d
               	movq	%rdi, %r10
               	movq	%r8, %rdi
               	subq	%r10, %rdi
               	movl	%edi, %edi
               	movl	%eax, %eax
               	movq	%rax, %r8
               	shlq	$0x4, %r8
               	movl	%r8d, %r8d
               	movq	%rax, %r10
               	movq	%r8, %rax
               	subq	%r10, %rax
               	movl	%eax, %eax
               	movl	%eax, %eax
               	movq	%rax, %r8
               	shlq	$0x4, %r8
               	movl	%r8d, %r8d
               	movq	%rax, %r9
               	shrq	$0x1c, %r9
               	orq	%r9, %r8
               	movl	%ecx, %ecx
               	movq	%rcx, %r9
               	shrq	$0x4, %r9
               	movq	%rcx, %r11
               	shlq	$0x1c, %r11
               	movl	%r11d, %r11d
               	orq	%r11, %r9
               	movl	%r8d, %r8d
               	movl	(%rsi), %r11d
               	xorq	%r11, %r8
               	movl	%r8d, %r8d
               	movq	%rsi, %r11
               	addq	$0x4, %r11
               	movl	(%r11), %r11d
               	xorq	%r11, %rcx
               	movl	%ecx, %ecx
               	movl	%edx, %edx
               	movq	%rsi, %r11
               	addq	$0x8, %r11
               	movl	(%r11), %r11d
               	xorq	%r11, %rdx
               	movl	%edx, %edx
               	movl	%edi, %edi
               	movl	$0xc, %r11d
               	movq	%rsi, %rbx
               	addq	$0xc, %rbx
               	movl	(%rbx), %ebx
               	xorq	%rbx, %rdi
               	movl	%edi, %edi
               	movq	%rsi, %rbx
               	addq	$0x10, %rbx
               	movl	(%rbx), %ebx
               	xorq	%rbx, %rax
               	movl	%eax, %eax
               	movl	%r9d, %r9d
               	addq	$0x14, %rsi
               	movl	(%rsi), %esi
               	xorq	%r9, %rsi
               	movl	%esi, %esi
               	movl	$0xec7ac69c, %r9d       # imm = 0xEC7AC69C
               	andq	%r8, %r9
               	movl	$0xefa72c4d, %r13d      # imm = 0xEFA72C4D
               	xorq	%r13, %r9
               	movq	%r8, %rbx
               	andq	$0x500fb821, %rbx       # imm = 0x500FB821
               	movl	$0xaeaaedff, %r13d      # imm = 0xAEAAEDFF
               	xorq	%r13, %rbx
               	movq	%r8, %r12
               	andq	$0x40efa809, %r12       # imm = 0x40EFA809
               	xorq	$0x37396665, %r12       # imm = 0x37396665
               	movl	$0xa5ec0b28, %r14d      # imm = 0xA5EC0B28
               	andq	%r8, %r14
               	xorq	$0x68d7b833, %r14       # imm = 0x68D7B833
               	movq	%r8, %r15
               	andq	$0x252cf820, %r15       # imm = 0x252CF820
               	movl	$0xc9c755bb, %r13d      # imm = 0xC9C755BB
               	xorq	%r13, %r15
               	movq	%r8, %r10
               	andq	$0x40205801, %r10       # imm = 0x40205801
               	movq	%r10, 0x5d0(%rsp)
               	movq	0x5d0(%rsp), %r10
               	xorq	$0x73fc3606, %r10       # imm = 0x73FC3606
               	movq	%r10, 0x5c8(%rsp)
               	movl	$0xe220f929, %r10d      # imm = 0xE220F929
               	andq	%r8, %r10
               	movq	%r10, 0x5a8(%rsp)
               	movq	0x5a8(%rsp), %r10
               	movl	$0xa2a0a918, %r13d      # imm = 0xA2A0A918
               	xorq	%r13, %r10
               	movq	%r10, 0x5a0(%rsp)
               	movq	%r8, %r10
               	andq	$0x44a3f9e1, %r10       # imm = 0x44A3F9E1
               	movq	%r10, 0x580(%rsp)
               	movq	0x580(%rsp), %r10
               	movl	$0x8222bd90, %r13d      # imm = 0x8222BD90
               	xorq	%r13, %r10
               	movq	%r10, 0x578(%rsp)
               	movq	%r8, %r10
               	andq	$0x794f104a, %r10       # imm = 0x794F104A
               	movq	%r10, 0x558(%rsp)
               	movq	0x558(%rsp), %r10
               	movl	$0xd6b6ac77, %r13d      # imm = 0xD6B6AC77
               	xorq	%r13, %r10
               	movq	%r10, 0x550(%rsp)
               	movq	%r8, %r10
               	andq	$0x26f320b, %r10        # imm = 0x26F320B
               	movq	%r10, 0x530(%rsp)
               	movq	0x530(%rsp), %r10
               	xorq	$0x3069300c, %r10       # imm = 0x3069300C
               	movq	%r10, 0x528(%rsp)
               	movq	%r8, %r10
               	andq	$0x7640b01a, %r10       # imm = 0x7640B01A
               	movq	%r10, 0x508(%rsp)
               	movq	0x508(%rsp), %r10
               	xorq	$0x6ce0d5cc, %r10       # imm = 0x6CE0D5CC
               	movq	%r10, 0x500(%rsp)
               	movq	%r8, %r10
               	andq	$0x238f1572, %r10       # imm = 0x238F1572
               	movq	%r10, 0x4e0(%rsp)
               	movq	0x4e0(%rsp), %r10
               	xorq	$0x59a9a22d, %r10       # imm = 0x59A9A22D
               	movq	%r10, 0x4d8(%rsp)
               	movq	%r8, %r10
               	andq	$0x7a63c083, %r10       # imm = 0x7A63C083
               	movq	%r10, 0x4b8(%rsp)
               	movq	0x4b8(%rsp), %r10
               	movl	$0xac6d0bd4, %r13d      # imm = 0xAC6D0BD4
               	xorq	%r13, %r10
               	movq	%r10, 0x4b0(%rsp)
               	movq	%r8, %r10
               	andq	$0x11cca000, %r10       # imm = 0x11CCA000
               	movq	%r10, 0x490(%rsp)
               	movq	0x490(%rsp), %r10
               	xorq	$0x21c83200, %r10       # imm = 0x21C83200
               	movq	%r10, 0x488(%rsp)
               	movq	%r8, %r10
               	andq	$0x202f69aa, %r10       # imm = 0x202F69AA
               	movq	%r10, 0x468(%rsp)
               	movq	0x468(%rsp), %r10
               	movl	$0xa0e62188, %r13d      # imm = 0xA0E62188
               	xorq	%r13, %r10
               	movq	%r10, 0x460(%rsp)
               	movq	%r8, %r10
               	andq	$0x51b33be9, %r10       # imm = 0x51B33BE9
               	movq	%r10, 0x440(%rsp)
               	movq	0x440(%rsp), %r10
               	movl	$0xaf7d655a, %r13d      # imm = 0xAF7D655A
               	xorq	%r13, %r10
               	movq	%r10, 0x438(%rsp)
               	movq	%r8, %r10
               	andq	$0x3b0fe8ae, %r10       # imm = 0x3B0FE8AE
               	movq	%r10, 0x418(%rsp)
               	movq	0x418(%rsp), %r10
               	movl	$0xf0168aa3, %r13d      # imm = 0xF0168AA3
               	xorq	%r13, %r10
               	movq	%r10, 0x410(%rsp)
               	movl	$0x90bf8816, %r10d      # imm = 0x90BF8816
               	andq	%r8, %r10
               	movq	%r10, 0x3f0(%rsp)
               	movq	0x3f0(%rsp), %r10
               	movl	$0x90aa30c6, %r13d      # imm = 0x90AA30C6
               	xorq	%r13, %r10
               	movq	%r10, 0x3e8(%rsp)
               	movq	%r8, %r10
               	andq	$0x9e34f9b, %r10        # imm = 0x9E34F9B
               	movq	%r10, 0x3c8(%rsp)
               	movq	0x3c8(%rsp), %r10
               	xorq	$0x5ab2750a, %r10       # imm = 0x5AB2750A
               	movq	%r10, 0x3c0(%rsp)
               	movq	%r8, %r10
               	andq	$0x103be88, %r10        # imm = 0x103BE88
               	movq	%r10, 0x3a0(%rsp)
               	movq	0x3a0(%rsp), %r10
               	xorq	$0x5391be65, %r10       # imm = 0x5391BE65
               	movq	%r10, 0x398(%rsp)
               	movq	%r8, %r10
               	andq	$0x49ac8e25, %r10       # imm = 0x49AC8E25
               	movq	%r10, 0x378(%rsp)
               	movq	0x378(%rsp), %r10
               	movl	$0x93372baf, %r13d      # imm = 0x93372BAF
               	xorq	%r13, %r10
               	movq	%r10, 0x370(%rsp)
               	movl	$0x922c313d, %r10d      # imm = 0x922C313D
               	andq	%r8, %r10
               	movq	%r10, 0x350(%rsp)
               	movq	0x350(%rsp), %r10
               	movl	$0xf288210c, %r13d      # imm = 0xF288210C
               	xorq	%r13, %r10
               	movq	%r10, 0x348(%rsp)
               	movq	%r8, %r10
               	andq	$0x70ef31b0, %r10       # imm = 0x70EF31B0
               	movq	%r10, 0x328(%rsp)
               	movq	0x328(%rsp), %r10
               	movl	$0x920af5c0, %r13d      # imm = 0x920AF5C0
               	xorq	%r13, %r10
               	movq	%r10, 0x320(%rsp)
               	movq	%r8, %r10
               	andq	$0x6a707100, %r10       # imm = 0x6A707100
               	movq	%r10, 0x300(%rsp)
               	movq	0x300(%rsp), %r10
               	xorq	$0x63d312c0, %r10       # imm = 0x63D312C0
               	movq	%r10, 0x2f8(%rsp)
               	movl	$0xb97c9011, %r10d      # imm = 0xB97C9011
               	andq	%r8, %r10
               	movq	%r10, 0x2d8(%rsp)
               	movq	0x2d8(%rsp), %r10
               	xorq	$0x537b3006, %r10       # imm = 0x537B3006
               	movq	%r10, 0x2d0(%rsp)
               	movl	$0xa320c959, %r10d      # imm = 0xA320C959
               	andq	%r8, %r10
               	movq	%r10, 0x2b0(%rsp)
               	movq	0x2b0(%rsp), %r10
               	movl	$0xa2efb0a5, %r13d      # imm = 0xA2EFB0A5
               	xorq	%r13, %r10
               	movq	%r10, 0x2a8(%rsp)
               	movq	%r8, %r10
               	andq	$0x6ea0ab4a, %r10       # imm = 0x6EA0AB4A
               	movq	%r10, 0x288(%rsp)
               	movq	0x288(%rsp), %r10
               	movl	$0xbc8f96a5, %r13d      # imm = 0xBC8F96A5
               	xorq	%r13, %r10
               	movq	%r10, 0x280(%rsp)
               	movq	%r8, %r10
               	andq	$0x6953ddf8, %r10       # imm = 0x6953DDF8
               	movq	%r10, 0x260(%rsp)
               	movq	0x260(%rsp), %r10
               	movl	$0xfad176a5, %r13d      # imm = 0xFAD176A5
               	xorq	%r13, %r10
               	movq	%r10, 0x258(%rsp)
               	movl	$0xf74f3e2b, %r10d      # imm = 0xF74F3E2B
               	andq	%r8, %r10
               	movq	%r10, 0x238(%rsp)
               	movq	0x238(%rsp), %r10
               	xorq	$0x665a14a3, %r10       # imm = 0x665A14A3
               	movq	%r10, 0x230(%rsp)
               	movl	$0xf0306cad, %r13d      # imm = 0xF0306CAD
               	andq	%r13, %r8
               	movl	$0xf2eff0cc, %r13d      # imm = 0xF2EFF0CC
               	xorq	%r13, %r8
               	movl	%r9d, %r9d
               	movl	%ebx, %ebx
               	andq	%rcx, %rbx
               	xorq	%rbx, %r9
               	movl	%r12d, %ebx
               	movl	%r14d, %r12d
               	andq	%rcx, %r12
               	xorq	%r12, %rbx
               	movl	%r15d, %r12d
               	movq	0x5c8(%rsp), %r14
               	movl	%r14d, %r14d
               	andq	%rcx, %r14
               	xorq	%r14, %r12
               	movq	0x5a0(%rsp), %r14
               	movl	%r14d, %r14d
               	movq	0x578(%rsp), %r15
               	movl	%r15d, %r15d
               	andq	%rcx, %r15
               	xorq	%r15, %r14
               	movq	0x550(%rsp), %r15
               	movl	%r15d, %r15d
               	movq	0x528(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x208(%rsp)
               	movq	%rcx, %r10
               	andq	0x208(%rsp), %r10
               	movq	%r10, 0x200(%rsp)
               	xorq	0x200(%rsp), %r15
               	movq	0x500(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x1f0(%rsp)
               	movq	0x4d8(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x1e8(%rsp)
               	movq	%rcx, %r10
               	andq	0x1e8(%rsp), %r10
               	movq	%r10, 0x1e0(%rsp)
               	movq	0x1f0(%rsp), %r10
               	xorq	0x1e0(%rsp), %r10
               	movq	%r10, 0x1d8(%rsp)
               	movq	0x4b0(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x1c8(%rsp)
               	movq	0x488(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x1c0(%rsp)
               	movq	%rcx, %r10
               	andq	0x1c0(%rsp), %r10
               	movq	%r10, 0x1b8(%rsp)
               	movq	0x1c8(%rsp), %r10
               	xorq	0x1b8(%rsp), %r10
               	movq	%r10, 0x1b0(%rsp)
               	movq	0x460(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x1a0(%rsp)
               	movq	0x438(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x190(%rsp)
               	movq	0x410(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x188(%rsp)
               	movq	%rcx, %r10
               	andq	0x188(%rsp), %r10
               	movq	%r10, 0x180(%rsp)
               	movq	0x190(%rsp), %r10
               	xorq	0x180(%rsp), %r10
               	movq	%r10, 0x178(%rsp)
               	movq	0x3e8(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x168(%rsp)
               	movq	0x3c0(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x160(%rsp)
               	movq	%rcx, %r10
               	andq	0x160(%rsp), %r10
               	movq	%r10, 0x158(%rsp)
               	movq	0x168(%rsp), %r10
               	xorq	0x158(%rsp), %r10
               	movq	%r10, 0x150(%rsp)
               	movq	0x398(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x140(%rsp)
               	movq	0x370(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x138(%rsp)
               	movq	%rcx, %r10
               	andq	0x138(%rsp), %r10
               	movq	%r10, 0x130(%rsp)
               	movq	0x140(%rsp), %r10
               	xorq	0x130(%rsp), %r10
               	movq	%r10, 0x128(%rsp)
               	movq	0x348(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x118(%rsp)
               	movq	0x320(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x110(%rsp)
               	movq	%rcx, %r10
               	andq	0x110(%rsp), %r10
               	movq	%r10, 0x108(%rsp)
               	movq	0x118(%rsp), %r10
               	xorq	0x108(%rsp), %r10
               	movq	%r10, 0x100(%rsp)
               	movq	0x2f8(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0xf0(%rsp)
               	movq	0x2d0(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0xe8(%rsp)
               	movq	%rcx, %r10
               	andq	0xe8(%rsp), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0xf0(%rsp), %r10
               	xorq	0xe0(%rsp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0x2a8(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0xc8(%rsp)
               	movq	0x280(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0xc0(%rsp)
               	movq	%rcx, %r10
               	andq	0xc0(%rsp), %r10
               	movq	%r10, 0xb8(%rsp)
               	movq	0xc8(%rsp), %r10
               	xorq	0xb8(%rsp), %r10
               	movq	%r10, 0xb0(%rsp)
               	movq	0x258(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0xa0(%rsp)
               	movq	0x230(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x98(%rsp)
               	andq	0x98(%rsp), %rcx
               	movq	%rcx, %r10
               	movq	0xa0(%rsp), %rcx
               	xorq	%r10, %rcx
               	movl	%r8d, %r8d
               	movl	%r9d, %r9d
               	movl	%ebx, %ebx
               	andq	%rdx, %rbx
               	xorq	%rbx, %r9
               	movl	%r12d, %ebx
               	movl	%r14d, %r12d
               	andq	%rdx, %r12
               	xorq	%r12, %rbx
               	movl	%r15d, %r12d
               	movq	0x1d8(%rsp), %r14
               	movl	%r14d, %r14d
               	andq	%rdx, %r14
               	xorq	%r14, %r12
               	movq	0x1b0(%rsp), %r14
               	movl	%r14d, %r14d
               	movq	0x1a0(%rsp), %r15
               	movl	%r15d, %r15d
               	andq	%rdx, %r15
               	xorq	%r15, %r14
               	movq	0x178(%rsp), %r15
               	movl	%r15d, %r15d
               	movq	0x150(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x80(%rsp)
               	movq	%rdx, %r10
               	andq	0x80(%rsp), %r10
               	movq	%r10, 0x78(%rsp)
               	xorq	0x78(%rsp), %r15
               	movq	0x128(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x68(%rsp)
               	movq	0x100(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x60(%rsp)
               	movq	%rdx, %r10
               	andq	0x60(%rsp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x68(%rsp), %r10
               	xorq	0x58(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0xd8(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x40(%rsp)
               	movq	0xb0(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x38(%rsp)
               	movq	%rdx, %r10
               	andq	0x38(%rsp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x40(%rsp), %r10
               	xorq	0x30(%rsp), %r10
               	movq	%r10, 0x28(%rsp)
               	movl	%ecx, %ecx
               	movl	%r8d, %r8d
               	andq	%r8, %rdx
               	xorq	%rdx, %rcx
               	movl	%r9d, %edx
               	movl	%ebx, %r8d
               	andq	%rdi, %r8
               	xorq	%r8, %rdx
               	movl	%r12d, %r8d
               	movl	%r14d, %r9d
               	andq	%rdi, %r9
               	xorq	%r9, %r8
               	movl	%r15d, %r9d
               	movq	0x50(%rsp), %rbx
               	movl	%ebx, %ebx
               	andq	%rdi, %rbx
               	xorq	%rbx, %r9
               	movq	0x28(%rsp), %rbx
               	movl	%ebx, %ebx
               	movl	%ecx, %ecx
               	andq	%rdi, %rcx
               	xorq	%rbx, %rcx
               	movl	%edx, %edx
               	movl	%r8d, %edi
               	andq	%rax, %rdi
               	xorq	%rdi, %rdx
               	movl	%r9d, %edi
               	movl	%ecx, %ecx
               	andq	%rcx, %rax
               	xorq	%rdi, %rax
               	movl	%edx, %ecx
               	movl	%eax, %eax
               	andq	%rsi, %rax
               	xorq	%rcx, %rax
               	movl	%eax, %ecx
               	movq	%rcx, %rdx
               	andq	$0x4, %rdx
               	shlq	$0x3, %rdx
               	movl	%edx, %edx
               	movl	%edx, %edx
               	movq	%rcx, %rsi
               	andq	$0x4000, %rsi           # imm = 0x4000
               	shlq	$0x4, %rsi
               	movl	%esi, %esi
               	orq	%rsi, %rdx
               	movl	%edx, %edx
               	andq	$0x12020120, %rcx       # imm = 0x12020120
               	movl	$0x5, %esi
               	movl	%ecx, %ecx
               	movq	%rcx, %rdi
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shlq	%cl, %rdi
               	popq	%rcx
               	movl	%edi, %edi
               	movl	$0x20, %r8d
               	movq	%rsi, %r10
               	movq	%r8, %rsi
               	subq	%r10, %rsi
               	movslq	%esi, %rsi
               	movq	%rcx, %r13
               	movq	%rsi, %rcx
               	shrq	%cl, %r13
               	movq	%r13, %rcx
               	orq	%rdi, %rcx
               	orq	%rdx, %rcx
               	movl	%ecx, %ecx
               	movl	%eax, %edx
               	movq	%rdx, %rsi
               	andq	$0x100000, %rsi         # imm = 0x100000
               	shlq	$0x6, %rsi
               	movl	%esi, %esi
               	orq	%rsi, %rcx
               	movl	%ecx, %ecx
               	movq	%rdx, %rsi
               	andq	$0x8000, %rsi           # imm = 0x8000
               	shlq	$0x9, %rsi
               	movl	%esi, %esi
               	orq	%rsi, %rcx
               	movl	%ecx, %ecx
               	movq	%rdx, %rsi
               	andq	$0x4000000, %rsi        # imm = 0x4000000
               	shrq	$0x16, %rsi
               	orq	%rsi, %rcx
               	movl	%ecx, %ecx
               	movq	%rdx, %rsi
               	andq	$0x1, %rsi
               	shlq	$0xb, %rsi
               	movl	%esi, %esi
               	orq	%rsi, %rcx
               	movl	%ecx, %ecx
               	andq	$0x20000200, %rdx       # imm = 0x20000200
               	movl	%edx, %edx
               	movq	%rdx, %rsi
               	pushq	%rcx
               	movq	%r11, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	movl	%esi, %esi
               	movl	$0x20, %edi
               	subq	%r11, %rdi
               	movslq	%edi, %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	orq	%rsi, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, %ecx
               	movl	%eax, %edx
               	movq	%rdx, %rsi
               	andq	$0x200000, %rsi         # imm = 0x200000
               	shrq	$0x13, %rsi
               	orq	%rsi, %rcx
               	movl	%ecx, %ecx
               	movq	%rdx, %rsi
               	andq	$0x40, %rsi
               	shlq	$0xe, %rsi
               	movl	%esi, %esi
               	orq	%rsi, %rcx
               	movl	%ecx, %ecx
               	movq	%rdx, %rsi
               	andq	$0x10000, %rsi          # imm = 0x10000
               	shlq	$0xf, %rsi
               	movl	%esi, %esi
               	orq	%rsi, %rcx
               	movl	%ecx, %ecx
               	movq	%rdx, %rsi
               	andq	$0x2, %rsi
               	shlq	$0x10, %rsi
               	movl	%esi, %esi
               	orq	%rsi, %rcx
               	movl	%ecx, %ecx
               	andq	$0x40801800, %rdx       # imm = 0x40801800
               	movl	$0x11, %esi
               	movl	%edx, %edx
               	movq	%rdx, %rdi
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shlq	%cl, %rdi
               	popq	%rcx
               	movl	%edi, %edi
               	movl	$0x20, %r8d
               	movq	%rsi, %r10
               	movq	%r8, %rsi
               	subq	%r10, %rsi
               	movslq	%esi, %rsi
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	orq	%rdi, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, %ecx
               	movl	%eax, %edx
               	movq	%rdx, %rsi
               	andq	$0x80000, %rsi          # imm = 0x80000
               	shrq	$0xd, %rsi
               	orq	%rsi, %rcx
               	movl	%ecx, %ecx
               	movq	%rdx, %rsi
               	andq	$0x10, %rsi
               	shlq	$0x15, %rsi
               	movl	%esi, %esi
               	orq	%rsi, %rcx
               	movl	%ecx, %ecx
               	movq	%rdx, %rsi
               	andq	$0x1000000, %rsi        # imm = 0x1000000
               	shrq	$0xa, %rsi
               	orq	%rsi, %rcx
               	movl	%ecx, %ecx
               	movl	$0x88000008, %r13d      # imm = 0x88000008
               	andq	%r13, %rdx
               	movl	$0x18, %esi
               	movl	%edx, %edx
               	movq	%rdx, %rdi
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shlq	%cl, %rdi
               	popq	%rcx
               	movl	%edi, %edi
               	movl	$0x20, %r8d
               	movq	%rsi, %r10
               	movq	%r8, %rsi
               	subq	%r10, %rsi
               	movslq	%esi, %rsi
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	orq	%rdi, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, %ecx
               	movl	%eax, %eax
               	movq	%rax, %rdx
               	andq	$0x480, %rdx            # imm = 0x480
               	shrq	$0x7, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, %ecx
               	andq	$0x442000, %rax         # imm = 0x442000
               	shrq	$0x6, %rax
               	orq	%rcx, %rax
               	movl	%eax, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x5f0, %rsp            # imm = 0x5F0
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	xorq	%rbx, %rbx
               	movl	$0xa5a5a5a5, %r12d      # imm = 0xA5A5A5A5
               	movq	%rbx, %r14
               	jmp	<addr>
               	movslq	%ebx, %rax
               	cmpq	$0x10, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rax
               	movq	%rax, %rbx
               	addq	$0x1, %rbx
               	jmp	<addr>
               	movl	%r14d, %r14d
               	movl	%r12d, %edi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	xorq	%rax, %r14
               	movl	%r12d, %eax
               	imulq	$0x19660d, %rax, %rax   # imm = 0x19660D
               	movl	%eax, %eax
               	addq	$0x3c6ef35f, %rax       # imm = 0x3C6EF35F
               	movl	%eax, %r12d
               	jmp	<addr>
               	movl	%r14d, %eax
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	xorq	%rax, %rcx
               	movq	%rax, %rdx
               	shrq	$0x10, %rdx
               	xorq	%rdx, %rcx
               	shrq	$0x18, %rax
               	xorq	%rcx, %rax
               	andq	$0xff, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
