
post_inline_dead_data_repack.x64:	file format elf64-x86-64

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
               	pushq	%rax
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rax # <addr>
               	testb	$0x3f, %al
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x7, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%r11
               	retq
               	movl	$0x19, %r8d
               	movq	%r8, <rip> # <addr>
               	cmpq	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rdx # <addr>
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	movl	$0x8, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x28, %esi
               	movq	<rip>, %rcx # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%r11
               	retq
