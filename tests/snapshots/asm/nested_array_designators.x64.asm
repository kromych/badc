
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
               	movq	0x30(%rax), %rax
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rax
               	movzbq	0x2(%rax), %rcx
               	xorq	$0x28, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x3(%rax), %rcx
               	xorq	$0x29, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movzbq	0xb(%rax), %rcx
               	xorq	$0x2a, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpb	$0x0, 0xa(%rax)
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	xorl	%eax, %eax
               	retq
