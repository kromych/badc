
init_brace_intermediate_cast.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	leaq	-0x20(%rbp), %rax
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
               	popq	%rdx
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x38(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x50(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	popq	%rdx
               	movabsq	$-0x6db6db6d, %rax      # imm = 0x92492493
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	cmpq	$-0x6db6db6d, %rdx      # imm = 0x92492493
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movq	0x8(%rcx), %rdx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movq	0x10(%rcx), %rdx
               	cmpq	$-0x1, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movq	0x18(%rcx), %rcx
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	0x8(%rcx), %rcx
               	cmpq	$-0x6db6db6d, %rcx      # imm = 0x92492493
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$-0x38, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpq	$-0x8000, %rcx          # imm = 0x8000
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$-0x6db6db6d, %rcx      # imm = 0x92492493
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	0x8(%rcx), %rcx
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movslq	0x10(%rcx), %rcx
               	cmpq	$-0x38, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$-0x6db6db6d, %rcx      # imm = 0x92492493
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	0x8(%rcx), %rcx
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x2, %rcx
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movsd	(%rcx,%riz), %xmm0
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rcx), %rcx
               	cmpq	$-0x6db6db6d, %rcx      # imm = 0x92492493
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rcx
               	movq	0x10(%rcx), %rcx
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rcx
               	movq	0x18(%rcx), %rcx
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rcx
               	movq	(%rcx), %rcx
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	cmpq	$-0x6db6db6d, %rcx      # imm = 0x92492493
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$-0x38, %rcx
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpq	$-0x8000, %rcx          # imm = 0x8000
               	je	<addr>
               	movl	$0x18, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x50(%rbp), %rcx
               	movq	(%rcx), %rcx
               	cmpq	$-0x6db6db6d, %rcx      # imm = 0x92492493
               	je	<addr>
               	movl	$0x19, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x50(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	movl	$0x1a, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x50(%rbp), %rcx
               	movslq	0x10(%rcx), %rcx
               	cmpq	$-0x38, %rcx
               	je	<addr>
               	movl	$0x1b, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	cmpq	$-0x6db6db6d, %rax      # imm = 0x92492493
               	je	<addr>
               	movl	$0x1c, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
