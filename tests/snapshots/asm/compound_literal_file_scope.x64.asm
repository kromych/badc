
compound_literal_file_scope.x64:	file format elf64-x86-64

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
               	movl	(%rax), %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	0x4(%rax), %eax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	0x8(%rax), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	0x4(%rax), %eax
               	cmpl	$0x8, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	0x8(%rax), %eax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	0x8(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x72, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	0x8(%rax), %rax
               	movsbq	0x1(%rax), %rax
               	cmpl	$0x6f, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x0, 0x10(%rax)
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpl	$0x0, 0x4(%rax)
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpl	$0x0, 0x8(%rax)
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorl	%eax, %eax
               	retq
