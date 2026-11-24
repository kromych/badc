
c99_float_math_and_vsscanf.x64:	file format elf64-x86-64

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

<scan>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rdi, -0xd0(%rbp)
               	movq	%rsi, -0xc8(%rbp)
               	movq	%rdx, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%r8, -0xb0(%rbp)
               	movq	%r9, -0xa8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xa0(%rbp)
               	movups	%xmm1, -0x90(%rbp)
               	movups	%xmm2, -0x80(%rbp)
               	movups	%xmm3, -0x70(%rbp)
               	movups	%xmm4, -0x60(%rbp)
               	movups	%xmm5, -0x50(%rbp)
               	movups	%xmm6, -0x40(%rbp)
               	movups	%xmm7, -0x30(%rbp)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xc8(%rbp), %rcx
               	movl	$0x10, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	movq	-0xd0(%rbp), %rdi
               	movq	-0xc8(%rbp), %rsi
               	leaq	-0x18(%rbp), %rdx
               	callq	<addr>
               	leaq	-0x18(%rbp), %rcx
               	leave
               	retq

<main>:
               	subq	$0x48, %rsp
               	movl	$0x0, 0x28(%rsp)
               	movl	$0x41000000, 0x30(%rsp) # imm = 0x41000000
               	movl	$0x40400000, 0x38(%rsp) # imm = 0x40400000
               	movss	0x28(%rsp), %xmm0
               	callq	<addr>
               	xorps	%xmm1, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0x28(%rsp), %xmm0
               	callq	<addr>
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0x28(%rsp), %xmm0
               	callq	<addr>
               	xorps	%xmm1, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x48, %rsp
               	retq
               	movss	0x30(%rsp), %xmm0
               	callq	<addr>
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0x38(%rsp), %xmm0
               	callq	<addr>
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x48, %rsp
               	retq
               	movl	$0x0, 0x8(%rsp)
               	movss	0x30(%rsp), %xmm0
               	leaq	0x8(%rsp), %rdi
               	callq	<addr>
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	0x8(%rsp), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x48, %rsp
               	retq
               	movss	<rip>, %xmm0
               	movl	$0x3, %edi
               	callq	<addr>
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x48, %rsp
               	retq
               	movl	$0x0, 0x10(%rsp)
               	movss	<rip>, %xmm0
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0x10(%rsp), %xmm0
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x48, %rsp
               	retq
               	movss	<rip>, %xmm0
               	callq	<addr>
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movss	<rip>, %xmm0
               	callq	<addr>
               	cmpq	$-0x3, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x48, %rsp
               	retq
               	movss	0x38(%rsp), %xmm0
               	callq	<addr>
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movss	0x38(%rsp), %xmm0
               	vxorpd	<rip>, %xmm0, %xmm0
               	callq	<addr>
               	cmpq	$-0x3, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x48, %rsp
               	retq
               	movl	$0x0, 0x18(%rsp)
               	movl	$0x0, 0x20(%rsp)
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	leaq	0x18(%rsp), %rdx
               	leaq	0x20(%rsp), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movl	0x18(%rsp), %eax
               	cmpl	$0xc, %eax
               	jne	<addr>
               	movl	0x20(%rsp), %eax
               	cmpl	$0x22, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x48, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x48, %rsp
               	retq
