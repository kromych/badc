
libc_mlock_and_fmemopen.x64:	file format elf64-x86-64

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
               	subq	$0x38, %rsp
               	movb	$0x1, <rip> # <addr>
               	movl	$0x1e, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	$0x1e, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x38, %rsp
               	retq
               	movabsq	$0x7878787878787878, %rax # imm = 0x7878787878787878
               	movq	%rax, 0x20(%rsp)
               	movq	%rax, 0x28(%rsp)
               	leaq	0x20(%rsp), %rdi
               	movl	$0x10, %esi
               	leaq	<rip>, %rdx
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	testq	%r10, %r10
               	jne	<addr>
               	movl	$0x3, %eax
               	addq	$0x38, %rsp
               	retq
               	leaq	<rip>, %rdi
               	movq	0x8(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movq	0x8(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x38, %rsp
               	retq
               	leaq	0x20(%rsp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x6, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x38, %rsp
               	retq
               	movq	0x8(%rsp), %rdi
               	callq	<addr>
               	movq	0x8(%rsp), %rdi
               	leaq	<rip>, %rsi
               	leaq	0x18(%rsp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	leaq	0x18(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x38, %rsp
               	retq
               	movq	0x8(%rsp), %rdi
               	callq	<addr>
               	leaq	0x20(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	leaq	0x20(%rsp), %rdi
               	movl	$0x10, %esi
               	leaq	<rip>, %rdx
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	testq	%r10, %r10
               	je	<addr>
               	movq	0x8(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x61, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x38, %rsp
               	retq
               	movq	0x8(%rsp), %rdi
               	xorl	%esi, %esi
               	movl	$0x2, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x8(%rsp), %rdi
               	callq	<addr>
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x38, %rsp
               	retq
               	movq	0x8(%rsp), %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	addq	$0x38, %rsp
               	retq
