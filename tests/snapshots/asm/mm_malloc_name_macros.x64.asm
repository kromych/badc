
mm_malloc_name_macros.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x40, %edx
               	movl	$0x20, %esi
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	testb	$0x1f, %al
               	jne	<addr>
               	movq	%rax, %rdi
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x2a, %eax
               	leave
               	retq
