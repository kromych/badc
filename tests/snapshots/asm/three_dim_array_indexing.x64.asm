
three_dim_array_indexing.x64:	file format elf64-x86-64

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
               	movzbq	<rip>, %rax # <addr>
               	movzbq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	movzbq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	movzbq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	movzbq	<rip>, %rax # <addr>
               	movzbq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	movzbq	<rip>, %rcx # <addr>
               	addq	%rax, %rcx
               	movzbq	<rip>, %rax # <addr>
               	addq	%rax, %rcx
               	cmpl	$0x2a, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	movzbq	<rip>, %rcx # <addr>
               	movzbq	<rip>, %rdx # <addr>
               	addq	%rdx, %rcx
               	movzbq	<rip>, %rdx # <addr>
               	addq	%rdx, %rcx
               	movzbq	<rip>, %rdx # <addr>
               	addq	%rdx, %rcx
               	cmpl	$0x4a, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	movzbq	<rip>, %rcx # <addr>
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%r11
               	retq
               	cmpl	$0xc, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%r11
               	retq
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x18, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%r11
               	retq
               	movzbq	<rip>, %rax # <addr>
               	movzbq	<rip>, %rcx # <addr>
               	subq	%rcx, %rax
               	cmpl	$0xc, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%r11
               	retq
               	movzbq	<rip>, %rax # <addr>
               	subq	%rcx, %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%r11
               	retq
