
typeof_redeclaration_after_multidim_array.x64:	file format elf64-x86-64

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
               	movq	$0x7, <rip> # <addr>
               	movq	$0x9, <rip> # <addr>
               	movl	$0x5, <rip> # <addr>
               	movl	$0x6, <rip> # <addr>
               	leaq	<rip>, %rax # <addr>
               	movl	$0x8, <rip> # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x7, %rcx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x9, %rcx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x5, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x6, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x8, %ecx
               	jne	<addr>
               	leaq	0x10(%rax), %rcx
               	subq	%rax, %rcx
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	shrq	$0x3e, %rax
               	addq	%rcx, %rax
               	sarq	$0x2, %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorl	%eax, %eax
               	retq
