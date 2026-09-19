
attr_arg_keeps_declared_type.x64:	file format elf64-x86-64

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

<add>:
               	leaq	(%rdi,%rsi), %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	<rip>, %rdx
               	xorq	%rcx, %rcx
               	leaq	<rip>, %rsi
               	movl	%ecx, %eax
               	cmpl	$0x18, %eax
               	jae	<addr>
               	movzbq	(%rdx,%rax), %rdi
               	movzbq	(%rsi,%rax), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, %eax
               	cmpl	$0x18, %eax
               	jb	<addr>
               	leaq	-0x10(%rbp), %rax
               	leaq	0x8(%rax), %rcx
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0x2, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movsbq	0x4(%rax), %rax
               	cmpl	$0x6f, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsbq	0x5(%rax), %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
               	movl	$0x3, %eax
               	leave
               	retq
