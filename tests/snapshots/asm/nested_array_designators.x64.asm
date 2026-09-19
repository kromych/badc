
nested_array_designators.x64:	file format elf64-x86-64

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
               	movq	0x28(%rax), %rcx
               	leaq	<rip>, %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movq	0x30(%rax), %rcx
               	leaq	<rip>, %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rax
               	movzbq	0x2(%rax), %rax
               	xorq	$0x28, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x3(%rax), %rax
               	xorq	$0x29, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	leaq	<rip>, %rax
               	movzbq	0xb(%rax), %rax
               	xorq	$0x2a, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpb	$0x0, 0xa(%rax)
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	xorl	%eax, %eax
               	retq
