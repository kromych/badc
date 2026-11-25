
pthread_create.x64:	file format elf64-x86-64

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

<thread_main>:
               	movl	$0xb, %eax
               	retq

<main>:
               	subq	$0x18, %rsp
               	pushq	%r12
               	pushq	%rbx
               	xorl	%edi, %edi
               	movl	$0x2, %esi
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	%rbx, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movq	%rax, %r12
               	movq	%rbx, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x10(%rsp), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx # <addr>
               	xorl	%ecx, %ecx
               	callq	*%r12
               	movq	0x10(%rsp), %rdi
               	leaq	0x18(%rsp), %rsi
               	callq	*%rbx
               	movq	0x18(%rsp), %rax
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
