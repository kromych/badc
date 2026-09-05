
ftw_walk.x64:	file format elf64-x86-64

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

<visit>:
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x120, %rsp            # imm = 0x120
               	leaq	-0x118(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	movzbq	0x10(%rax), %rcx
               	movb	%cl, 0x10(%rdi)
               	movzbq	0x11(%rax), %rcx
               	movb	%cl, 0x11(%rdi)
               	movzbq	0x12(%rax), %rcx
               	movb	%cl, 0x12(%rdi)
               	movzbq	0x13(%rax), %rcx
               	movb	%cl, 0x13(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x100(%rbp), %rdi
               	movl	$0x100, %esi            # imm = 0x100
               	leaq	<rip>, %rdx
               	leaq	-0x118(%rbp), %rcx
               	xorq	%r8, %r8
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x100(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x100(%rbp), %rdi
               	movl	$0x100, %esi            # imm = 0x100
               	leaq	<rip>, %rdx
               	leaq	-0x118(%rbp), %rcx
               	movl	$0x1, %r8d
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x100(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x100(%rbp), %rdi
               	movl	$0x100, %esi            # imm = 0x100
               	leaq	<rip>, %rdx
               	leaq	-0x118(%rbp), %rcx
               	movl	$0x2, %r8d
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x100(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x118(%rbp), %rdi
               	leaq	-<rip>, %rsi      # <addr>
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x4, %eax
               	setge	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	movl	$0x3, %eax
               	jmp	<addr>
