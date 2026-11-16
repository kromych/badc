
elvis_operator.x64:	file format elf64-x86-64

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
               	movl	$0x0, -0x10(%rbp)
               	movl	$0x5, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movslq	-0x10(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpl	$0x63, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x1, <rip> # <addr>
               	movl	$0x1, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x78, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movslq	-0x10(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movslq	-0x10(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movslq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movslq	-0x10(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movslq	-0x8(%rbp), %rax
               	movl	$0x63, %ecx
               	testq	%rax, %rax
               	cmoveq	%rcx, %rax
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x8(%rbp), %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	jmp	<addr>
