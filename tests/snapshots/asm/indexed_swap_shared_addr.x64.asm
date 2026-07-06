
indexed_swap_shared_addr.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<swap>:
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	movq	(%rdi,%rsi,8), %rax
               	movq	(%rdi,%rdx,8), %rcx
               	movq	%rcx, (%rdi,%rsi,8)
               	movq	%rax, (%rdi,%rdx,8)
               	xorq	%rax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x28(%rbp), %rax
               	addq	$0x0, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	leaq	-0x28(%rbp), %rax
               	movl	$0x2, %ecx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x28(%rbp), %rax
               	movl	$0x3, %ecx
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x28(%rbp), %rax
               	movl	$0x4, %ecx
               	movq	%rcx, 0x18(%rax)
               	leaq	-0x28(%rbp), %rax
               	movl	$0x5, %ecx
               	movq	%rcx, 0x20(%rax)
               	leaq	-0x28(%rbp), %rdi
               	xorq	%rbx, %rbx
               	movl	$0x4, %edx
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	-0x28(%rbp), %rax
               	leaq	0x8(%rax), %rdi
               	movl	$0x2, %edx
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	-0x28(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x5, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0x4, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movq	0x10(%rax), %rax
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movq	0x18(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movq	0x20(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
