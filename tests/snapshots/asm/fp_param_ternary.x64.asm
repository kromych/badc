
fp_param_ternary.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<pick>:
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	je	<addr>
               	retq
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	jmp	<addr>

<grad_dot>:
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rdi, %rax
               	andq	$0x2, %rax
               	testq	%rax, %rax
               	je	<addr>
               	addss	%xmm1, %xmm0
               	retq
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	jmp	<addr>
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%rdi, %rdi
               	movl	$0x40a00000, %ebx       # imm = 0x40A00000
               	movq	%rbx, %xmm0
               	callq	<addr>
               	movq	%rbx, %xmm1
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	ucomiss	%xmm1, %xmm0
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
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	movl	$0x40a00000, %ebx       # imm = 0x40A00000
               	movq	%rbx, %xmm0
               	callq	<addr>
               	movq	%rbx, %xmm15
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
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	movl	$0x40a00000, %ebx       # imm = 0x40A00000
               	movq	%rbx, %xmm0
               	callq	<addr>
               	movq	%rbx, %xmm1
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	ucomiss	%xmm1, %xmm0
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
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	movl	$0x40a00000, %ebx       # imm = 0x40A00000
               	movq	%rbx, %xmm0
               	callq	<addr>
               	movq	%rbx, %xmm15
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
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	movl	$0x3fc00000, %ebx       # imm = 0x3FC00000
               	movl	$0x40200000, %r12d      # imm = 0x40200000
               	movq	%rbx, %xmm0
               	movq	%r12, %xmm1
               	callq	<addr>
               	movq	%r12, %xmm1
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movapd	%xmm1, %xmm15
               	movq	%rbx, %xmm1
               	addss	%xmm15, %xmm1
               	ucomiss	%xmm1, %xmm0
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
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	movl	$0x40e80000, %ebx       # imm = 0x40E80000
               	movl	$0x3e000000, %r12d      # imm = 0x3E000000
               	movq	%rbx, %xmm0
               	movq	%r12, %xmm1
               	callq	<addr>
               	movq	%rbx, %xmm1
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movq	%r12, %xmm15
               	addss	%xmm15, %xmm1
               	ucomiss	%xmm1, %xmm0
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
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	movl	$0x40400000, %ebx       # imm = 0x40400000
               	movl	$0x40800000, %r12d      # imm = 0x40800000
               	movq	%rbx, %xmm0
               	movq	%r12, %xmm1
               	callq	<addr>
               	movq	%r12, %xmm15
               	movq	%rbx, %xmm1
               	addss	%xmm15, %xmm1
               	ucomiss	%xmm1, %xmm0
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
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
