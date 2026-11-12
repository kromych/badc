
stmt_expr.x64:	file format elf64-x86-64

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

<bump>:
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	retq

<main>:
               	movl	$0x0, <rip> # <addr>
               	movl	$0x1, <rip> # <addr>
               	movl	$0x2, <rip> # <addr>
               	movl	$0x3, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	imulq	$0xa, %rax, %rcx
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	imulq	$0x64, %rax, %rdx
               	cmpl	$0xa, %ecx
               	jne	<addr>
               	cmpl	$0xc8, %edx
               	jne	<addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorl	%eax, %eax
               	movl	%eax, <rip> # <addr>
               	movl	$0x1, <rip> # <addr>
               	movl	$0x2, <rip> # <addr>
               	movl	$0x3, <rip> # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movl	%eax, <rip> # <addr>
               	movl	$0x1, <rip> # <addr>
               	movl	$0x2, <rip> # <addr>
               	retq
