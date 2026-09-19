
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
               	movl	$0x80, %eax
               	movq	$-0x80, %rcx
               	movb	%cl, (%rdi)
               	movb	%al, 0x1(%rdi)
               	movl	$0x8000, %eax           # imm = 0x8000
               	movq	$-0x8000, %rcx          # imm = 0x8000
               	movw	%cx, 0x2(%rdi)
               	movw	%ax, 0x4(%rdi)
               	movl	$0x80000000, %eax       # imm = 0x80000000
               	movq	$-0x80000000, %rcx      # imm = 0x80000000
               	movl	%ecx, 0x8(%rdi)
               	movl	%eax, 0xc(%rdi)
               	movq	$-0x1, %rax
               	movq	%rax, 0x10(%rdi)
               	xorl	%eax, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	leaq	<rip>, %rax
               	movl	$0x20, %ecx
               	movb	%cl, 0x1(%rax)
               	leaq	<rip>, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %ebx
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movb	%cl, (%rax)
               	movl	$0x2, %ecx
               	movb	%cl, 0x1(%rax)
               	movl	$0x3, %ecx
               	movb	%cl, (%rax)
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax
               	movq	%rax, (%rcx)
               	movl	$0x4, %ecx
               	movb	%cl, (%rax)
               	movl	$0x9, %edx
               	movb	%dl, (%rax)
               	leaq	<rip>, %rax
               	movb	%cl, (%rax)
               	movb	%dl, 0x1(%rax)
               	leaq	<rip>, %rax
               	movl	$0x5, %ecx
               	movb	%cl, (%rax)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movl	$0x7, %edx
               	movb	%dl, (%rcx)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	movzbq	(%rax), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	orq	$0x20, %rbx
               	leaq	<rip>, %rax
               	movl	$0x6, %ecx
               	movb	%cl, (%rax)
               	movzbq	(%rax), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	orq	$0x40, %rbx
               	movslq	%ebx, %rax
               	popq	%rbx
               	leave
               	retq
