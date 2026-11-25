
dlopen_atoi.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x20, %rsp
               	pushq	%rbx
               	xorl	%edi, %edi
               	movl	$0x2, %esi
               	callq	<addr>
               	movq	%rax, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
               	movq	%rbx, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
               	leaq	<rip>, %rdi
               	callq	*%rax
               	movq	%rax, 0x18(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	0x18(%rsp), %rax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
