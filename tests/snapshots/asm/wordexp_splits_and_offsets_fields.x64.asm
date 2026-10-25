
wordexp_splits_and_offsets_fields.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	leaq	<rip>, %rdi
               	leaq	-0x18(%rbp), %rsi
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	-0x18(%rbp), %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	movq	0x10(%rax), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	-0x18(%rbp), %rsi
               	movl	$0x2, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movq	-0x18(%rbp), %rax
               	cmpq	$0x4, %rax
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	movq	0x18(%rax), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x18(%rbp), %rdi
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x0, 0x20(%rax)
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x18(%rbp), %rsi
               	movq	$0x2, -0x8(%rbp)
               	leaq	<rip>, %rdi
               	movl	$0x1, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movq	-0x18(%rbp), %rax
               	cmpq	$0x2, %rax
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x0, (%rax)
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x0, 0x8(%rax)
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	movq	0x18(%rax), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x18(%rbp), %rsi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
