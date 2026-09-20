
logical_immediate_masks.x64:	file format elf64-x86-64

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

<ref_and>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	andq	%rdi, %rax
               	leave
               	retq

<ref_or>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	orq	%rdi, %rax
               	leave
               	retq

<ref_xor>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	xorq	%rdi, %rax
               	leave
               	retq

<ref_and32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%esi, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	andq	%rdi, %rax
               	leave
               	retq

<ref_or32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%esi, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	orq	%rdi, %rax
               	leave
               	retq

<ref_xor32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%esi, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	xorq	%rdi, %rax
               	leave
               	retq

<and_e64>:
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	retq

<or_e8>:
               	movabsq	$-0xf0f0f0f0f0f0f10, %rax # imm = 0xF0F0F0F0F0F0F0F0
               	orq	%rdi, %rax
               	retq

<xor_top>:
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	xorq	%rdi, %rax
               	retq

<and_align>:
               	movq	%rdi, %rax
               	andq	$-0x10, %rax
               	retq

<or_wrap>:
               	movabsq	$-0xffffffffffff01, %rax # imm = 0xFF000000000000FF
               	orq	%rdi, %rax
               	retq

<xor_e2>:
               	movabsq	$0x5555555555555555, %rax # imm = 0x5555555555555555
               	xorq	%rdi, %rax
               	retq

<and_e4>:
               	movabsq	$0x7777777777777777, %rax # imm = 0x7777777777777777
               	andq	%rdi, %rax
               	retq

<and_e16>:
               	movabsq	$0xff00ff00ff00ff, %rax # imm = 0xFF00FF00FF00FF
               	andq	%rdi, %rax
               	retq

<or_e32>:
               	movabsq	$0xffff0000ffff, %rax   # imm = 0xFFFF0000FFFF
               	orq	%rdi, %rax
               	retq

<xor_run>:
               	movabsq	$0xffffff00000, %rax    # imm = 0xFFFFFF00000
               	xorq	%rdi, %rax
               	retq

<and32_e8>:
               	movq	%rdi, %rax
               	andq	$0xf0f0f0f, %rax        # imm = 0xF0F0F0F
               	retq

<or32_top>:
               	movl	$0x80000000, %eax       # imm = 0x80000000
               	orq	%rdi, %rax
               	retq

<xor32_e16>:
               	movq	%rdi, %rax
               	xorq	$0xff00ff, %rax         # imm = 0xFF00FF
               	retq

<and32_neg>:
               	movq	%rdi, %rax
               	andq	$-0x100, %rax
               	retq

<xor32_e2>:
               	movq	%rdi, %rax
               	xorq	$0x55555555, %rax       # imm = 0x55555555
               	retq

<or32_e4>:
               	movq	%rdi, %rax
               	orq	$0x33333333, %rax       # imm = 0x33333333
               	retq

<and_plain>:
               	movq	%rdi, %rax
               	andq	$0x1234, %rax           # imm = 0x1234
               	retq

<or_plain>:
               	movq	%rdi, %rax
               	orq	$0x12345678, %rax       # imm = 0x12345678
               	retq

<xor_plain>:
               	movq	%rdi, %rax
               	xorq	$0x5, %rax
               	retq

<mix_loop>:
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	movabsq	$-0xff00ff00ff0100, %rdx # imm = 0xFF00FF00FF00FF00
               	cmpl	%esi, %ecx
               	jge	<addr>
               	movq	%rax, %r8
               	rorq	$0x39, %r8
               	movq	(%rdi,%rcx,8), %rax
               	movq	%rax, %r9
               	andq	%rdx, %r9
               	xorq	%r9, %r8
               	orq	$0x10, %r8
               	andq	$0x1234, %rax           # imm = 0x1234
               	xorq	%r8, %rax
               	incq	%rcx
               	cmpl	%esi, %ecx
               	jl	<addr>
               	retq

<classify>:
               	xorl	%eax, %eax
               	testb	$0x40, %dil
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rdi, %rcx
               	andq	$0xf0, %rcx
               	cmpl	$0x30, %ecx
               	jne	<addr>
               	orq	$0x2, %rax
               	btq	$0x3f, %rdi
               	jb	<addr>
               	orq	$0x4, %rax
               	testl	$0xf0f0f0f, %edi        # imm = 0xF0F0F0F
               	je	<addr>
               	orq	$0x8, %rax
               	retq

<update>:
               	movq	%rsi, %rax
               	andq	$0x1f, %rax
               	movl	(%rdi), %ecx
               	andq	$-0xf9, %rcx
               	shlq	$0x3, %rax
               	orq	%rcx, %rax
               	movl	%eax, (%rdi)
               	movl	(%rdi), %eax
               	sarq	$0x10, %rax
               	xorq	%rsi, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movl	(%rdi), %ecx
               	movabsq	$-0xffff0001, %r11      # imm = 0xFFFFFFFF0000FFFF
               	andq	%r11, %rcx
               	shlq	$0x10, %rax
               	orq	%rcx, %rax
               	movl	%eax, (%rdi)
               	movl	(%rdi), %eax
               	andq	$0x7, %rax
               	movl	(%rdi), %ecx
               	sarq	$0x3, %rcx
               	andq	$0x1f, %rcx
               	addq	%rcx, %rax
               	movl	(%rdi), %ecx
               	sarq	$0x8, %rcx
               	andq	$0xff, %rcx
               	addq	%rcx, %rax
               	movl	(%rdi), %ecx
               	sarq	$0x10, %rcx
               	addq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r12d, %r12d
               	leaq	<rip>, %rax
               	movq	(%rax,%r12,8), %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movl	$0xff, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movabsq	$-0xf0f0f0f0f0f0f10, %rsi # imm = 0xF0F0F0F0F0F0F0F0
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movabsq	$-0x8000000000000000, %rsi # imm = 0x8000000000000000
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	$-0x10, %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movabsq	$-0xffffffffffff01, %rsi # imm = 0xFF000000000000FF
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movabsq	$0x5555555555555555, %rsi # imm = 0x5555555555555555
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movabsq	$0x7777777777777777, %rsi # imm = 0x7777777777777777
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movabsq	$0xff00ff00ff00ff, %rsi # imm = 0xFF00FF00FF00FF
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movabsq	$0xffff0000ffff, %rsi   # imm = 0xFFFF0000FFFF
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movabsq	$0xffffff00000, %rsi    # imm = 0xFFFFFF00000
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	movl	%ebx, %edi
               	callq	<addr>
               	movq	%rax, %r13
               	movl	%ebx, %edi
               	movl	$0xf0f0f0f, %esi        # imm = 0xF0F0F0F
               	callq	<addr>
               	cmpl	%eax, %r13d
               	jne	<addr>
               	movl	%ebx, %edi
               	callq	<addr>
               	movq	%rax, %r13
               	movl	%ebx, %edi
               	movl	$0x80000000, %esi       # imm = 0x80000000
               	callq	<addr>
               	cmpl	%eax, %r13d
               	jne	<addr>
               	movl	%ebx, %edi
               	callq	<addr>
               	movq	%rax, %r13
               	movl	%ebx, %edi
               	movl	$0xff00ff, %esi         # imm = 0xFF00FF
               	callq	<addr>
               	cmpl	%eax, %r13d
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movl	%ebx, %edi
               	movl	$0xffffff00, %esi       # imm = 0xFFFFFF00
               	callq	<addr>
               	cmpl	%eax, %r13d
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movl	%ebx, %edi
               	movl	$0x55555555, %esi       # imm = 0x55555555
               	callq	<addr>
               	cmpl	%eax, %r13d
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movl	%ebx, %edi
               	movl	$0x33333333, %esi       # imm = 0x33333333
               	callq	<addr>
               	cmpl	%eax, %r13d
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movl	$0x1234, %esi           # imm = 0x1234
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movl	$0x12345678, %esi       # imm = 0x12345678
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movl	$0x5, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	$0x40, -0x20(%rbp)
               	movq	$0xf0, -0x18(%rbp)
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movq	%rcx, -0x10(%rbp)
               	movl	$0xf0f0f0f, -0x8(%rbp)  # imm = 0xF0F0F0F
               	xorl	%ecx, %ecx
               	movq	-0x20(%rbp), %rdx
               	andq	%rbx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %ecx
               	movq	-0x18(%rbp), %rdx
               	andq	%rbx, %rdx
               	cmpq	$0x30, %rdx
               	jne	<addr>
               	orq	$0x2, %rcx
               	movq	-0x10(%rbp), %rdx
               	andq	%rbx, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	orq	$0x4, %rcx
               	movl	%ebx, %edx
               	movl	-0x8(%rbp), %esi
               	andq	%rsi, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	orq	$0x8, %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	incq	%r12
               	cmpl	$0x8, %r12d
               	jl	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x8, %esi
               	callq	<addr>
               	leaq	<rip>, %rsi
               	movabsq	$-0xff00ff00ff0100, %rcx # imm = 0xFF00FF00FF00FF00
               	movq	%rcx, -0x20(%rbp)
               	movq	$0x10, -0x18(%rbp)
               	movq	$0x1234, -0x10(%rbp)    # imm = 0x1234
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	movq	%rdx, %rdi
               	rorq	$0x39, %rdi
               	movq	(%rsi,%rcx,8), %rdx
               	movq	-0x20(%rbp), %r8
               	andq	%rdx, %r8
               	xorq	%r8, %rdi
               	movq	-0x18(%rbp), %r8
               	orq	%r8, %rdi
               	movq	-0x10(%rbp), %r8
               	andq	%r8, %rdx
               	xorq	%rdi, %rdx
               	incq	%rcx
               	cmpl	$0x8, %ecx
               	jl	<addr>
               	cmpq	%rdx, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movabsq	$0x123456789abcdef, %rdi # imm = 0x123456789ABCDEF
               	callq	<addr>
               	cmpq	$0xef, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movabsq	$0x123456789abcdef, %rdi # imm = 0x123456789ABCDEF
               	callq	<addr>
               	movabsq	$-0xe0c0a0806040201, %r11 # imm = 0xF1F3F5F7F9FBFDFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movabsq	$0x123456789abcdef, %rdi # imm = 0x123456789ABCDEF
               	callq	<addr>
               	movabsq	$-0x7edcba9876543211, %r11 # imm = 0x8123456789ABCDEF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x89abcdef, %edi       # imm = 0x89ABCDEF
               	callq	<addr>
               	cmpl	$0x90b0d0f, %eax        # imm = 0x90B0D0F
               	je	<addr>
               	movl	$0x19, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	-0x30(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movzbq	(%rax), %rcx
               	movb	%cl, (%rdi)
               	movzbq	0x1(%rax), %rcx
               	movb	%cl, 0x1(%rdi)
               	movzbq	0x2(%rax), %rcx
               	movb	%cl, 0x2(%rdi)
               	movzbq	0x3(%rax), %rcx
               	movb	%cl, 0x3(%rdi)
               	popq	%rcx
               	movl	$0x12345, -0x28(%rbp)   # imm = 0x12345
               	movl	-0x28(%rbp), %esi
               	callq	<addr>
               	leaq	-0x30(%rbp), %rcx
               	movl	(%rcx), %edx
               	andq	$0x7, %rdx
               	cmpl	$0x5, %edx
               	jne	<addr>
               	movl	(%rcx), %edx
               	sarq	$0x3, %rdx
               	andq	$0x1f, %rdx
               	cmpl	$0x5, %edx
               	jne	<addr>
               	movl	(%rcx), %edx
               	sarq	$0x8, %rdx
               	andq	$0xff, %rdx
               	cmpl	$0xc8, %edx
               	jne	<addr>
               	movl	(%rcx), %edx
               	sarq	$0x10, %rdx
               	cmpl	$0x9daa, %edx           # imm = 0x9DAA
               	je	<addr>
               	movl	$0x1a, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	(%rcx), %ecx
               	movq	%rcx, %rdx
               	andq	$0x7, %rdx
               	movq	%rcx, %rsi
               	sarq	$0x3, %rsi
               	andq	$0x1f, %rsi
               	addq	%rsi, %rdx
               	sarq	$0x8, %rcx
               	andq	$0xff, %rcx
               	addq	%rdx, %rcx
               	movl	-0x30(%rbp), %edx
               	sarq	$0x10, %rdx
               	addq	%rdx, %rcx
               	xorq	%rcx, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1b, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x14, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x13, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x12, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x11, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x10, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0xf, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
