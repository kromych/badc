
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
               	leaq	<rip>, %rdx # <addr>
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0xbad1, %eax           # imm = 0xBAD1
               	retq
               	movq	%fs:0x0, %rcx
               	addq	$-0x8, %rcx
               	movq	(%rcx), %rdx
               	leaq	<rip>, %rsi # <addr>
               	addq	$0x8, %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movl	(%rdx), %edx
               	cmpl	$0x3, %edx
               	je	<addr>
               	movl	$0xbad2, %eax           # imm = 0xBAD2
               	retq
               	movq	$0x0, (%rax)
               	movq	$0x0, (%rcx)
               	movl	$0x63, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	%fs:0x0, %rax
               	addq	$-0x10, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x8, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x8, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%edi, %edi
               	movl	$0x2, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rsi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %rsi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	-0x10(%rbp), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx # <addr>
               	movq	%rsi, %rcx
               	callq	*%r12
               	movq	-0x10(%rbp), %rdi
               	leaq	-0x8(%rbp), %rsi
               	callq	*%rbx
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x63, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x10, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x8, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x8, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx # <addr>
               	movq	%rsi, %rcx
               	callq	*%r12
               	movq	-0x10(%rbp), %rdi
               	leaq	-0x8(%rbp), %rsi
               	callq	*%rbx
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x63, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
