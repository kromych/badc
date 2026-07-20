
constfold_post_inline.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
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
               	sarq	%rax
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
