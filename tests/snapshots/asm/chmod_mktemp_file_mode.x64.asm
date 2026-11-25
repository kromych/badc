
chmod_mktemp_file_mode.x64:	file format elf64-x86-64

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
               	subq	$0xa8, %rsp
               	leaq	(%rsp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	movl	0x8(%rax), %r10d
               	movl	%r10d, 0x8(%rdi)
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	cmpq	%rdi, %rax
               	jne	<addr>
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xa8, %rsp
               	retq
               	leaq	(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	$0x2, %eax
               	addq	$0xa8, %rsp
               	retq
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	movl	$0x100, %esi            # imm = 0x100
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	(%rsp), %rdi
               	leaq	0x10(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xa8, %rsp
               	retq
               	movl	0x28(%rsp), %eax
               	testb	$-0x80, %al
               	jne	<addr>
               	leaq	(%rsp), %rdi
               	movl	$0x180, %esi            # imm = 0x180
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	(%rsp), %rdi
               	leaq	0x10(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xa8, %rsp
               	retq
               	movl	0x28(%rsp), %eax
               	andq	$0x80, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x5, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	cmoveq	%rdx, %rcx
               	movq	%rcx, %rax
               	addq	$0xa8, %rsp
               	retq
