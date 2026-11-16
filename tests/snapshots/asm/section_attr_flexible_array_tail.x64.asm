
section_attr_flexible_array_tail.x64:	file format elf64-x86-64

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

<pick>:
               	movslq	%edi, %rdi
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rdi,8), %rax
               	retq

<main>:
               	leaq	<rip>, %rax # <addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movq	%rsi, %rcx
               	movsbq	(%rcx), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rcx
               	incq	%rax
               	movsbq	(%rcx), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rcx), %rcx
               	movsbq	(%rax), %rax
               	cmpl	%eax, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x16, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	0x20(%rsi), %rax
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	leaq	0x2b(%rsi), %rax
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	leaq	0x36(%rsi), %rax
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	leaq	0x41(%rsi), %rcx
               	leaq	<rip>, %rax # <addr>
               	cmpq	%rcx, %rax
               	jae	<addr>
               	cmpq	%rsi, %rax
               	jb	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	addq	$0x20, %rax
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x2b, %rax
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	addq	$0x20, %rax
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	xorl	%eax, %eax
               	retq
               	movl	$0xd, %eax
               	retq
               	movl	$0xc, %eax
               	retq
               	movl	$0x7, %eax
               	retq
               	movl	$0x6, %eax
               	retq
               	movl	$0x5, %eax
               	retq
