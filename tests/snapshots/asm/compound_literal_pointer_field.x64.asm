
compound_literal_pointer_field.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x68, %ecx
               	jne	<addr>
               	movl	0x8(%rax), %ecx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	0x18(%rax), %ecx
               	cmpl	$0x8, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	cmpq	$0x0, 0x20(%rax)
               	jne	<addr>
               	cmpl	$0x0, 0x28(%rax)
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x78, %ecx
               	jne	<addr>
               	movl	0x8(%rax), %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorl	%eax, %eax
               	retq
