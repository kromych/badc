
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
               	xorl	%eax, %eax
               	testl	%edi, %edi
               	jle	<addr>
               	leaq	-0x1(%rdi), %rcx
               	addq	%rdi, %rax
               	movq	%rcx, %rdi
               	testl	%edi, %edi
               	jg	<addr>
               	incq	%rax
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
