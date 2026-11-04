
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
               	cmpq	%rdx, %rcx
               	jge	<addr>
               	movl	$0x1, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rdx, %rcx
               	jle	<addr>
               	addq	$0x64, %rax
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rdx, %rcx
               	jg	<addr>
               	incq	%rax
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rdx, %rcx
               	jl	<addr>
               	addq	$0x64, %rax
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rdx, %rcx
               	jae	<addr>
               	incq	%rax
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rdx, %rcx
               	jbe	<addr>
               	addq	$0x64, %rax
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x5, %rcx
               	jne	<addr>
               	incq	%rax
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x9, %rcx
               	je	<addr>
               	addq	$0x64, %rax
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x4, %rcx
               	ja	<addr>
               	addq	$0x64, %rax
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x9, %rcx
               	jb	<addr>
               	incq	%rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x64, %eax
               	movq	<rip>, %rcx # <addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	incq	%rax
               	movq	<rip>, %rcx # <addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	incq	%rax
               	movq	<rip>, %rcx # <addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	addq	$0x64, %rax
               	movq	<rip>, %rcx # <addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	incq	%rax
               	movq	<rip>, %rcx # <addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	incq	%rax
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
