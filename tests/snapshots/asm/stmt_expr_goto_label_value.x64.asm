
stmt_expr_goto_label_value.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<find_next>:
               	cmpq	%rsi, %rdx
               	jb	<addr>
               	movq	%rsi, %rax
               	retq
               	movq	%rdx, %rax
               	shrq	$0x6, %rax
               	movq	(%rdi,%rax,8), %rcx
               	movabsq	$-0x1, %r8
               	andq	$0x3f, %rdx
               	movq	%rdx, %r10
               	movq	%r8, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	andq	%rdx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rax), %rcx
               	shlq	$0x6, %rcx
               	cmpq	%rsi, %rcx
               	jae	<addr>
               	incq	%rax
               	movq	(%rdi,%rax,8), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rax, %rdx
               	shlq	$0x6, %rdx
               	leaq	-0x1(%rcx), %rax
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	%rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	andq	%r11, %rcx
               	subq	%rcx, %rax
               	movabsq	$0x3333333333333333, %rcx # imm = 0x3333333333333333
               	andq	%rax, %rcx
               	shrq	$0x2, %rax
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	andq	%r11, %rax
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	addq	%rcx, %rax
               	movabsq	$0xf0f0f0f0f0f0f0f, %r11 # imm = 0xF0F0F0F0F0F0F0F
               	andq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	addq	%rcx, %rax
               	andq	$0x7f, %rax
               	addq	%rdx, %rax
               	cmpq	%rsi, %rax
               	jbe	<addr>
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xe0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movl	$0xa, %eax
               	movl	$0x3, %eax
               	movl	$0x6, %eax
               	movl	$0x74, %eax
               	movl	$0x5, %eax
               	movl	$0xf, %eax
               	xorq	%rax, %rax
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movl	$0x64, %r14d
               	xorq	%rbx, %rbx
               	leaq	-0x28(%rbp), %rdi
               	movq	%r14, %rsi
               	movq	%rbx, %rdx
               	callq	<addr>
               	movq	%rbx, %r12
               	movq	%rbx, %r13
               	cmpq	$0x64, %rax
               	setb	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpq	$0xc8, %rbx
               	setb	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	incq	%r13
               	addq	%rax, %r12
               	leaq	-0x28(%rbp), %rdi
               	leaq	0x1(%rax), %rdx
               	movq	%r14, %rsi
               	callq	<addr>
               	incq	%rbx
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$0x5, %r13
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0xcb, %r12
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rdi
               	movl	$0x64, %edx
               	movq	%r14, %rsi
               	callq	<addr>
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rdi
               	movl	$0x2bc, %edx            # imm = 0x2BC
               	movq	%r14, %rsi
               	callq	<addr>
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rdi
               	movl	$0x49, %edx
               	movq	%r14, %rsi
               	callq	<addr>
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
