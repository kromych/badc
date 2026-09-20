
multidim_array_designator.x64:	file format elf64-x86-64

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
               	movslq	0x4(%rax), %rcx
               	cmpl	$0xb, %ecx
               	jne	<addr>
               	movslq	0x2c(%rax), %rcx
               	cmpl	$0x21, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movslq	0x10(%rax), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movslq	0x14(%rax), %rcx
               	cmpl	$0x6, %ecx
               	jne	<addr>
               	cmpl	$0x0, 0x18(%rax)
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	cmpl	$0x0, 0x20(%rax)
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rcx
               	cmpl	$0x9, %ecx
               	jne	<addr>
               	movslq	0xc(%rax), %rcx
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	cmpl	$0x0, 0x14(%rax)
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorl	%eax, %eax
               	retq
