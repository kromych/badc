
typeof_redeclaration_after_multidim_array.x64:	file format elf64-x86-64

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
               	movq	$0x7, <rip> # <addr>
               	movq	$0x9, <rip> # <addr>
               	movl	$0x5, <rip> # <addr>
               	movl	$0x6, <rip> # <addr>
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x8, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x7, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x6, %eax
               	jne	<addr>
               	leaq	0x10(%rcx), %rax
               	subq	%rcx, %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3e, %rcx
               	addq	%rcx, %rax
               	sarq	$0x2, %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorl	%eax, %eax
               	retq
