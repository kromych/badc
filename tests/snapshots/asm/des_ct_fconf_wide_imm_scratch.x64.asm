
des_ct_fconf_wide_imm_scratch.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movq	%rdi, %rax
               	movq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	movl	%eax, %eax
               	movq	%rax, %rdx
               	shlq	%cl, %rdx
               	movl	%edx, %edx
               	movl	$0x20, %esi
               	movq	%rcx, %r10
               	movq	%rsi, %rcx
               	subq	%r10, %rcx
               	movslq	%ecx, %rcx
               	shrq	%cl, %rax
               	orq	%rdx, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x570, %rsp            # imm = 0x570
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %rax
               	movq	%rsi, %rcx
               	movl	%eax, %eax
               	movq	%rax, %rdx
               	andq	$0x11111111, %rdx       # imm = 0x11111111
               	movl	%edx, -0x10(%rbp)
               	movq	%rax, %rdx
               	shrq	$0x1, %rdx
               	andq	$0x11111111, %rdx       # imm = 0x11111111
               	movl	%edx, -0x18(%rbp)
               	movq	%rax, %rdx
               	shrq	$0x2, %rdx
               	andq	$0x11111111, %rdx       # imm = 0x11111111
               	movl	%edx, -0x20(%rbp)
               	shrq	$0x3, %rax
               	andq	$0x11111111, %rax       # imm = 0x11111111
               	movl	%eax, -0x28(%rbp)
               	movl	-0x10(%rbp), %eax
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	movl	%edx, %edx
               	movq	%rax, %r10
               	movq	%rdx, %rax
               	subq	%r10, %rax
               	movl	%eax, %eax
               	movl	%eax, -0x10(%rbp)
               	movl	-0x18(%rbp), %eax
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	movl	%edx, %edx
               	movq	%rax, %r10
               	movq	%rdx, %rax
               	subq	%r10, %rax
               	movl	%eax, %eax
               	movl	%eax, -0x18(%rbp)
               	movl	-0x20(%rbp), %eax
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	movl	%edx, %edx
               	movq	%rax, %r10
               	movq	%rdx, %rax
               	subq	%r10, %rax
               	movl	%eax, %eax
               	movl	%eax, -0x20(%rbp)
               	movl	-0x28(%rbp), %eax
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	movl	%edx, %edx
               	movq	%rax, %r10
               	movq	%rdx, %rax
               	subq	%r10, %rax
               	movl	%eax, %eax
               	movl	%eax, -0x28(%rbp)
               	movl	-0x28(%rbp), %eax
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	movl	%edx, %edx
               	shrq	$0x1c, %rax
               	orq	%rdx, %rax
               	movl	%eax, -0x8(%rbp)
               	movl	-0x10(%rbp), %eax
               	movq	%rax, %rdx
               	shrq	$0x4, %rdx
               	shlq	$0x1c, %rax
               	movl	%eax, %eax
               	orq	%rdx, %rax
               	movl	%eax, -0x30(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %edx
               	movl	(%rcx), %esi
               	xorq	%rsi, %rdx
               	movl	%edx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %edx
               	movq	%rcx, %rsi
               	addq	$0x4, %rsi
               	movl	(%rsi), %esi
               	xorq	%rsi, %rdx
               	movl	%edx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %edx
               	movq	%rcx, %rsi
               	addq	$0x8, %rsi
               	movl	(%rsi), %esi
               	xorq	%rsi, %rdx
               	movl	%edx, (%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	(%rax), %edx
               	movl	$0xc, %esi
               	movq	%rcx, %rdi
               	addq	$0xc, %rdi
               	movl	(%rdi), %edi
               	xorq	%rdi, %rdx
               	movl	%edx, (%rax)
               	leaq	-0x28(%rbp), %rax
               	movl	(%rax), %edx
               	movq	%rcx, %rdi
               	addq	$0x10, %rdi
               	movl	(%rdi), %edi
               	xorq	%rdi, %rdx
               	movl	%edx, (%rax)
               	leaq	-0x30(%rbp), %rax
               	movl	(%rax), %edx
               	addq	$0x14, %rcx
               	movl	(%rcx), %ecx
               	xorq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	movl	-0x8(%rbp), %eax
               	movl	$0xec7ac69c, %ecx       # imm = 0xEC7AC69C
               	andq	%rax, %rcx
               	movl	$0xefa72c4d, %r13d      # imm = 0xEFA72C4D
               	xorq	%r13, %rcx
               	movq	%rax, %rdx
               	andq	$0x500fb821, %rdx       # imm = 0x500FB821
               	movl	$0xaeaaedff, %r13d      # imm = 0xAEAAEDFF
               	xorq	%r13, %rdx
               	movq	%rax, %rdi
               	andq	$0x40efa809, %rdi       # imm = 0x40EFA809
               	xorq	$0x37396665, %rdi       # imm = 0x37396665
               	movl	$0xa5ec0b28, %r8d       # imm = 0xA5EC0B28
               	andq	%rax, %r8
               	xorq	$0x68d7b833, %r8        # imm = 0x68D7B833
               	movq	%rax, %r9
               	andq	$0x252cf820, %r9        # imm = 0x252CF820
               	movl	$0xc9c755bb, %r13d      # imm = 0xC9C755BB
               	xorq	%r13, %r9
               	movq	%rax, %r11
               	andq	$0x40205801, %r11       # imm = 0x40205801
               	xorq	$0x73fc3606, %r11       # imm = 0x73FC3606
               	movl	$0xe220f929, %ebx       # imm = 0xE220F929
               	andq	%rax, %rbx
               	movl	$0xa2a0a918, %r13d      # imm = 0xA2A0A918
               	xorq	%r13, %rbx
               	movq	%rax, %r12
               	andq	$0x44a3f9e1, %r12       # imm = 0x44A3F9E1
               	movl	$0x8222bd90, %r13d      # imm = 0x8222BD90
               	xorq	%r13, %r12
               	movq	%rax, %r14
               	andq	$0x794f104a, %r14       # imm = 0x794F104A
               	movl	$0xd6b6ac77, %r13d      # imm = 0xD6B6AC77
               	xorq	%r13, %r14
               	movq	%rax, %r15
               	andq	$0x26f320b, %r15        # imm = 0x26F320B
               	xorq	$0x3069300c, %r15       # imm = 0x3069300C
               	movq	%rax, %r10
               	andq	$0x7640b01a, %r10       # imm = 0x7640B01A
               	movq	%r10, 0x410(%rsp)
               	movq	0x410(%rsp), %r10
               	xorq	$0x6ce0d5cc, %r10       # imm = 0x6CE0D5CC
               	movq	%r10, 0x408(%rsp)
               	movq	%rax, %r10
               	andq	$0x238f1572, %r10       # imm = 0x238F1572
               	movq	%r10, 0x3e8(%rsp)
               	movq	0x3e8(%rsp), %r10
               	xorq	$0x59a9a22d, %r10       # imm = 0x59A9A22D
               	movq	%r10, 0x3e0(%rsp)
               	movq	%rax, %r10
               	andq	$0x7a63c083, %r10       # imm = 0x7A63C083
               	movq	%r10, 0x3c0(%rsp)
               	movq	0x3c0(%rsp), %r10
               	movl	$0xac6d0bd4, %r13d      # imm = 0xAC6D0BD4
               	xorq	%r13, %r10
               	movq	%r10, 0x3b8(%rsp)
               	movq	%rax, %r10
               	andq	$0x11cca000, %r10       # imm = 0x11CCA000
               	movq	%r10, 0x398(%rsp)
               	movq	0x398(%rsp), %r10
               	xorq	$0x21c83200, %r10       # imm = 0x21C83200
               	movq	%r10, 0x390(%rsp)
               	movq	%rax, %r10
               	andq	$0x202f69aa, %r10       # imm = 0x202F69AA
               	movq	%r10, 0x370(%rsp)
               	movq	0x370(%rsp), %r10
               	movl	$0xa0e62188, %r13d      # imm = 0xA0E62188
               	xorq	%r13, %r10
               	movq	%r10, 0x368(%rsp)
               	movq	%rax, %r10
               	andq	$0x51b33be9, %r10       # imm = 0x51B33BE9
               	movq	%r10, 0x348(%rsp)
               	movq	0x348(%rsp), %r10
               	movl	$0xaf7d655a, %r13d      # imm = 0xAF7D655A
               	xorq	%r13, %r10
               	movq	%r10, 0x340(%rsp)
               	movq	%rax, %r10
               	andq	$0x3b0fe8ae, %r10       # imm = 0x3B0FE8AE
               	movq	%r10, 0x320(%rsp)
               	movq	0x320(%rsp), %r10
               	movl	$0xf0168aa3, %r13d      # imm = 0xF0168AA3
               	xorq	%r13, %r10
               	movq	%r10, 0x318(%rsp)
               	movl	$0x90bf8816, %r10d      # imm = 0x90BF8816
               	andq	%rax, %r10
               	movq	%r10, 0x2f8(%rsp)
               	movq	0x2f8(%rsp), %r10
               	movl	$0x90aa30c6, %r13d      # imm = 0x90AA30C6
               	xorq	%r13, %r10
               	movq	%r10, 0x2f0(%rsp)
               	movq	%rax, %r10
               	andq	$0x9e34f9b, %r10        # imm = 0x9E34F9B
               	movq	%r10, 0x2d0(%rsp)
               	movq	0x2d0(%rsp), %r10
               	xorq	$0x5ab2750a, %r10       # imm = 0x5AB2750A
               	movq	%r10, 0x2c8(%rsp)
               	movq	%rax, %r10
               	andq	$0x103be88, %r10        # imm = 0x103BE88
               	movq	%r10, 0x2a8(%rsp)
               	movq	0x2a8(%rsp), %r10
               	xorq	$0x5391be65, %r10       # imm = 0x5391BE65
               	movq	%r10, 0x2a0(%rsp)
               	movq	%rax, %r10
               	andq	$0x49ac8e25, %r10       # imm = 0x49AC8E25
               	movq	%r10, 0x280(%rsp)
               	movq	0x280(%rsp), %r10
               	movl	$0x93372baf, %r13d      # imm = 0x93372BAF
               	xorq	%r13, %r10
               	movq	%r10, 0x278(%rsp)
               	movl	$0x922c313d, %r10d      # imm = 0x922C313D
               	andq	%rax, %r10
               	movq	%r10, 0x258(%rsp)
               	movq	0x258(%rsp), %r10
               	movl	$0xf288210c, %r13d      # imm = 0xF288210C
               	xorq	%r13, %r10
               	movq	%r10, 0x250(%rsp)
               	movq	%rax, %r10
               	andq	$0x70ef31b0, %r10       # imm = 0x70EF31B0
               	movq	%r10, 0x230(%rsp)
               	movq	0x230(%rsp), %r10
               	movl	$0x920af5c0, %r13d      # imm = 0x920AF5C0
               	xorq	%r13, %r10
               	movq	%r10, 0x228(%rsp)
               	movq	%rax, %r10
               	andq	$0x6a707100, %r10       # imm = 0x6A707100
               	movq	%r10, 0x208(%rsp)
               	movq	0x208(%rsp), %r10
               	xorq	$0x63d312c0, %r10       # imm = 0x63D312C0
               	movq	%r10, 0x200(%rsp)
               	movl	$0xb97c9011, %r10d      # imm = 0xB97C9011
               	andq	%rax, %r10
               	movq	%r10, 0x1e0(%rsp)
               	movq	0x1e0(%rsp), %r10
               	xorq	$0x537b3006, %r10       # imm = 0x537B3006
               	movq	%r10, 0x1d8(%rsp)
               	movl	$0xa320c959, %r10d      # imm = 0xA320C959
               	andq	%rax, %r10
               	movq	%r10, 0x1b8(%rsp)
               	movq	0x1b8(%rsp), %r10
               	movl	$0xa2efb0a5, %r13d      # imm = 0xA2EFB0A5
               	xorq	%r13, %r10
               	movq	%r10, 0x1b0(%rsp)
               	movq	%rax, %r10
               	andq	$0x6ea0ab4a, %r10       # imm = 0x6EA0AB4A
               	movq	%r10, 0x190(%rsp)
               	movq	0x190(%rsp), %r10
               	movl	$0xbc8f96a5, %r13d      # imm = 0xBC8F96A5
               	xorq	%r13, %r10
               	movq	%r10, 0x188(%rsp)
               	movq	%rax, %r10
               	andq	$0x6953ddf8, %r10       # imm = 0x6953DDF8
               	movq	%r10, 0x168(%rsp)
               	movq	0x168(%rsp), %r10
               	movl	$0xfad176a5, %r13d      # imm = 0xFAD176A5
               	xorq	%r13, %r10
               	movq	%r10, 0x160(%rsp)
               	movl	$0xf74f3e2b, %r10d      # imm = 0xF74F3E2B
               	andq	%rax, %r10
               	movq	%r10, 0x140(%rsp)
               	movq	0x140(%rsp), %r10
               	xorq	$0x665a14a3, %r10       # imm = 0x665A14A3
               	movq	%r10, 0x138(%rsp)
               	movl	$0xf0306cad, %r13d      # imm = 0xF0306CAD
               	andq	%r13, %rax
               	movl	$0xf2eff0cc, %r13d      # imm = 0xF2EFF0CC
               	xorq	%r13, %rax
               	movl	%ecx, %ecx
               	movl	-0x10(%rbp), %r10d
               	movq	%r10, 0x110(%rsp)
               	movl	%edx, %edx
               	movq	%rdx, %r10
               	movq	0x110(%rsp), %rdx
               	andq	%r10, %rdx
               	xorq	%rdx, %rcx
               	movl	%edi, %edx
               	movl	%r8d, %edi
               	movq	%rdi, %r10
               	movq	0x110(%rsp), %rdi
               	andq	%r10, %rdi
               	xorq	%rdi, %rdx
               	movl	%r9d, %edi
               	movl	%r11d, %r8d
               	movq	%r8, %r10
               	movq	0x110(%rsp), %r8
               	andq	%r10, %r8
               	xorq	%r8, %rdi
               	movl	%ebx, %r8d
               	movl	%r12d, %r9d
               	movq	%r9, %r10
               	movq	0x110(%rsp), %r9
               	andq	%r10, %r9
               	xorq	%r9, %r8
               	movl	%r14d, %r9d
               	movl	%r15d, %r11d
               	movq	%r11, %r10
               	movq	0x110(%rsp), %r11
               	andq	%r10, %r11
               	xorq	%r11, %r9
               	movq	0x408(%rsp), %r11
               	movl	%r11d, %r11d
               	movq	0x3e0(%rsp), %rbx
               	movl	%ebx, %ebx
               	movq	%rbx, %r10
               	movq	0x110(%rsp), %rbx
               	andq	%r10, %rbx
               	xorq	%rbx, %r11
               	movq	0x3b8(%rsp), %rbx
               	movl	%ebx, %ebx
               	movq	0x390(%rsp), %r12
               	movl	%r12d, %r12d
               	movq	%r12, %r10
               	movq	0x110(%rsp), %r12
               	andq	%r10, %r12
               	xorq	%r12, %rbx
               	movq	0x368(%rsp), %r12
               	movl	%r12d, %r12d
               	movq	0x340(%rsp), %r14
               	movl	%r14d, %r14d
               	movq	0x318(%rsp), %r15
               	movl	%r15d, %r15d
               	movq	%r15, %r10
               	movq	0x110(%rsp), %r15
               	andq	%r10, %r15
               	xorq	%r15, %r14
               	movq	0x2f0(%rsp), %r15
               	movl	%r15d, %r15d
               	movq	0x2c8(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x108(%rsp)
               	movq	0x110(%rsp), %r10
               	andq	0x108(%rsp), %r10
               	movq	%r10, 0x100(%rsp)
               	xorq	0x100(%rsp), %r15
               	movq	0x2a0(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0xf0(%rsp)
               	movq	0x278(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0xe8(%rsp)
               	movq	0x110(%rsp), %r10
               	andq	0xe8(%rsp), %r10
               	movq	%r10, 0xe0(%rsp)
               	movq	0xf0(%rsp), %r10
               	xorq	0xe0(%rsp), %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	0x250(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0xc8(%rsp)
               	movq	0x228(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0xc0(%rsp)
               	movq	0x110(%rsp), %r10
               	andq	0xc0(%rsp), %r10
               	movq	%r10, 0xb8(%rsp)
               	movq	0xc8(%rsp), %r10
               	xorq	0xb8(%rsp), %r10
               	movq	%r10, 0xb0(%rsp)
               	movq	0x200(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0xa0(%rsp)
               	movq	0x1d8(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x98(%rsp)
               	movq	0x110(%rsp), %r10
               	andq	0x98(%rsp), %r10
               	movq	%r10, 0x90(%rsp)
               	movq	0xa0(%rsp), %r10
               	xorq	0x90(%rsp), %r10
               	movq	%r10, 0x88(%rsp)
               	movq	0x1b0(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x78(%rsp)
               	movq	0x188(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x70(%rsp)
               	movq	0x110(%rsp), %r10
               	andq	0x70(%rsp), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x78(%rsp), %r10
               	xorq	0x68(%rsp), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x160(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x50(%rsp)
               	movq	0x138(%rsp), %r10
               	movl	%r10d, %r10d
               	movq	%r10, 0x48(%rsp)
               	movq	0x110(%rsp), %r10
               	andq	0x48(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x50(%rsp), %r10
               	xorq	0x40(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	movl	%eax, %eax
               	movl	%ecx, %ecx
               	movl	-0x18(%rbp), %r10d
               	movq	%r10, 0x20(%rsp)
               	movl	%edx, %edx
               	movq	%rdx, %r10
               	movq	0x20(%rsp), %rdx
               	andq	%r10, %rdx
               	xorq	%rdx, %rcx
               	movl	%edi, %edx
               	movl	%r8d, %edi
               	movq	%rdi, %r10
               	movq	0x20(%rsp), %rdi
               	andq	%r10, %rdi
               	xorq	%rdi, %rdx
               	movl	%r9d, %edi
               	movl	%r11d, %r8d
               	movq	%r8, %r10
               	movq	0x20(%rsp), %r8
               	andq	%r10, %r8
               	xorq	%r8, %rdi
               	movl	%ebx, %r8d
               	movl	%r12d, %r9d
               	movq	%r9, %r10
               	movq	0x20(%rsp), %r9
               	andq	%r10, %r9
               	xorq	%r9, %r8
               	movl	%r14d, %r9d
               	movl	%r15d, %r11d
               	movq	%r11, %r10
               	movq	0x20(%rsp), %r11
               	andq	%r10, %r11
               	xorq	%r11, %r9
               	movq	0xd8(%rsp), %r11
               	movl	%r11d, %r11d
               	movq	0xb0(%rsp), %rbx
               	movl	%ebx, %ebx
               	movq	%rbx, %r10
               	movq	0x20(%rsp), %rbx
               	andq	%r10, %rbx
               	xorq	%rbx, %r11
               	movq	0x88(%rsp), %rbx
               	movl	%ebx, %ebx
               	movq	0x60(%rsp), %r12
               	movl	%r12d, %r12d
               	movq	%r12, %r10
               	movq	0x20(%rsp), %r12
               	andq	%r10, %r12
               	xorq	%r12, %rbx
               	movq	0x38(%rsp), %r12
               	movl	%r12d, %r12d
               	movl	%eax, %eax
               	movq	%rax, %r10
               	movq	0x20(%rsp), %rax
               	andq	%r10, %rax
               	xorq	%r12, %rax
               	movl	%ecx, %ecx
               	movl	-0x20(%rbp), %r12d
               	movl	%edx, %edx
               	andq	%r12, %rdx
               	xorq	%rdx, %rcx
               	movl	%edi, %edx
               	movl	%r8d, %edi
               	andq	%r12, %rdi
               	xorq	%rdi, %rdx
               	movl	%r9d, %edi
               	movl	%r11d, %r8d
               	andq	%r12, %r8
               	xorq	%r8, %rdi
               	movl	%ebx, %r8d
               	movl	%eax, %eax
               	andq	%r12, %rax
               	xorq	%r8, %rax
               	movl	%ecx, %ecx
               	movl	-0x28(%rbp), %r8d
               	movl	%edx, %edx
               	andq	%r8, %rdx
               	xorq	%rdx, %rcx
               	movl	%edi, %edx
               	movl	%eax, %eax
               	andq	%r8, %rax
               	xorq	%rdx, %rax
               	movl	%ecx, %ecx
               	movl	-0x30(%rbp), %edx
               	movl	%eax, %eax
               	andq	%rdx, %rax
               	xorq	%rcx, %rax
               	movl	%eax, %ecx
               	andq	$0x4, %rcx
               	shlq	$0x3, %rcx
               	movl	%ecx, %ecx
               	movl	%ecx, -0x38(%rbp)
               	leaq	-0x38(%rbp), %rcx
               	movl	(%rcx), %edx
               	movl	%eax, %edi
               	andq	$0x4000, %rdi           # imm = 0x4000
               	shlq	$0x4, %rdi
               	movl	%edi, %edi
               	orq	%rdi, %rdx
               	movl	%edx, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	(%rcx), %edx
               	movl	%eax, %edi
               	andq	$0x12020120, %rdi       # imm = 0x12020120
               	movl	$0x5, %r8d
               	movl	%edi, %edi
               	movq	%rdi, %r9
               	pushq	%rcx
               	movq	%r8, %rcx
               	shlq	%cl, %r9
               	popq	%rcx
               	movl	%r9d, %r9d
               	movl	$0x20, %r11d
               	movq	%r8, %r10
               	movq	%r11, %r8
               	subq	%r10, %r8
               	movslq	%r8d, %r8
               	pushq	%rcx
               	movq	%r8, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	orq	%r9, %rdi
               	orq	%rdi, %rdx
               	movl	%edx, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	(%rcx), %edx
               	movl	%eax, %edi
               	andq	$0x100000, %rdi         # imm = 0x100000
               	shlq	$0x6, %rdi
               	movl	%edi, %edi
               	orq	%rdi, %rdx
               	movl	%edx, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	(%rcx), %edx
               	movl	%eax, %edi
               	andq	$0x8000, %rdi           # imm = 0x8000
               	shlq	$0x9, %rdi
               	movl	%edi, %edi
               	orq	%rdi, %rdx
               	movl	%edx, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	(%rcx), %edx
               	movl	%eax, %edi
               	andq	$0x4000000, %rdi        # imm = 0x4000000
               	shrq	$0x16, %rdi
               	orq	%rdi, %rdx
               	movl	%edx, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	(%rcx), %edx
               	movl	%eax, %edi
               	andq	$0x1, %rdi
               	shlq	$0xb, %rdi
               	movl	%edi, %edi
               	orq	%rdi, %rdx
               	movl	%edx, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	(%rcx), %edx
               	movl	%eax, %edi
               	andq	$0x20000200, %rdi       # imm = 0x20000200
               	movl	%edi, %edi
               	movq	%rdi, %r8
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shlq	%cl, %r8
               	popq	%rcx
               	movl	%r8d, %r8d
               	movl	$0x20, %r9d
               	movq	%rsi, %r10
               	movq	%r9, %rsi
               	subq	%r10, %rsi
               	movslq	%esi, %rsi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	orq	%r8, %rsi
               	orq	%rsi, %rdx
               	movl	%edx, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	(%rcx), %edx
               	movl	%eax, %esi
               	andq	$0x200000, %rsi         # imm = 0x200000
               	shrq	$0x13, %rsi
               	orq	%rsi, %rdx
               	movl	%edx, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	(%rcx), %edx
               	movl	%eax, %esi
               	andq	$0x40, %rsi
               	shlq	$0xe, %rsi
               	movl	%esi, %esi
               	orq	%rsi, %rdx
               	movl	%edx, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	(%rcx), %edx
               	movl	%eax, %esi
               	andq	$0x10000, %rsi          # imm = 0x10000
               	shlq	$0xf, %rsi
               	movl	%esi, %esi
               	orq	%rsi, %rdx
               	movl	%edx, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	(%rcx), %edx
               	movl	%eax, %esi
               	andq	$0x2, %rsi
               	shlq	$0x10, %rsi
               	movl	%esi, %esi
               	orq	%rsi, %rdx
               	movl	%edx, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	(%rcx), %edx
               	movl	%eax, %esi
               	andq	$0x40801800, %rsi       # imm = 0x40801800
               	movl	$0x11, %edi
               	movl	%esi, %esi
               	movq	%rsi, %r8
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %r8
               	popq	%rcx
               	movl	%r8d, %r8d
               	movl	$0x20, %r9d
               	movq	%rdi, %r10
               	movq	%r9, %rdi
               	subq	%r10, %rdi
               	movslq	%edi, %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	orq	%r8, %rsi
               	orq	%rsi, %rdx
               	movl	%edx, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	(%rcx), %edx
               	movl	%eax, %esi
               	andq	$0x80000, %rsi          # imm = 0x80000
               	shrq	$0xd, %rsi
               	orq	%rsi, %rdx
               	movl	%edx, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	(%rcx), %edx
               	movl	%eax, %esi
               	andq	$0x10, %rsi
               	shlq	$0x15, %rsi
               	movl	%esi, %esi
               	orq	%rsi, %rdx
               	movl	%edx, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	(%rcx), %edx
               	movl	%eax, %esi
               	andq	$0x1000000, %rsi        # imm = 0x1000000
               	shrq	$0xa, %rsi
               	orq	%rsi, %rdx
               	movl	%edx, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	(%rcx), %edx
               	movl	%eax, %esi
               	movl	$0x88000008, %r13d      # imm = 0x88000008
               	andq	%r13, %rsi
               	movl	$0x18, %edi
               	movl	%esi, %esi
               	movq	%rsi, %r8
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %r8
               	popq	%rcx
               	movl	%r8d, %r8d
               	movl	$0x20, %r9d
               	movq	%rdi, %r10
               	movq	%r9, %rdi
               	subq	%r10, %rdi
               	movslq	%edi, %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	orq	%r8, %rsi
               	orq	%rsi, %rdx
               	movl	%edx, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	(%rcx), %edx
               	movl	%eax, %esi
               	andq	$0x480, %rsi            # imm = 0x480
               	shrq	$0x7, %rsi
               	orq	%rsi, %rdx
               	movl	%edx, (%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movl	(%rcx), %edx
               	movl	%eax, %eax
               	andq	$0x442000, %rax         # imm = 0x442000
               	shrq	$0x6, %rax
               	orq	%rdx, %rax
               	movl	%eax, (%rcx)
               	movl	-0x38(%rbp), %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x570, %rsp            # imm = 0x570
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	xorq	%rax, %rax
               	movl	%eax, -0x8(%rbp)
               	movl	$0xa5a5a5a5, %ebx       # imm = 0xA5A5A5A5
               	movl	%eax, -0x18(%rbp)
               	jmp	<addr>
               	movslq	-0x18(%rbp), %rax
               	cmpq	$0x10, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r12
               	movl	(%r12), %r14d
               	movl	%ebx, %edi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	xorq	%r14, %rax
               	movl	%eax, (%r12)
               	movl	%ebx, %eax
               	imulq	$0x19660d, %rax, %rax   # imm = 0x19660D
               	movl	%eax, %eax
               	addq	$0x3c6ef35f, %rax       # imm = 0x3C6EF35F
               	movl	%eax, %ebx
               	jmp	<addr>
               	movl	-0x8(%rbp), %eax
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
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
