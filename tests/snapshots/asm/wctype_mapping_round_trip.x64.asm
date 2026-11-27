
wctype_mapping_round_trip.x64:	file format elf64-x86-64

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
               	subq	$0x58, %rsp
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x20(%rsp)
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x10(%rsp)
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	movl	$0x0, 0x40(%rsp)
               	cmpq	$0x0, 0x28(%rsp)
               	je	<addr>
               	cmpq	$0x0, 0x18(%rsp)
               	je	<addr>
               	cmpq	$0x0, 0x20(%rsp)
               	je	<addr>
               	cmpq	$0x0, 0x10(%rsp)
               	je	<addr>
               	cmpq	$0x0, 0x8(%rsp)
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0x58, %rsp
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
               	addq	$0x58, %rsp
               	retq
               	movl	$0x61, %edi
               	movq	0x28(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x31, %edi
               	movq	0x28(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x58, %rsp
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
               	addq	$0x58, %rsp
               	retq
               	movl	$0x20, %edi
               	movq	0x20(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %edi
               	movq	0x20(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %edi
               	movq	0x20(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x58, %rsp
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
               	addq	$0x58, %rsp
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
               	addq	$0x58, %rsp
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
               	addq	$0x58, %rsp
               	retq
               	movq	$0x0, 0x38(%rsp)
               	leaq	0x40(%rsp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x1, %edx
               	leaq	0x38(%rsp), %rcx
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movl	0x40(%rsp), %eax
               	cmpl	$0x6b, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x58, %rsp
               	retq
               	movq	$0x0, 0x38(%rsp)
               	leaq	0x48(%rsp), %rdi
               	movl	$0x6b, %esi
               	leaq	0x38(%rsp), %rdx
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movsbq	0x48(%rsp), %rax
               	cmpl	$0x6b, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x58, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x58, %rsp
               	retq
