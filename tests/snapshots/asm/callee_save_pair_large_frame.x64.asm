
callee_save_pair_large_frame.x64:	file format elf64-x86-64

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

<sink>:
               	testl	%edi, %edi
               	jle	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	-0x1(%rbx), %rdi
               	callq	<addr>
               	addq	%rbx, %rax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	retq

<bigframe>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movq	%rbx, %rdi
               	callq	<addr>
               	addq	%r12, %rax
               	addq	%rbx, %rax
               	addq	%r12, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x3, %edi
               	callq	<addr>
               	addq	$0x4, %rax
               	addq	$0x3, %rax
               	addq	$0x4, %rax
               	popq	%rbp
               	retq
