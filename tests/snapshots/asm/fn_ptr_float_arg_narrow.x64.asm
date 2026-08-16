
fn_ptr_float_arg_narrow.x64:	file format elf64-x86-64

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

<scale2>:
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	retq

<negf>:
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	retq

<addf>:
               	addss	%xmm1, %xmm0
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	-<rip>, %rbx       # <addr>
               	leaq	-<rip>, %r12       # <addr>
               	movl	$0x40400000, %edi       # imm = 0x40400000
               	movq	%rbx, %rax
               	movq	%rdi, %xmm0
               	callq	*%rax
               	movl	$0x40c00000, %eax       # imm = 0x40C00000
               	movq	%rax, %xmm15
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
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x40400000, %r13d      # imm = 0x40400000
               	movq	%r12, %rax
               	movq	%r13, %xmm0
               	callq	*%rax
               	movq	%r13, %xmm1
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
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x40800000, %edi       # imm = 0x40800000
               	movq	%rbx, %rax
               	movq	%rdi, %xmm0
               	callq	*%rax
               	movl	$0x41000000, %eax       # imm = 0x41000000
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
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rax      # <addr>
               	movl	$0x3fc00000, %edi       # imm = 0x3FC00000
               	movl	$0x40000000, %esi       # imm = 0x40000000
               	movq	%rdi, %xmm0
               	movq	%rsi, %xmm1
               	callq	*%rax
               	movl	$0x40600000, %eax       # imm = 0x40600000
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
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x40a00000, %edi       # imm = 0x40A00000
               	movq	%rbx, %rax
               	movq	%rdi, %xmm0
               	callq	*%rax
               	movl	$0x41200000, %eax       # imm = 0x41200000
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
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x40e00000, %eax       # imm = 0x40E00000
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x38(%rbp,%riz)
               	movss	-0x38(%rbp,%riz), %xmm0
               	movq	%rbx, %rax
               	callq	*%rax
               	movl	$0x41600000, %eax       # imm = 0x41600000
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
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-<rip>, %r13      # <addr>
               	movl	$0x40400000, %edi       # imm = 0x40400000
               	movq	%rbx, %rax
               	movq	%rdi, %xmm0
               	callq	*%rax
               	movl	$0x40c00000, %eax       # imm = 0x40C00000
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
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x40400000, %edi       # imm = 0x40400000
               	movq	%rbx, %rax
               	movq	%rdi, %xmm0
               	callq	*%rax
               	movl	$0x40c00000, %eax       # imm = 0x40C00000
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
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3fc00000, %edi       # imm = 0x3FC00000
               	movl	$0x40000000, %esi       # imm = 0x40000000
               	movq	%r13, %rax
               	movq	%rdi, %xmm0
               	movq	%rsi, %xmm1
               	callq	*%rax
               	movl	$0x40600000, %eax       # imm = 0x40600000
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
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
