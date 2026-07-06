
quicksort.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<swap>:
               	movslq	(%rdi), %rax
               	movslq	(%rsi), %rcx
               	movl	%ecx, (%rdi)
               	movl	%eax, (%rsi)
               	xorq	%rax, %rax
               	retq

<partition>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movq	%rdi, %r13
               	movq	%rdx, %r15
               	movq	%rsi, %r12
               	movslq	%r12d, %r12
               	movslq	%r15d, %r15
               	movslq	(%r13,%r15,4), %r14
               	leaq	-0x1(%r12), %rbx
               	jmp	<addr>
               	movslq	%r12d, %rax
               	movslq	(%r13,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	incq	%rbx
               	movslq	%ebx, %rax
               	shlq	$0x2, %rax
               	leaq	(%r13,%rax), %rdi
               	movslq	%r12d, %rax
               	shlq	$0x2, %rax
               	leaq	(%r13,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r12d, %rax
               	leaq	0x1(%rax), %r12
               	movslq	%r12d, %rax
               	cmpq	%r15, %rax
               	jl	<addr>
               	leaq	0x1(%rbx), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%r13,%rax), %rdi
               	movq	%r15, %rax
               	shlq	$0x2, %rax
               	leaq	(%r13,%rax), %rsi
               	callq	<addr>
               	leaq	0x1(%rbx), %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

<quicksort>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%rdi, %r12
               	movq	%rdx, %r14
               	movq	%rsi, %r13
               	movslq	%r13d, %r13
               	movslq	%r14d, %r14
               	cmpq	%r14, %r13
               	jge	<addr>
               	movq	%r12, %rdi
               	movq	%r14, %rdx
               	movq	%r13, %rsi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	-0x1(%rbx), %rdx
               	movq	%r12, %rdi
               	movq	%r13, %rsi
               	callq	<addr>
               	leaq	0x1(%rbx), %rsi
               	movq	%r12, %rdi
               	movq	%r14, %rdx
               	callq	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x14, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	xorq	%rsi, %rsi
               	movl	$0xc, %eax
               	movl	%eax, (%rbx)
               	movl	$0x4, %edx
               	movl	$0x7, %eax
               	movl	%eax, 0x4(%rbx)
               	movl	$0xf, %eax
               	movl	%eax, 0x8(%rbx)
               	movl	$0x5, %eax
               	movl	%eax, 0xc(%rbx)
               	movl	$0xa, %eax
               	movl	%eax, 0x10(%rbx)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	(%rbx), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movslq	0x4(%rbx), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movslq	0x8(%rbx), %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movslq	0xc(%rbx), %rax
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movslq	0x10(%rbx), %rax
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
