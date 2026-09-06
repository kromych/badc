
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
               	xorq	%rcx, %rcx
               	movl	$0x80, %eax
               	movabsq	$-0x80, %rdx
               	movb	%dl, (%rdi)
               	movb	%al, 0x1(%rdi)
               	movq	%rcx, %rax
               	movl	$0x8000, %edx           # imm = 0x8000
               	movabsq	$-0x8000, %rsi          # imm = 0x8000
               	movw	%si, 0x2(%rdi)
               	movw	%dx, 0x4(%rdi)
               	movl	$0x80000000, %edx       # imm = 0x80000000
               	movabsq	$-0x80000000, %rsi      # imm = 0x80000000
               	movl	%esi, 0x8(%rdi)
               	movl	%edx, 0xc(%rdi)
               	movabsq	$-0x1, %rdx
               	movq	%rdx, 0x10(%rdi)
               	movq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rbx, %rbx
               	leaq	<rip>, %rax
               	movl	$0x20, %ecx
               	movb	%cl, 0x1(%rax)
               	movl	$0x1, %ecx
               	movq	%rbx, %rcx
               	movq	%rbx, %rdx
               	movq	%rax, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %ebx
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movb	%cl, (%rax)
               	movl	$0x2, %edx
               	movb	%dl, 0x1(%rax)
               	movl	$0x3, %edx
               	movb	%dl, (%rax)
               	xorq	%rax, %rax
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
               	movl	$0xc, %eax
               	movq	%rax, %rcx
               	movslq	%ebx, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
