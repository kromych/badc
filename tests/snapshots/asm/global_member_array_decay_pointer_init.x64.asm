
global_member_array_decay_pointer_init.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rcx # <addr>
               	movl	$0xb, <rip> # <addr>
               	movl	$0x16, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	(%rax), %ecx
               	cmpl	$0xb, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %eax
               	cmpl	$0x16, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movl	$0x21, (%rax)
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movl	(%rcx), %eax
               	cmpl	$0x21, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorl	%eax, %eax
               	retq
