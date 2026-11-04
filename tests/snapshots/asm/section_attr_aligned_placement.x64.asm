
section_attr_aligned_placement.x64:	file format elf64-x86-64

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

<page_buf_end>:
               	leaq	<rip>, %rax # <addr>
               	addq	$0x2000, %rax           # imm = 0x2000
               	retq

<main>:
               	leaq	<rip>, %rax # <addr>
               	testl	$0xfff, %eax            # imm = 0xFFF
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x3f, %cl
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x3f, %cl
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	testb	$0xf, %cl
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	testl	$0xfff, %ecx            # imm = 0xFFF
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x1f, %cl
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x7f, %cl
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movb	$0x1, <rip> # <addr>
               	addq	$0x1fff, %rax           # imm = 0x1FFF
               	movb	$0x2, (%rax)
               	movl	$0x15, <rip> # <addr>
               	movb	$0x3, <rip> # <addr>
               	movb	$0x4, <rip> # <addr>
               	movsbq	<rip>, %rcx # <addr>
               	movsbq	(%rax), %rax
               	addq	%rcx, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	cmpl	$0x20, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movsbq	<rip>, %rax # <addr>
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	xorl	%eax, %eax
               	retq
