
deferred_struct_array_row_designator.x64:	file format elf64-x86-64

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
               	movslq	0x20(%rax), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movslq	0x2c(%rax), %rcx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movslq	(%rax), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movslq	0xc(%rax), %rcx
               	cmpl	$0x8, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	cmpl	$0x0, 0x10(%rax)
               	jne	<addr>
               	cmpl	$0x0, 0x1c(%rax)
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x10(%rax), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movslq	0x2c(%rax), %rcx
               	cmpl	$0x8, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0xc(%rax), %rcx
               	cmpl	$0x18, %ecx
               	jne	<addr>
               	movslq	0x20(%rax), %rcx
               	cmpl	$0x9, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	cmpl	$0x0, 0x10(%rax)
               	jne	<addr>
               	cmpl	$0x0, 0x1c(%rax)
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	xorl	%eax, %eax
               	retq
