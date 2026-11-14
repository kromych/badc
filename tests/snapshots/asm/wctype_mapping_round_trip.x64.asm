
wctype_mapping_round_trip.x64:	file format elf64-x86-64

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
               	subq	$0x50, %rsp
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x20(%rsp)
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x10(%rsp)
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	movl	$0x0, -0x10(%rbp)
               	movq	0x20(%rsp), %r10
               	testq	%r10, %r10
               	je	<addr>
               	movq	0x18(%rsp), %r10
               	testq	%r10, %r10
               	je	<addr>
               	movq	0x28(%rsp), %r10
               	testq	%r10, %r10
               	je	<addr>
               	movq	0x10(%rsp), %r10
               	testq	%r10, %r10
               	je	<addr>
               	movq	0x8(%rsp), %r10
               	testq	%r10, %r10
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x61, %edi
               	movq	0x20(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x31, %edi
               	movq	0x20(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x37, %edi
               	movq	0x18(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x78, %edi
               	movq	0x18(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x20, %edi
               	movq	0x28(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %edi
               	movq	0x28(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %edi
               	movq	0x28(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0x20, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x61, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0x71, %edi
               	movq	0x10(%rsp), %rsi
               	callq	<addr>
               	cmpl	$0x51, %eax
               	jne	<addr>
               	movl	$0x51, %edi
               	movq	0x8(%rsp), %rsi
               	callq	<addr>
               	cmpl	$0x71, %eax
               	jne	<addr>
               	movl	$0x35, %edi
               	movq	0x10(%rsp), %rsi
               	callq	<addr>
               	cmpl	$0x35, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movl	$0x7a, %edi
               	callq	<addr>
               	cmpl	$0x7a, %eax
               	jne	<addr>
               	movl	$0x7a, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x7a, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rcx
               	movq	$0x0, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x1, %edx
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movl	-0x10(%rbp), %eax
               	cmpl	$0x6b, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rdx
               	movq	$0x0, -0x18(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	movl	$0x6b, %esi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movsbq	-0x8(%rbp), %rax
               	cmpl	$0x6b, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
