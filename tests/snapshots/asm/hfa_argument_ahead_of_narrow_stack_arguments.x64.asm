
hfa_argument_ahead_of_narrow_stack_arguments.x64:	file format elf64-x86-64

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

<f>:
               	subq	$0x18, %rsp
               	movsd	%xmm0, (%rsp)
               	movsd	%xmm1, 0x8(%rsp)
               	movq	0x30(%rsp), %rax
               	leaq	<rip>, %r10 # <addr>
               	cmpq	%r10, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	(%rax), %eax
               	cmpl	$0x2a, %eax
               	jne	<addr>
               	movl	0x38(%rsp), %eax
               	cmpl	$-0x7, %eax
               	jne	<addr>
               	movl	0x40(%rsp), %eax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movl	0x48(%rsp), %eax
               	cmpl	$-0xb, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x18, %rsp
               	retq
               	movss	(%rsp), %xmm0
               	movss	0x4(%rsp), %xmm1
               	vfmadd231ss	<rip>, %xmm1, %xmm0 # xmm0 = (xmm1 * mem) + xmm0
               	movss	0x8(%rsp), %xmm1
               	vfmadd231ss	<rip>, %xmm1, %xmm0 # xmm0 = (xmm1 * mem) + xmm0
               	movss	0xc(%rsp), %xmm1
               	vfmadd231ss	<rip>, %xmm1, %xmm0 # xmm0 = (xmm1 * mem) + xmm0
               	cvttss2si	%xmm0, %rax
               	addq	%rdi, %rax
               	addq	%rsi, %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	movq	0x20(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x28(%rsp), %rcx
               	addq	%rcx, %rax
               	xorl	%ecx, %ecx
               	movl	$0x3, %edx
               	cmpq	$0x42, %rax
               	movq	%rdx, %rax
               	cmoveq	%rcx, %rax
               	addq	$0x18, %rsp
               	retq

<main>:
               	subq	$0x28, %rsp
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x30, %rsp
               	movl	$0x3f800000, 0x58(%rsp) # imm = 0x3F800000
               	movss	0x58(%rsp), %xmm0
               	leaq	0x48(%rsp), %rax
               	movss	%xmm0, 0x48(%rsp)
               	movss	0x58(%rsp), %xmm0
               	vmulss	<rip>, %xmm0, %xmm0
               	movss	%xmm0, 0x4c(%rsp)
               	movss	0x58(%rsp), %xmm0
               	vmulss	<rip>, %xmm0, %xmm0
               	movss	%xmm0, 0x50(%rsp)
               	movss	0x58(%rsp), %xmm0
               	vmulss	<rip>, %xmm0, %xmm0
               	movss	%xmm0, 0x54(%rsp)
               	movss	0x58(%rsp), %xmm0
               	cvttss2si	%xmm0, %rdi
               	movq	%rdi, %rsi
               	shlq	%rsi
               	leaq	(%rdi,%rdi,2), %rdx
               	movq	%rdi, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rdi,%rdi,4), %r8
               	imulq	$0x6, %rdi, %r9
               	imulq	$0x7, %rdi, %rbx
               	movq	%rdi, %r12
               	shlq	$0x3, %r12
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x10(%rsp)
               	movq	$-0x7, 0x18(%rsp)
               	movq	$0x9, 0x20(%rsp)
               	movq	$-0xb, 0x28(%rsp)
               	movq	%rax, %r10
               	movsd	(%r10), %xmm0
               	movsd	0x8(%r10), %xmm1
               	callq	<addr>
               	addq	$0x30, %rsp
               	popq	%rbx
               	popq	%r12
               	addq	$0x28, %rsp
               	retq
