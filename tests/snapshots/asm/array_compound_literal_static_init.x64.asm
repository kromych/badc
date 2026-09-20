
array_compound_literal_static_init.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movslq	0x8(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	(%rax), %rcx
               	movq	(%rcx), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x61, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	0x8(%rax), %rcx
               	movslq	0x8(%rcx), %rcx
               	cmpl	$0x2aa, %ecx            # imm = 0x2AA
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	0x8(%rax), %rcx
               	movq	(%rcx), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x69, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rcx
               	movq	(%rcx), %rcx
               	movsbq	0x1(%rcx), %rcx
               	cmpl	$0x66, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	0x8(%rax), %rcx
               	movslq	0x18(%rcx), %rcx
               	cmpl	$0x28b, %ecx            # imm = 0x28B
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movq	0x8(%rax), %rcx
               	movq	0x10(%rcx), %rcx
               	movsbq	0x1(%rcx), %rcx
               	cmpl	$0x6e, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movq	0x8(%rax), %rax
               	movslq	0x28(%rax), %rax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rcx
               	cmpq	$0x0, 0x20(%rcx)
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	movq	0x10(%rax), %rcx
               	movslq	0x8(%rcx), %rcx
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	movq	0x10(%rax), %rcx
               	cmpl	$0x0, 0x18(%rcx)
               	jne	<addr>
               	movq	0x10(%rax), %rcx
               	cmpq	$0x0, 0x10(%rcx)
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	movq	0x10(%rax), %rax
               	cmpl	$0x0, 0x28(%rax)
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	xorl	%eax, %eax
               	retq
