
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
               	testb	$-0x1, %cl
               	jne	<addr>
               	movl	0x18(%rax), %ecx
               	testb	$-0x1, %cl
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	(%rax), %ecx
               	sarq	$0x8, %rcx
               	testb	$-0x1, %cl
               	jne	<addr>
               	cmpl	$0x0, 0x4(%rax)
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rcx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movl	(%rax), %ecx
               	andq	$0xff, %rcx
               	cmpl	$0x9, %ecx
               	jne	<addr>
               	movl	0x18(%rax), %ecx
               	andq	$0xff, %rcx
               	cmpl	$0x9, %ecx
               	jne	<addr>
               	movslq	0x14(%rax), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	cmpl	$0x0, 0xc(%rax)
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorl	%eax, %eax
               	retq
