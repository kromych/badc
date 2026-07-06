
constfold_post_inline.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<add_u>:
               	leaq	(%rdi,%rsi), %rax
               	retq

<mul_u>:
               	movq	%rdi, %rax
               	imulq	%rsi, %rax
               	retq

<sub_i>:
               	movq	%rdi, %rax
               	subq	%rsi, %rax
               	retq

<shl_u>:
               	movslq	%esi, %rsi
               	movq	%rdi, %rax
               	movq	%rsi, %rcx
               	shlq	%cl, %rax
               	retq

<shr_u>:
               	movslq	%esi, %rsi
               	movq	%rdi, %rax
               	movq	%rsi, %rcx
               	shrq	%cl, %rax
               	retq

<shr_i>:
               	movslq	%esi, %rsi
               	movq	%rdi, %rax
               	movq	%rsi, %rcx
               	sarq	%cl, %rax
               	retq

<div_u>:
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	popq	%rdx
               	retq

<mod_u>:
               	pushq	%rdx
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	retq

<div_i>:
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	popq	%rdx
               	retq

<mod_i>:
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	popq	%rdx
               	retq

<ror_u>:
               	movslq	%esi, %rsi
               	movq	%rdi, %rax
               	pushq	%rcx
               	movq	%rsi, %rcx
               	rorq	%cl, %rax
               	popq	%rcx
               	retq

<lt_i>:
               	cmpq	%rsi, %rdi
               	setl	%al
               	movzbq	%al, %rax
               	retq

<gt_i>:
               	cmpq	%rsi, %rdi
               	setg	%al
               	movzbq	%al, %rax
               	retq

<le_i>:
               	cmpq	%rsi, %rdi
               	setle	%al
               	movzbq	%al, %rax
               	retq

<ge_i>:
               	cmpq	%rsi, %rdi
               	setge	%al
               	movzbq	%al, %rax
               	retq

<lt_u>:
               	cmpq	%rsi, %rdi
               	setb	%al
               	movzbq	%al, %rax
               	retq

<gt_u>:
               	cmpq	%rsi, %rdi
               	seta	%al
               	movzbq	%al, %rax
               	retq

<le_u>:
               	cmpq	%rsi, %rdi
               	setbe	%al
               	movzbq	%al, %rax
               	retq

<ge_u>:
               	cmpq	%rsi, %rdi
               	setae	%al
               	movzbq	%al, %rax
               	retq

<eq_i>:
               	cmpq	%rsi, %rdi
               	sete	%al
               	movzbq	%al, %rax
               	retq

<ne_i>:
               	cmpq	%rsi, %rdi
               	setne	%al
               	movzbq	%al, %rax
               	retq

<sext8>:
               	movq	%rdi, %rax
               	movsbq	%al, %rax
               	retq

<sext16>:
               	movq	%rdi, %rax
               	movswq	%ax, %rax
               	retq

<sext32>:
               	movq	%rdi, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x19, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1a, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1b, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1c, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1d, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x123456789abcdef, %rax # imm = 0x123456789ABCDEF
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	leaq	0x5(%rax), %rcx
               	movabsq	$0x123456789abcdf4, %r11 # imm = 0x123456789ABCDF4
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x24, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	0x5(%rax), %rcx
               	movabsq	$0x123456789abcdf4, %r11 # imm = 0x123456789ABCDF4
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x25, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x64, %rax
               	seta	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x26, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x64, %rax
               	jae	<addr>
               	movl	$0x27, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	cmpq	$-0x1, %rax
               	setbe	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x28, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	rorq	$0x7, %rcx
               	movabsq	$-0x21fdb97530eca865, %r11 # imm = 0xDE02468ACF13579B
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x29, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	pushq	%rcx
               	movl	$0x41, %ecx
               	shlq	%cl, %rax
               	popq	%rcx
               	movabsq	$0x2468acf13579bde, %r11 # imm = 0x2468ACF13579BDE
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2a, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x8, %rax
               	movq	%rax, -0x18(%rbp)
               	movq	-0x18(%rbp), %rax
               	sarq	$0x1, %rax
               	cmpq	$-0x4, %rax
               	je	<addr>
               	movl	$0x2b, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x6, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x8, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x9, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0xb, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0xc, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0xd, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0xe, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0xf, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x10, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x11, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x12, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x13, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1e, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1f, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x20, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x21, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x22, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x23, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
