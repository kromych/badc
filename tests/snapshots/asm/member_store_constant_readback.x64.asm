
member_store_constant_readback.x64:	file format elf64-x86-64

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

<narrow_sign>:
               	movb	$-0x80, (%rdi)
               	movb	$-0x80, 0x1(%rdi)
               	movw	$0x8000, 0x2(%rdi)      # imm = 0x8000
               	movw	$0x8000, 0x4(%rdi)      # imm = 0x8000
               	movl	$0x80000000, 0x8(%rdi)  # imm = 0x80000000
               	movl	$0x80000000, 0xc(%rdi)  # imm = 0x80000000
               	movq	$-0x1, 0x10(%rdi)
               	xorl	%eax, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	leaq	<rip>, %rdi
               	movb	$0x20, 0x1(%rdi)
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %ebx
               	leaq	<rip>, %rax
               	movb	$0x1, (%rax)
               	movb	$0x2, 0x1(%rax)
               	movb	$0x3, (%rax)
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	movb	$0x4, (%rax)
               	movb	$0x9, (%rax)
               	movb	$0x4, (%rax)
               	movb	$0x9, 0x1(%rax)
               	movb	$0x5, (%rax)
               	movq	(%rcx), %rcx
               	movb	$0x7, (%rcx)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	movzbq	(%rax), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	orq	$0x20, %rbx
               	leaq	<rip>, %rax
               	movb	$0x6, (%rax)
               	movzbq	(%rax), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	orq	$0x40, %rbx
               	movq	%rbx, %rax
               	popq	%rbx
               	leave
               	retq
