
thread_local_tentative_array.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%fs:0x0, %rax
               	addq	$-0x8, %rax
               	movslq	(%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x63, %ecx
               	movl	%ecx, (%rax)
               	movslq	(%rax), %rax
               	popq	%rbp
               	retq

<second_thread_result>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	xorq	%rbx, %rbx
               	movl	$0x2, %esi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %rsi
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	<rip>, %rsi
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	-0x10(%rbp), %rdi
               	leaq	-<rip>, %rdx       # <addr>
               	movq	%r13, %rax
               	movq	%rbx, %rsi
               	movq	%rbx, %rcx
               	callq	*%rax
               	movq	-0x10(%rbp), %rdi
               	leaq	-0x8(%rbp), %rsi
               	movq	%r12, %rax
               	callq	*%rax
               	movq	-0x8(%rbp), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%fs:0x0, %rbx
               	addq	$-0x8, %rbx
               	movl	$0x7, %eax
               	movl	%eax, (%rbx)
               	callq	<addr>
               	cmpq	$0x63, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movslq	(%rbx), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
