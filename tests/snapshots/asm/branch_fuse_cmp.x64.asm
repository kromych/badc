
branch_fuse_cmp.x64:	file format elf64-x86-64

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
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	movl	$0x1, %esi
               	cmpq	%rdx, %rcx
               	cmovlq	%rsi, %rax
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	leaq	0x64(%rax), %rsi
               	cmpq	%rdx, %rcx
               	cmovgq	%rsi, %rax
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	leaq	0x1(%rax), %rsi
               	cmpq	%rdx, %rcx
               	cmovleq	%rsi, %rax
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	leaq	0x64(%rax), %rsi
               	cmpq	%rdx, %rcx
               	cmovgeq	%rsi, %rax
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	leaq	0x1(%rax), %rsi
               	cmpq	%rdx, %rcx
               	cmovbq	%rsi, %rax
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	leaq	0x64(%rax), %rsi
               	cmpq	%rdx, %rcx
               	cmovaq	%rsi, %rax
               	movq	<rip>, %rcx # <addr>
               	leaq	0x1(%rax), %rdx
               	cmpq	$0x5, %rcx
               	cmoveq	%rdx, %rax
               	movq	<rip>, %rcx # <addr>
               	leaq	0x64(%rax), %rdx
               	cmpq	$0x9, %rcx
               	cmovneq	%rdx, %rax
               	movq	<rip>, %rcx # <addr>
               	leaq	0x64(%rax), %rdx
               	cmpq	$0x4, %rcx
               	cmovbeq	%rdx, %rax
               	movq	<rip>, %rcx # <addr>
               	leaq	0x1(%rax), %rdx
               	cmpq	$0x9, %rcx
               	cmovaeq	%rdx, %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movl	$0x64, %edx
               	testq	%rcx, %rcx
               	cmovneq	%rdx, %rax
               	movq	<rip>, %rcx # <addr>
               	leaq	0x1(%rax), %rdx
               	testq	%rcx, %rcx
               	cmoveq	%rdx, %rax
               	movq	<rip>, %rcx # <addr>
               	leaq	0x1(%rax), %rdx
               	testq	%rcx, %rcx
               	cmovneq	%rdx, %rax
               	movq	<rip>, %rcx # <addr>
               	leaq	0x64(%rax), %rdx
               	testq	%rcx, %rcx
               	cmoveq	%rdx, %rax
               	movq	<rip>, %rcx # <addr>
               	leaq	0x1(%rax), %rdx
               	testq	%rcx, %rcx
               	cmovneq	%rdx, %rax
               	movq	<rip>, %rcx # <addr>
               	leaq	0x1(%rax), %rdx
               	testq	%rcx, %rcx
               	cmoveq	%rdx, %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	setl	%al
               	movzbq	%al, %rax
               	movl	%eax, <rip> # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	setl	%al
               	movzbq	%al, %rax
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	addq	%rdx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	cmpl	$0xe, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorl	%eax, %eax
               	retq
