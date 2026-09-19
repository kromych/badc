
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
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	leaq	<rip>, %rax         # <addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movslq	-0x10(%rbp), %rax
               	addq	$0x2, %rax
               	movslq	%eax, %rax
               	leave
               	retq

<selected>:
               	movslq	%esi, %rsi
               	leaq	<rip>, %rax         # <addr>
               	testq	%rsi, %rsi
               	je	<addr>
               	jmpq	*%rax
               	movl	$0x19, %eax
               	retq
               	movl	$0xf, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x1, -0x8(%rbp)
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x5, %edi
               	xorl	%esi, %esi
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
               	xorl	%eax, %eax
               	leave
               	retq
