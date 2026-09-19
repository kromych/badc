
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
               	leaq	<rip>, %rax
               	movq	(%rax,%rdi,8), %rax
               	retq

<main>:
               	leaq	<rip>, %r9
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx
               	movq	%rsi, %rax
               	movsbq	(%rax), %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movsbq	(%rax), %rdi
               	movsbq	(%rcx), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	%rdx, %rax
               	movsbq	(%rax), %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	(%rax), %rsi
               	movsbq	(%rcx), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x16, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	0x20(%rdx), %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	(%rax), %rsi
               	movsbq	(%rcx), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	leaq	0x2b(%rdx), %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	(%rax), %rsi
               	movsbq	(%rcx), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	leaq	0x36(%rdx), %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	(%rax), %rsi
               	movsbq	(%rcx), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	leaq	0x41(%rdx), %rax
               	cmpq	%rax, %r9
               	jae	<addr>
               	cmpq	%rdx, %r9
               	jb	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rax), %rdx
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
               	leaq	<rip>, %rax
               	addq	$0x20, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rax), %rdx
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
               	leaq	<rip>, %rax
               	addq	$0x2b, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rax), %rdx
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
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rax), %rdx
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
               	leaq	<rip>, %rax
               	addq	$0x20, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rax), %rdx
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
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rax), %rdx
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
               	xorq	%rax, %rax
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
