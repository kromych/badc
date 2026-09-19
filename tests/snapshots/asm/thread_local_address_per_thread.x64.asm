
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
               	movq	%fs:0x0, %rax
               	addq	$-0x10, %rax
               	movq	(%rax), %rcx
               	leaq	<rip>, %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0xbad1, %eax           # imm = 0xBAD1
               	retq
               	movq	%fs:0x0, %rcx
               	addq	$-0x8, %rcx
               	movq	(%rcx), %rcx
               	leaq	<rip>, %rdx
               	addq	$0x8, %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movq	%fs:0x0, %rcx
               	addq	$-0x8, %rcx
               	movq	(%rcx), %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0xbad2, %eax           # imm = 0xBAD2
               	retq
               	movq	$0x0, (%rax)
               	movq	%fs:0x0, %rax
               	addq	$-0x8, %rax
               	movq	$0x0, (%rax)
               	movl	$0x63, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%fs:0x0, %r13
               	addq	$-0x10, %r13
               	movq	(%r13), %rax
               	leaq	<rip>, %r15
               	cmpq	%r15, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
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
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%r14d, %r14d
               	movl	$0x2, %esi
               	movq	%r14, %rdi
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
               	movq	%r14, %rsi
               	movq	%r14, %rcx
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
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	(%r13), %rax
               	cmpq	%r15, %rax
               	jne	<addr>
               	movq	(%r13), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x8, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	addq	$0x8, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	%fs:0x0, %rax
               	addq	$-0x8, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
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
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
