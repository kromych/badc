
switch_const_index_jump_table_fold.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x5, %eax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rcx
               	cmpq	$0x8, %rcx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rcx,8), %r10
               	jmpq	*%r10
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%ecx, %ecx
               	movl	%ecx, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rdx
               	cmpq	$0x8, %rdx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdx,8), %r10
               	jmpq	*%r10
               	movl	$0x7, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rdx
               	cmpq	$0x8, %rdx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdx,8), %r10
               	jmpq	*%r10
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x9, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rdx
               	cmpq	$0x8, %rdx
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdx,8), %r10
               	jmpq	*%r10
               	leave
               	retq
               	movq	%rcx, %rax
               	leave
               	retq
               	movl	$0x3, %eax
               	leave
               	retq
