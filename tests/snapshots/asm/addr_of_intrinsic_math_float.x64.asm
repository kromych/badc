
addr_of_intrinsic_math_float.x64:	file format elf64-x86-64

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
               	subq	$0xb0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	<rip>, %rax       # <addr>
               	leaq	<rip>, %rbx       # <addr>
               	leaq	<rip>, %r12       # <addr>
               	leaq	<rip>, %r13       # <addr>
               	movl	$0x41800000, %edi       # imm = 0x41800000
               	movq	%rdi, %xmm0
               	callq	*%rax
               	movl	$0x40800000, %eax       # imm = 0x40800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x402ccccd, %edi       # imm = 0x402CCCCD
               	movq	%rbx, %rax
               	movq	%rdi, %xmm0
               	callq	*%rax
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x40066666, %edi       # imm = 0x40066666
               	movq	%r12, %rax
               	movq	%rdi, %xmm0
               	callq	*%rax
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4039999a, %edi       # imm = 0x4039999A
               	movq	%r13, %rax
               	movq	%rdi, %xmm0
               	callq	*%rax
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax       # <addr>
               	movl	$0x40600000, %ebx       # imm = 0x40600000
               	movq	%rbx, %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	callq	*%rax
               	movq	%rbx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	popq	%rdx
               	movl	$0x42a20000, %eax       # imm = 0x42A20000
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x48(%rbp,%riz)
               	movl	$0x40bccccd, %eax       # imm = 0x40BCCCCD
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x50(%rbp,%riz)
               	movl	$0x40066666, %eax       # imm = 0x40066666
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x58(%rbp,%riz)
               	leaq	-0x40(%rbp), %rax
               	movq	(%rax), %rax
               	movss	-0x48(%rbp,%riz), %xmm0
               	callq	*%rax
               	movl	$0x41100000, %eax       # imm = 0x41100000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movss	-0x50(%rbp,%riz), %xmm0
               	callq	*%rax
               	movl	$0x40a00000, %eax       # imm = 0x40A00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	movq	0x10(%rax), %rax
               	movss	-0x58(%rbp,%riz), %xmm0
               	callq	*%rax
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x40e00000, %eax       # imm = 0x40E00000
               	movq	%rax, %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movl	$0x7fffffff, %r10d      # imm = 0x7FFFFFFF
               	movq	%r10, %xmm15
               	andpd	%xmm15, %xmm0
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x42440000, %eax       # imm = 0x42440000
               	movq	%rax, %xmm0
               	sqrtss	%xmm0, %xmm0
               	movl	$0x40e00000, %eax       # imm = 0x40E00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq

<__c5_sys_sqrtf>:
               	jmp	<addr>

<__c5_sys_floorf>:
               	jmp	<addr>

<__c5_sys_ceilf>:
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
