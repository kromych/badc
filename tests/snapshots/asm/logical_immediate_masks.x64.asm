
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
               	movl	%esi, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	%edi, %eax
               	movl	-0x8(%rbp), %ecx
               	andq	%rcx, %rax
               	leave
               	retq

<ref_or32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%esi, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	%edi, %eax
               	movl	-0x8(%rbp), %ecx
               	orq	%rcx, %rax
               	leave
               	retq

<ref_xor32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%esi, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	%edi, %eax
               	movl	-0x8(%rbp), %ecx
               	xorq	%rcx, %rax
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
               	movl	%edi, %eax
               	andq	$0xf0f0f0f, %rax        # imm = 0xF0F0F0F
               	retq

<or32_top>:
               	movl	%edi, %eax
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	orq	%r11, %rax
               	retq

<xor32_e16>:
               	movl	%edi, %eax
               	xorq	$0xff00ff, %rax         # imm = 0xFF00FF
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
               	xorq	%rax, %rax
               	movabsq	$-0xff00ff00ff0100, %r8 # imm = 0xFF00FF00FF00FF00
               	jmp	<addr>
               	rorq	$0x39, %rcx
               	movslq	%eax, %rdx
               	movq	(%rdi,%rdx,8), %r9
               	andq	%r8, %r9
               	xorq	%r9, %rcx
               	orq	$0x10, %rcx
               	movq	(%rdi,%rdx,8), %r9
               	andq	$0x1234, %r9            # imm = 0x1234
               	xorq	%r9, %rcx
               	leaq	0x1(%rdx), %rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	retq

<classify>:
               	xorq	%rax, %rax
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
               	movslq	%eax, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<update>:
               	movl	%esi, %eax
               	movq	%rax, %rcx
               	andq	$0x1f, %rcx
               	movl	(%rdi), %edx
               	andq	$-0xf9, %rdx
               	shlq	$0x3, %rcx
               	orq	%rdx, %rcx
               	movl	%ecx, (%rdi)
               	movl	(%rdi), %ecx
               	sarq	$0x10, %rcx
               	xorq	%rcx, %rax
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
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	xorq	%r13, %r13
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movslq	%r13d, %rcx
               	movq	(%rax,%rcx,8), %rbx
               	movl	%ebx, %r12d
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	movl	$0xff, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r14
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	movabsq	$-0xf0f0f0f0f0f0f10, %rsi # imm = 0xF0F0F0F0F0F0F0F0
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r14
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	movabsq	$-0x8000000000000000, %rsi # imm = 0x8000000000000000
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r14
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	movabsq	$-0x10, %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r14
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	movabsq	$-0xffffffffffff01, %rsi # imm = 0xFF000000000000FF
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r14
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	movabsq	$0x5555555555555555, %rsi # imm = 0x5555555555555555
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r14
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	movabsq	$0x7777777777777777, %rsi # imm = 0x7777777777777777
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r14
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	movabsq	$0xff00ff00ff00ff, %rsi # imm = 0xFF00FF00FF00FF
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r14
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	movabsq	$0xffff0000ffff, %rsi   # imm = 0xFFFF0000FFFF
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r14
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	movabsq	$0xffffff00000, %rsi    # imm = 0xFFFFFF00000
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r14
               	jne	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	movl	$0xf0f0f0f, %esi        # imm = 0xF0F0F0F
               	movq	%r12, %rdi
               	callq	<addr>
               	cmpq	%rax, %r14
               	jne	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	movl	$0x80000000, %esi       # imm = 0x80000000
               	movq	%r12, %rdi
               	callq	<addr>
               	cmpq	%rax, %r14
               	jne	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	movl	$0xff00ff, %esi         # imm = 0xFF00FF
               	movq	%r12, %rdi
               	callq	<addr>
               	cmpq	%rax, %r14
               	jne	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	movl	$0xffffff00, %esi       # imm = 0xFFFFFF00
               	movq	%r12, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	%rax, %r14
               	jne	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	movl	$0x55555555, %esi       # imm = 0x55555555
               	movq	%r12, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	%rax, %r14
               	jne	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	movl	$0x33333333, %esi       # imm = 0x33333333
               	movq	%r12, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	%rax, %r14
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x1234, %esi           # imm = 0x1234
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r12
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x12345678, %esi       # imm = 0x12345678
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r12
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x5, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rax, %r12
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
               	xorq	%rax, %rax
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
               	movslq	%eax, %rax
               	cmpq	%rax, %rdx
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r13d, %rax
               	leaq	0x1(%rax), %r13
               	cmpl	$0x8, %r13d
               	jl	<addr>
               	leaq	<rip>, %rbx
               	movl	$0x8, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	movabsq	$-0xff00ff00ff0100, %rax # imm = 0xFF00FF00FF00FF00
               	movq	%rax, -0x28(%rbp)
               	movl	$0x10, %eax
               	movq	%rax, -0x20(%rbp)
               	movl	$0x1234, %eax           # imm = 0x1234
               	movq	%rax, -0x18(%rbp)
               	movl	$0x1, %ecx
               	xorq	%rax, %rax
               	jmp	<addr>
               	rorq	$0x39, %rcx
               	movslq	%eax, %rdx
               	movq	(%rbx,%rdx,8), %rsi
               	movq	-0x28(%rbp), %rdi
               	andq	%rdi, %rsi
               	xorq	%rsi, %rcx
               	movq	-0x20(%rbp), %rsi
               	orq	%rsi, %rcx
               	movq	(%rbx,%rdx,8), %rsi
               	movq	-0x18(%rbp), %rdi
               	andq	%rdi, %rsi
               	xorq	%rsi, %rcx
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	cmpq	%rcx, %r8
               	je	<addr>
               	movl	$0x15, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movabsq	$0x123456789abcdef, %rdi # imm = 0x123456789ABCDEF
               	callq	<addr>
               	cmpq	$0xef, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movabsq	$0x123456789abcdef, %rdi # imm = 0x123456789ABCDEF
               	callq	<addr>
               	movabsq	$-0xe0c0a0806040201, %r11 # imm = 0xF1F3F5F7F9FBFDFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movabsq	$0x123456789abcdef, %rdi # imm = 0x123456789ABCDEF
               	callq	<addr>
               	movabsq	$-0x7edcba9876543211, %r11 # imm = 0x8123456789ABCDEF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0x89abcdef, %edi       # imm = 0x89ABCDEF
               	callq	<addr>
               	cmpq	$0x90b0d0f, %rax        # imm = 0x90B0D0F
               	je	<addr>
               	movl	$0x19, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
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
               	movq	%rax, %rdx
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$0x7, %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movl	(%rax), %ecx
               	sarq	$0x3, %rcx
               	andq	$0x1f, %rcx
               	cmpl	$0x5, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	(%rax), %ecx
               	sarq	$0x8, %rcx
               	andq	$0xff, %rcx
               	cmpl	$0xc8, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	(%rax), %ecx
               	sarq	$0x10, %rcx
               	cmpl	$0x9daa, %ecx           # imm = 0x9DAA
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	%edx, %esi
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
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1b, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0x14, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0x13, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0x12, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0x11, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0x10, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
