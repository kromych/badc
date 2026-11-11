
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
               	movq	<rip>, %rax # <addr>
               	movl	0x8(%rax), %ecx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x61, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	0x8(%rax), %ecx
               	cmpl	$0x2aa, %ecx            # imm = 0x2AA
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x69, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rcx
               	movsbq	0x1(%rcx), %rcx
               	cmpl	$0x66, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movl	0x18(%rax), %eax
               	cmpl	$0x28b, %eax            # imm = 0x28B
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	0x10(%rax), %rcx
               	movsbq	0x1(%rcx), %rcx
               	cmpl	$0x6e, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movl	0x28(%rax), %eax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x0, 0x20(%rax)
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	0x8(%rax), %ecx
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	cmpl	$0x0, 0x18(%rax)
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x0, 0x10(%rax)
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	cmpl	$0x0, 0x28(%rax)
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	xorl	%eax, %eax
               	retq
