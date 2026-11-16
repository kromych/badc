
post_inline_dead_data_repack.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax # <addr>
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x3f, %cl
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x7, %rcx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x9, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movl	$0x19, %r8d
               	movq	%r8, <rip> # <addr>
               	cmpq	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdx # <addr>
               	cmpq	%rax, %rdx
               	jne	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x28, %esi
               	movq	<rip>, %rcx # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
