
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
               	subq	$0x18, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rbx
               	leaq	<rip>, %r13
               	leaq	<rip>, %r12
               	movl	$0x62, %esi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x1(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x7a, %esi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x6(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%esi, %esi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x6(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x61, %esi
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	%r13, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%esi, %esi
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	%r13, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x61, %esi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x161, %esi            # imm = 0x161
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0xff, %esi
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	%r12, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x71, %esi
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x2(%r12), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	$0x61, %esi
               	movb	%sil, (%rax)
               	movb	$0x0, 0x1(%rax)
               	movb	$0x62, 0x2(%rax)
               	movb	$0x0, 0x3(%rax)
               	leaq	-0x8(%rbp), %rdi
               	movb	%sil, 0x4(%rdi)
               	movl	$0x5, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x8(%rbp), %rdi
               	leaq	0x4(%rdi), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
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
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x7a, %esi
               	movl	$0x5, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
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
               	popq	%rbx
               	popq	%r12
               	popq	%r13
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
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0xff, %esi
               	movl	$0x2, %edx
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	%r12, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	movabsq	$0x7878787878787878, %rcx # imm = 0x7878787878787878
               	movq	%rcx, (%rax)
               	leaq	0x2(%rax), %rdi
               	movl	$0x4, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x10(%rbp), %rax
               	movsbq	(%rax), %rcx
               	cmpl	$0x78, %ecx
               	jne	<addr>
               	movsbq	0x1(%rax), %rcx
               	cmpl	$0x78, %ecx
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	cmpb	$0x0, 0x2(%rax)
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	cmpb	$0x0, 0x3(%rax)
               	jne	<addr>
               	cmpb	$0x0, 0x4(%rax)
               	jne	<addr>
               	cmpb	$0x0, 0x5(%rax)
               	jne	<addr>
               	movsbq	0x6(%rax), %rax
               	cmpl	$0x78, %eax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rdi
               	movsbq	0x7(%rdi), %rax
               	cmpl	$0x78, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%esi, %esi
               	movb	$0x79, (%rdi)
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x10(%rbp), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x79, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x3, %esi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	testq	%r12, %r12
               	je	<addr>
               	leaq	<rip>, %rsi
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x64, %esi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	testq	%r12, %r12
               	je	<addr>
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%esi, %esi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	cmpb	$0x0, (%rdi)
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
