
compound_literal_multidim.x64:	file format elf64-x86-64

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
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rax
               	movq	<rip>, %rcx # <addr>
               	movsbq	0x1(%rcx), %rcx
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	movsbq	0x2(%rcx), %rcx
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	addq	$0x3, %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	addq	$0x3, %rcx
               	movsbq	0x1(%rcx), %rcx
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	addq	$0x3, %rcx
               	movsbq	0x2(%rcx), %rcx
               	addq	%rcx, %rax
               	cmpl	$0x15, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	0x5(%rax), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0xa, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %eax
               	cmpl	$0xd, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	0x10(%rax), %eax
               	cmpl	$0xe, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	0x4(%rax), %ecx
               	cmpl	$0x15, %ecx
               	jne	<addr>
               	movl	0x8(%rax), %eax
               	cmpl	$0x16, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x18, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	0x10(%rax), %eax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	0x8(%rax), %eax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	movl	0x8(%rax), %eax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	retq
               	xorl	%eax, %eax
               	retq
