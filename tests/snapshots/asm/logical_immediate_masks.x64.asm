
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
               	movl	%eax, %eax
               	leave
               	retq

<ref_xor32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%esi, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	xorq	%rdi, %rax
               	movl	%eax, %eax
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
               	movl	%eax, %eax
               	retq

<xor32_e16>:
               	movq	%rdi, %rax
               	xorq	$0xff00ff, %rax         # imm = 0xFF00FF
               	movl	%eax, %eax
               	retq

<and32_neg>:
               	movq	%rdi, %rax
               	andq	$-0x100, %rax
               	movslq	%eax, %rax
               	retq

<xor32_e2>:
               	movq	%rdi, %rax
               	xorq	$0x55555555, %rax       # imm = 0x55555555
               	movslq	%eax, %rax
               	retq

<or32_e4>:
               	movq	%rdi, %rax
               	orq	$0x33333333, %rax       # imm = 0x33333333
               	movslq	%eax, %rax
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
               	movl	$0x1, %ecx
               	xorl	%eax, %eax
               	movabsq	$-0xff00ff00ff0100, %rdx # imm = 0xFF00FF00FF00FF00
               	cmpl	%esi, %eax
               	jge	<addr>
               	movq	%rcx, %r8
               	rorq	$0x39, %r8
               	movq	(%rdi,%rax,8), %rcx
               	movq	%rcx, %r9
               	andq	%rdx, %r9
               	xorq	%r9, %r8
               	orq	$0x10, %r8
               	andq	$0x1234, %rcx           # imm = 0x1234
               	xorq	%r8, %rcx
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	retq

<classify>:
               	xorl	%eax, %eax
               	movq	%rdi, %rcx
               	andq	$0x40, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rdi, %rcx
               	andq	$0xf0, %rcx
               	cmpl	$0x30, %ecx
               	jne	<addr>
               	orq	$0x2, %rax
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	andq	%rdi, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	orq	$0x4, %rax
               	movq	%rdi, %rcx
               	andq	$0xf0f0f0f, %rcx        # imm = 0xF0F0F0F
               	testq	%rcx, %rcx
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
               	cmpl	$0x8, %r12d
               	jge	<addr>
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
               	cmpq	%rax, %r13
               	jne	<addr>
               	movl	%ebx, %edi
               	callq	<addr>
               	movq	%rax, %r13
               	movl	%ebx, %edi
               	movl	$0x80000000, %esi       # imm = 0x80000000
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	movl	%ebx, %edi
               	callq	<addr>
               	movq	%rax, %r13
               	movl	%ebx, %edi
               	movl	$0xff00ff, %esi         # imm = 0xFF00FF
               	callq	<addr>
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movl	%ebx, %edi
               	movl	$0xffffff00, %esi       # imm = 0xFFFFFF00
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movl	%ebx, %edi
               	movl	$0x55555555, %esi       # imm = 0x55555555
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	%rax, %r13
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movl	%ebx, %edi
               	movl	$0x33333333, %esi       # imm = 0x33333333
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	%rax, %r13
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
               	movq	%rax, %rdx
               	movl	$0x40, %eax
               	movq	%rax, -0x28(%rbp)
               	movl	$0xf0, %eax
               	movq	%rax, -0x20(%rbp)
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movq	%rax, -0x18(%rbp)
               	movl	$0xf0f0f0f, %eax        # imm = 0xF0F0F0F
               	movl	%eax, -0x10(%rbp)
               	xorl	%eax, %eax
               	movq	-0x28(%rbp), %rcx
               	andq	%rbx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	-0x20(%rbp), %rcx
               	andq	%rbx, %rcx
               	cmpq	$0x30, %rcx
               	jne	<addr>
               	orq	$0x2, %rax
               	movq	-0x18(%rbp), %rcx
               	andq	%rbx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	orq	$0x4, %rax
               	movl	%ebx, %ecx
               	movl	-0x10(%rbp), %esi
               	andq	%rsi, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	orq	$0x8, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	incq	%r12
               	cmpl	$0x8, %r12d
               	jl	<addr>
               	leaq	<rip>, %rbx
               	movl	$0x8, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %rdi
               	movabsq	$-0xff00ff00ff0100, %rax # imm = 0xFF00FF00FF00FF00
               	movq	%rax, -0x28(%rbp)
               	movl	$0x10, %eax
               	movq	%rax, -0x20(%rbp)
               	movl	$0x1234, %eax           # imm = 0x1234
               	movq	%rax, -0x18(%rbp)
               	movl	$0x1, %ecx
               	xorl	%eax, %eax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movq	%rcx, %rdx
               	rorq	$0x39, %rdx
               	movq	(%rbx,%rax,8), %rcx
               	movq	-0x28(%rbp), %rsi
               	andq	%rcx, %rsi
               	xorq	%rsi, %rdx
               	movq	-0x20(%rbp), %rsi
               	orq	%rsi, %rdx
               	movq	-0x18(%rbp), %rsi
               	andq	%rsi, %rcx
               	xorq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	cmpq	%rcx, %rdi
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
               	cmpq	$0x90b0d0f, %rax        # imm = 0x90B0D0F
               	je	<addr>
               	movl	$0x19, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	-0x8(%rbp), %rdi
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
               	movl	$0x12345, %eax          # imm = 0x12345
               	movl	%eax, -0x30(%rbp)
               	movl	-0x30(%rbp), %esi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$0x7, %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movl	(%rax), %ecx
               	sarq	$0x3, %rcx
               	andq	$0x1f, %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movl	(%rax), %ecx
               	sarq	$0x8, %rcx
               	andq	$0xff, %rcx
               	cmpl	$0xc8, %ecx
               	jne	<addr>
               	movl	(%rax), %ecx
               	sarq	$0x10, %rcx
               	cmpl	$0x9daa, %ecx           # imm = 0x9DAA
               	je	<addr>
               	movl	$0x1a, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	(%rax), %ecx
               	movq	%rcx, %rdx
               	andq	$0x7, %rdx
               	movq	%rcx, %rdi
               	sarq	$0x3, %rdi
               	andq	$0x1f, %rdi
               	addq	%rdi, %rdx
               	movq	%rcx, %rax
               	sarq	$0x8, %rax
               	andq	$0xff, %rax
               	addq	%rdx, %rax
               	leaq	-0x8(%rbp), %rcx
               	movl	(%rcx), %ecx
               	sarq	$0x10, %rcx
               	addq	%rcx, %rax
               	xorq	%rsi, %rax
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
