
string_gnu_ext.x64:	file format elf64-x86-64

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
               	subq	$0x28, %rsp
               	leaq	<rip>, %rdi
               	movl	$0x62, %esi
               	callq	<addr>
               	leaq	<rip>, %rcx
               	incq	%rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x7a, %esi
               	leaq	<rip>, %rdi
               	callq	<addr>
               	leaq	<rip>, %rcx
               	addq	$0x6, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%esi, %esi
               	leaq	<rip>, %rdi
               	callq	<addr>
               	leaq	<rip>, %rcx
               	addq	$0x6, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x61, %esi
               	leaq	<rip>, %rdi
               	callq	<addr>
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%esi, %esi
               	leaq	<rip>, %rdi
               	callq	<addr>
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x61, %esi
               	leaq	<rip>, %rdi
               	callq	<addr>
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x161, %esi            # imm = 0x161
               	leaq	<rip>, %rdi
               	callq	<addr>
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0xff, %esi
               	leaq	<rip>, %rdi
               	callq	<addr>
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x71, %esi
               	leaq	<rip>, %rdi
               	callq	<addr>
               	leaq	<rip>, %rcx
               	addq	$0x2, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x61, %esi
               	movl	$0x620061, 0x18(%rsp)   # imm = 0x620061
               	leaq	0x18(%rsp), %rdi
               	movb	%sil, 0x1c(%rsp)
               	movl	$0x5, %edx
               	callq	<addr>
               	leaq	0x18(%rsp), %rdi
               	leaq	0x4(%rdi), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%esi, %esi
               	movl	$0x5, %edx
               	callq	<addr>
               	leaq	0x18(%rsp), %rdi
               	leaq	0x3(%rdi), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x7a, %esi
               	movl	$0x5, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	0x18(%rsp), %rdi
               	movl	$0x61, %esi
               	xorl	%edx, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	0x18(%rsp), %rdi
               	movl	$0x61, %esi
               	movl	$0x3, %edx
               	callq	<addr>
               	leaq	0x18(%rsp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0xff, %esi
               	movl	$0x2, %edx
               	leaq	<rip>, %rdi
               	callq	<addr>
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	0x10(%rsp), %rax
               	movabsq	$0x7878787878787878, %rcx # imm = 0x7878787878787878
               	movq	%rcx, 0x10(%rsp)
               	leaq	0x2(%rax), %rdi
               	movl	$0x4, %esi
               	callq	<addr>
               	movsbq	0x10(%rsp), %rax
               	cmpl	$0x78, %eax
               	jne	<addr>
               	movsbq	0x11(%rsp), %rax
               	cmpl	$0x78, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x28, %rsp
               	retq
               	cmpb	$0x0, 0x12(%rsp)
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x28, %rsp
               	retq
               	cmpb	$0x0, 0x13(%rsp)
               	jne	<addr>
               	cmpb	$0x0, 0x14(%rsp)
               	jne	<addr>
               	cmpb	$0x0, 0x15(%rsp)
               	jne	<addr>
               	movsbq	0x16(%rsp), %rax
               	cmpl	$0x78, %eax
               	jne	<addr>
               	leaq	0x10(%rsp), %rdi
               	movsbq	0x17(%rsp), %rax
               	cmpl	$0x78, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%esi, %esi
               	movb	$0x79, 0x10(%rsp)
               	callq	<addr>
               	movsbq	0x10(%rsp), %rax
               	cmpl	$0x79, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x3, %esi
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rsi
               	movq	%rcx, 0x8(%rsp)
               	movq	%rcx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	0x8(%rsp), %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	%rcx, %rdi
               	callq	<addr>
               	movl	$0x64, %esi
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rsi
               	movq	%rcx, 0x8(%rsp)
               	movq	%rcx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	0x8(%rsp), %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	%rcx, %rdi
               	callq	<addr>
               	xorl	%esi, %esi
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	cmpb	$0x0, (%rdi)
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x28, %rsp
               	retq
               	callq	<addr>
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
