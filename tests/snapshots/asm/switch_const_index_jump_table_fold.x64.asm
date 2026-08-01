
switch_const_index_jump_table_fold.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<pick_folded>:
               	movl	$0xc, %eax
               	retq
               	jmp	<addr>

<pick_live>:
               	movslq	%edi, %rdi
               	cmpq	$0x8, %rdi
               	jae	<addr>
               	leaq	<rip>, %r11
               	movslq	(%r11,%rdi,4), %r10
               	addq	%r11, %r10
               	jmpq	*%r10
               	movl	$0x14, %eax
               	retq
               	movl	$0x15, %eax
               	retq
               	movl	$0x16, %eax
               	retq
               	movl	$0x17, %eax
               	retq
               	movl	$0x18, %eax
               	retq
               	movl	$0x19, %eax
               	retq
               	movl	$0x1a, %eax
               	retq
               	movl	$0x1b, %eax
               	retq
               	movabsq	$-0x2, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x5, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	$0x2, %edi
               	callq	<addr>
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x8(%rbp), %rdi
               	callq	<addr>
               	cmpq	$0x19, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rdi
               	callq	<addr>
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %eax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rdi
               	callq	<addr>
               	cmpq	$0x1b, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x9, %eax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rdi
               	callq	<addr>
               	cmpq	$-0x2, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
