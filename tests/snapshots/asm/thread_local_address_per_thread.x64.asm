
thread_local_address_per_thread.x64:	file format elf64-x86-64

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

<thread_main>:
               	movq	%fs:0x0, %rcx
               	addq	$-0x10, %rcx
               	movq	(%rcx), %rax
               	leaq	<rip>, %rdx
               	cmpq	%rdx, %rax
               	je	<addr>
               	movl	$0xbad1, %eax           # imm = 0xBAD1
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x8, %rax
               	movq	(%rax), %rdx
               	leaq	<rip>, %rsi
               	addq	$0x8, %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movq	(%rax), %rdx
               	movslq	(%rdx), %rdx
               	cmpl	$0x3, %edx
               	je	<addr>
               	movl	$0xbad2, %eax           # imm = 0xBAD2
               	retq
               	movq	$0x0, (%rcx)
               	movq	$0x0, (%rax)
               	movl	$0x63, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%fs:0x0, %rax
               	addq	$-0x10, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x8, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	addq	$0x8, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%r13d, %r13d
               	movl	$0x2, %esi
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %rsi
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rsi
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	-0x10(%rbp), %rdi
               	leaq	-<rip>, %rdx      # <addr>
               	movq	%rbx, %rax
               	movq	%r13, %rsi
               	movq	%r13, %rcx
               	callq	*%rax
               	movq	-0x10(%rbp), %rdi
               	leaq	-0x8(%rbp), %rsi
               	movq	%r12, %rax
               	callq	*%rax
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x63, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x10, %rax
               	movq	(%rax), %rcx
               	leaq	<rip>, %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x8, %rax
               	movq	(%rax), %rcx
               	leaq	<rip>, %rdx
               	addq	$0x8, %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx      # <addr>
               	movq	%rbx, %rax
               	movq	%rsi, %rcx
               	callq	*%rax
               	movq	-0x10(%rbp), %rdi
               	leaq	-0x8(%rbp), %rsi
               	movq	%r12, %rax
               	callq	*%rax
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x63, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
