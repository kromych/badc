
computed_goto_label_only_target.x64:	file format elf64-x86-64

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

<only_indirect>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movl	%edi, -0x20(%rbp)
               	leaq	<rip>, %rax         # <addr>
               	movq	%rax, -0x8(%rbp)
               	movslq	%edi, %rax
               	incq	%rax
               	movslq	%eax, %rax
               	leave
               	retq
               	movslq	-0x20(%rbp), %rax
               	addq	$0x2, %rax
               	movslq	%eax, %rax
               	leave
               	retq

<selected>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	movl	%edi, -0x30(%rbp)
               	movl	%esi, -0x20(%rbp)
               	leaq	<rip>, %rax         # <addr>
               	movq	%rax, -0x8(%rbp)
               	movslq	%esi, %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x30(%rbp), %rax
               	addq	$0x14, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	movq	-0x8(%rbp), %rax
               	jmpq	*%rax
               	movslq	-0x30(%rbp), %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x1, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x5, %edi
               	xorq	%rsi, %rsi
               	callq	<addr>
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x5, %edi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpq	$0x19, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x5, %edi
               	movslq	-0x8(%rbp), %rsi
               	callq	<addr>
               	cmpq	$0x19, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
