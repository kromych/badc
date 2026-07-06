
local_array_partial_init_zero.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<clobber>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0xa0(%rbp), %rax
               	movslq	%ecx, %rdx
               	movl	%edi, %esi
               	movl	%esi, (%rax,%rdx,4)
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x28, %rax
               	jl	<addr>
               	leaq	-0xa0(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	(%rax), %eax
               	leaq	-0xa0(%rbp), %rdx
               	movl	0x9c(%rdx), %edx
               	addq	%rdx, %rax
               	movl	%eax, %eax
               	movl	%eax, -0xb0(%rbp)
               	movl	-0xb0(%rbp), %eax
               	movq	%rcx, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq

<sum_partial_init>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	leaq	-0x68(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x20(%rax)
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x28(%rax)
               	movq	0x30(%rcx), %rdx
               	movq	%rdx, 0x30(%rax)
               	movq	0x38(%rcx), %rdx
               	movq	%rdx, 0x38(%rax)
               	movq	0x40(%rcx), %rdx
               	movq	%rdx, 0x40(%rax)
               	movq	0x48(%rcx), %rdx
               	movq	%rdx, 0x48(%rax)
               	movq	0x50(%rcx), %rdx
               	movq	%rdx, 0x50(%rax)
               	movq	0x58(%rcx), %rdx
               	movq	%rdx, 0x58(%rax)
               	movzbq	0x60(%rcx), %rdx
               	movb	%dl, 0x60(%rax)
               	movzbq	0x61(%rcx), %rdx
               	movb	%dl, 0x61(%rax)
               	movzbq	0x62(%rcx), %rdx
               	movb	%dl, 0x62(%rax)
               	movzbq	0x63(%rcx), %rdx
               	movb	%dl, 0x63(%rax)
               	popq	%rdx
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movl	%eax, %eax
               	leaq	-0x68(%rbp), %rdx
               	movslq	%ecx, %rsi
               	movl	(%rdx,%rsi,4), %edx
               	addq	%rdx, %rax
               	movslq	%ecx, %rcx
               	incq	%rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x19, %rdx
               	jl	<addr>
               	movl	%eax, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0xdeadbeef, %edi       # imm = 0xDEADBEEF
               	callq	<addr>
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x12345678, %edi       # imm = 0x12345678
               	callq	<addr>
               	callq	<addr>
               	movl	%ebx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
