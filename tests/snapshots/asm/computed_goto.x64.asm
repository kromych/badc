
computed_goto.x64:	file format elf64-x86-64

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

<direct>:
               	testl	%edi, %edi
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	jmpq	*%rax
               	movl	$0xa, %eax
               	retq
               	movl	$0x14, %eax
               	retq
               	leaq	-<rip>, %rax # <addr>
               	jmpq	*%rax

<interp>:
               	subq	$0x28, %rsp
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	movq	%rcx, 0x8(%rsp)
               	leaq	<rip>, %rcx # <addr>
               	movq	%rcx, 0x10(%rsp)
               	leaq	<rip>, %rcx # <addr>
               	movq	%rcx, 0x18(%rsp)
               	movl	$0x1, %ecx
               	movslq	(%rdi), %rsi
               	movq	0x8(%rsp,%rsi,8), %rdx
               	jmpq	*%rdx
               	leaq	0x1(%rcx), %rdx
               	movl	(%rdi,%rcx,4), %ecx
               	addq	%rcx, %rax
               	leaq	0x1(%rdx), %rcx
               	movslq	(%rdi,%rdx,4), %rdx
               	movq	0x8(%rsp,%rdx,8), %rdx
               	jmpq	*%rdx
               	leaq	0x1(%rcx), %rdx
               	movl	(%rdi,%rcx,4), %ecx
               	subq	%rcx, %rax
               	leaq	0x1(%rdx), %rcx
               	movslq	(%rdi,%rdx,4), %rdx
               	movq	0x8(%rsp,%rdx,8), %rdx
               	jmpq	*%rdx
               	addq	$0x28, %rsp
               	retq

<loop_to>:
               	subq	$0x18, %rsp
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, 0x8(%rsp)
               	movq	%rcx, %rax
               	incq	%rax
               	movl	$0x1, %esi
               	cmpl	%edi, %eax
               	cmovlq	%rcx, %rsi
               	movq	(%rsp,%rsi,8), %rsi
               	jmpq	*%rsi
               	jmp	<addr>
               	addq	$0x18, %rsp
               	retq

<main>:
               	subq	$0x28, %rsp
               	xorl	%edi, %edi
               	callq	<addr>
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	(%rsp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movq	0x10(%rax), %r10
               	movq	%r10, 0x10(%rdi)
               	movl	0x18(%rax), %r10d
               	movl	%r10d, 0x18(%rdi)
               	callq	<addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
