
array_field_designator_local.x64:	file format elf64-x86-64

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
               	movl	(%rax), %ecx
               	andq	$0xff, %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	0x8(%rax), %ecx
               	andq	$0xff, %rcx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movl	0x10(%rax), %ecx
               	andq	$0xff, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0x18(%rax), %ecx
               	andq	$0xff, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	(%rax), %ecx
               	sarq	$0x8, %rcx
               	andq	$0xff, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	0x4(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	andq	$0xff, %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movl	0x18(%rax), %eax
               	andq	$0xff, %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x14(%rax), %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0xc(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorl	%eax, %eax
               	retq
