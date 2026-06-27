
thread_local_per_thread.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<thread_main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%fs:0x0, %rax
               	subq	$0x8, %rax
               	movslq	(%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xbad1, %eax           # imm = 0xBAD1
               	popq	%rbp
               	retq
               	movl	$0x63, %ecx
               	movl	%ecx, (%rax)
               	movslq	%ecx, %rcx
               	cmpq	$0x63, %rcx
               	je	<addr>
               	movl	$0xbad2, %eax           # imm = 0xBAD2
               	popq	%rbp
               	retq
               	movslq	(%rax), %rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%fs:0x0, %rbx
               	subq	$0x8, %rbx
               	movl	$0x1, %eax
               	movl	%eax, (%rbx)
               	xorq	%r12, %r12
               	movl	$0x2, %esi
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	<rip>, %rsi
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %rsi
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x20(%rbp), %rdi
               	leaq	-<rip>, %rdx       # <addr>
               	movq	%r14, %rax
               	movq	%r12, %rsi
               	movq	%r12, %rcx
               	callq	*%rax
               	movq	-0x20(%rbp), %rdi
               	leaq	-0x28(%rbp), %rsi
               	movq	%r13, %rax
               	callq	*%rax
               	movq	-0x28(%rbp), %rax
               	cmpq	$0x63, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movslq	(%rbx), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
