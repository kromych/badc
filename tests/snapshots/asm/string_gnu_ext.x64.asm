
string_gnu_ext.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	leaq	<rip>, %rdi
               	movl	$0x62, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rcx
               	incq	%rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x7a, %esi
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rcx
               	addq	$0x6, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%esi, %esi
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rcx
               	addq	$0x6, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x61, %esi
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%esi, %esi
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0x61, %esi
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0x161, %esi            # imm = 0x161
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movl	$0xff, %esi
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	movl	$0x71, %esi
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rcx
               	addq	$0x2, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	movl	$0x61, %esi
               	movb	%sil, -0x8(%rbp)
               	movb	$0x0, -0x7(%rbp)
               	movb	$0x62, -0x6(%rbp)
               	movb	$0x0, -0x5(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	movb	%sil, -0x4(%rbp)
               	movl	$0x5, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x8(%rbp), %rdi
               	leaq	0x4(%rdi), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	xorl	%esi, %esi
               	movl	$0x5, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x8(%rbp), %rdi
               	leaq	0x3(%rdi), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	$0x7a, %esi
               	movl	$0x5, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rdi
               	movl	$0x61, %esi
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rdi
               	movl	$0x61, %esi
               	movl	$0x3, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x8(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movl	$0xff, %esi
               	movl	$0x2, %edx
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	movabsq	$0x7878787878787878, %rcx # imm = 0x7878787878787878
               	movq	%rcx, -0x10(%rbp)
               	leaq	0x2(%rax), %rdi
               	movl	$0x4, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movsbq	-0x10(%rbp), %rax
               	cmpl	$0x78, %eax
               	jne	<addr>
               	movsbq	-0xf(%rbp), %rax
               	cmpl	$0x78, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	cmpb	$0x0, -0xe(%rbp)
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	cmpb	$0x0, -0xd(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0xc(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0xb(%rbp)
               	jne	<addr>
               	movsbq	-0xa(%rbp), %rax
               	cmpl	$0x78, %eax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rdi
               	movsbq	-0x9(%rbp), %rax
               	cmpl	$0x78, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	xorl	%esi, %esi
               	movb	$0x79, -0x10(%rbp)
               	xorl	%eax, %eax
               	callq	<addr>
               	movsbq	-0x10(%rbp), %rax
               	cmpl	$0x79, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	movl	$0x3, %esi
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x8(%rsp), %r10
               	testq	%r10, %r10
               	je	<addr>
               	leaq	<rip>, %rsi
               	movq	0x8(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	movq	0x8(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x64, %esi
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x8(%rsp), %r10
               	testq	%r10, %r10
               	je	<addr>
               	leaq	<rip>, %rsi
               	movq	0x8(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	movq	0x8(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%esi, %esi
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	cmpb	$0x0, (%rdi)
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
