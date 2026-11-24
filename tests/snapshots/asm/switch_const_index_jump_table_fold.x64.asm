
switch_const_index_jump_table_fold.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x18, %rsp
               	movl	$0x5, %eax
               	movl	%eax, 0x8(%rsp)
               	movslq	0x8(%rsp), %rcx
               	cmpq	$0x8, %rcx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rcx,8), %r10
               	jmpq	*%r10
               	movl	$0x2, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%edx, %edx
               	movl	%edx, 0x8(%rsp)
               	movslq	0x8(%rsp), %rcx
               	cmpq	$0x8, %rcx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rcx,8), %r10
               	jmpq	*%r10
               	movl	$0x7, 0x8(%rsp)
               	movslq	0x8(%rsp), %rcx
               	cmpq	$0x8, %rcx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rcx,8), %r10
               	jmpq	*%r10
               	movl	$0x4, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x9, 0x8(%rsp)
               	movslq	0x8(%rsp), %rcx
               	cmpq	$0x8, %rcx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rcx,8), %r10
               	jmpq	*%r10
               	addq	$0x18, %rsp
               	retq
               	movq	%rdx, %rax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x3, %eax
               	addq	$0x18, %rsp
               	retq
