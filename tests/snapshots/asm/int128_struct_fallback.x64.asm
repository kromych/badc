
int128_struct_fallback.x64:	file format elf64-x86-64

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

<rt>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x180, %rsp            # imm = 0x180
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movabsq	$-0x1, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x1, %edi
               	callq	<addr>
               	leaq	(%r12,%rax), %rbx
               	cmpq	%r12, %rbx
               	setb	%al
               	movzbq	%al, %rax
               	leaq	(%rax), %r14
               	testq	%rbx, %rbx
               	jne	<addr>
               	cmpq	$0x1, %r14
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	xorq	%rdi, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x1, %r13d
               	movq	%r13, %rdi
               	callq	<addr>
               	movq	%rax, %r15
               	movq	%r13, %rdi
               	callq	<addr>
               	movq	%r12, %rcx
               	subq	%rax, %rcx
               	leaq	(%r15), %rdx
               	cmpq	%rax, %r12
               	setb	%al
               	movzbq	%al, %rax
               	subq	%rax, %rdx
               	cmpq	$-0x1, %rcx
               	jne	<addr>
               	testq	%rdx, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	xorq	$-0x1, %rax
               	incq	%rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	decq	%rcx
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	cmpq	$-0x1, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	xorq	%rcx, %rcx
               	movq	%rax, %rdx
               	shlq	$0x0, %rdx
               	leaq	-0x20(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, (%rax)
               	leaq	-0x20(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	0x8(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	xorq	%rcx, %rcx
               	movq	%rax, %rdx
               	shlq	$0x24, %rdx
               	leaq	-0x20(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, (%rax)
               	leaq	-0x20(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	0x8(%rax), %rax
               	movabsq	$0x1000000000, %r11     # imm = 0x1000000000
               	cmpq	%r11, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	xorq	%rdi, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movabsq	$-0x8000000000000000, %rdi # imm = 0x8000000000000000
               	callq	<addr>
               	movq	%r12, %rcx
               	shrq	$0x4, %rcx
               	movq	%rax, %rdx
               	shlq	$0x3c, %rdx
               	orq	%rcx, %rdx
               	movq	%rax, %rsi
               	sarq	$0x4, %rsi
               	leaq	-0x10(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rdx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movabsq	$-0x800000000000000, %r11 # imm = 0xF800000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	xorq	%rdi, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	%r12, %rbx
               	jne	<addr>
               	cmpq	%rax, %r14
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x9, %edi
               	callq	<addr>
               	cmpq	%rax, %rbx
               	setb	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x9, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	%rax, %rbx
               	setb	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
