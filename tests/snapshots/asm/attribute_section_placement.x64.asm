
attribute_section_placement.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	subq	$0x2a, %rax
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
		...
               	addb	%al, (%rax)

<boot>:
               	movl	$0x7, %eax
               	retq
