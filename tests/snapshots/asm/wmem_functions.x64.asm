
wmem_functions.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x30(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	movzbq	0x10(%rax), %rcx
               	movb	%cl, 0x10(%rdi)
               	movzbq	0x11(%rax), %rcx
               	movb	%cl, 0x11(%rdi)
               	movzbq	0x12(%rax), %rcx
               	movb	%cl, 0x12(%rdi)
               	movzbq	0x13(%rax), %rcx
               	movb	%cl, 0x13(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	movl	$0x1e, %esi
               	movl	$0x5, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x30(%rbp), %rdi
               	leaq	0x8(%rdi), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x63, %esi
               	movl	$0x5, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rdi
               	leaq	-0x30(%rbp), %rsi
               	movl	$0x5, %ebx
               	movq	%rbx, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x18(%rbp), %rdi
               	leaq	-0x30(%rbp), %rsi
               	movq	%rbx, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rbx
               	movl	$0x7, %esi
               	movl	$0x3, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	(%rbx), %rax
               	cmpl	$0x7, %eax
               	movl	$0x1, %eax
               	jne	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpl	$0x7, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x7, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	cmpl	$0x28, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rbx
               	leaq	0x4(%rbx), %rdi
               	movl	$0x3, %edx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	0x4(%rbx), %rax
               	cmpl	$0x7, %eax
               	movl	$0x1, %eax
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x7, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	cmpl	$0x7, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
