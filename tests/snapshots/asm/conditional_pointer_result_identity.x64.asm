
conditional_pointer_result_identity.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	leaq	0x3(%rax), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x3, %rcx
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	movl	$0x2a, %ecx
               	movl	%ecx, (%rax)
               	movslq	%ecx, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	retq
               	xorq	%rax, %rax
               	retq
