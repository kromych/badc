
array_initializers.x64:	file format elf64-x86-64

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
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x68, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x6f, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	cmpl	$0x1c, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x68, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x69, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x61, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x62, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movsbq	0x4(%rax), %rax
               	cmpl	$0x61, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	retq
               	xorl	%eax, %eax
               	retq
