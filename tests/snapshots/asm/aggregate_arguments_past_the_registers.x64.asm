
aggregate_arguments_past_the_registers.x64:	file format elf64-x86-64

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

<tail>:
               	subq	$0x28, %rsp
               	movq	0x30(%rsp), %r10
               	movq	%r10, (%rsp)
               	movq	0x38(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x40(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x48(%rsp), %r10
               	movq	%r10, 0x18(%rsp)
               	shlq	%rsi
               	leaq	(%rdi,%rsi), %rax
               	leaq	(%rdx,%rdx,2), %rdx
               	addq	%rdx, %rax
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	leaq	(%r8,%r8,4), %rcx
               	addq	%rcx, %rax
               	movq	(%rsp), %rcx
               	imulq	$0x6, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x8(%rsp), %rcx
               	imulq	$0x7, %rcx, %rcx
               	addq	%rcx, %rax
               	cvttsd2si	%xmm0, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	leaq	(%r9,%r9,8), %rcx
               	addq	%rcx, %rax
               	movq	0x10(%rsp), %rcx
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x18(%rsp), %rcx
               	imulq	$0xb, %rcx, %rcx
               	addq	%rcx, %rax
               	addq	$0x28, %rsp
               	retq

<four>:
               	subq	$0x18, %rsp
               	movq	0x20(%rsp), %r10
               	movq	%r10, (%rsp)
               	movq	0x28(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	shlq	%rsi
               	leaq	(%rdi,%rsi), %rax
               	leaq	(%rdx,%rdx,2), %rdx
               	addq	%rdx, %rax
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	leaq	(%r8,%r8,4), %rcx
               	addq	%rcx, %rax
               	imulq	$0x6, %r9, %rcx
               	addq	%rcx, %rax
               	movq	(%rsp), %rcx
               	imulq	$0x7, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x8(%rsp), %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	addq	$0x18, %rsp
               	retq

<fp>:
               	subq	$0x28, %rsp
               	movq	0x30(%rsp), %r10
               	movq	%r10, (%rsp)
               	movq	0x38(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x40(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x48(%rsp), %r10
               	movq	%r10, 0x18(%rsp)
               	vfmadd231sd	<rip>, %xmm1, %xmm0 # xmm0 = (xmm1 * mem) + xmm0
               	vfmadd231sd	<rip>, %xmm2, %xmm0 # xmm0 = (xmm2 * mem) + xmm0
               	vfmadd231sd	<rip>, %xmm3, %xmm0 # xmm0 = (xmm3 * mem) + xmm0
               	vfmadd231sd	<rip>, %xmm4, %xmm0 # xmm0 = (xmm4 * mem) + xmm0
               	vfmadd231sd	<rip>, %xmm5, %xmm0 # xmm0 = (xmm5 * mem) + xmm0
               	vfmadd231sd	<rip>, %xmm6, %xmm0 # xmm0 = (xmm6 * mem) + xmm0
               	vfmadd231sd	<rip>, %xmm7, %xmm0 # xmm0 = (xmm7 * mem) + xmm0
               	movsd	(%rsp), %xmm1
               	vfmadd231sd	<rip>, %xmm1, %xmm0 # xmm0 = (xmm1 * mem) + xmm0
               	movsd	0x8(%rsp), %xmm1
               	vfmadd231sd	<rip>, %xmm1, %xmm0 # xmm0 = (xmm1 * mem) + xmm0
               	movq	0x10(%rsp), %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	vfmadd231sd	<rip>, %xmm1, %xmm0 # xmm0 = (xmm1 * mem) + xmm0
               	movsd	0x18(%rsp), %xmm1
               	vfmadd231sd	<rip>, %xmm1, %xmm0 # xmm0 = (xmm1 * mem) + xmm0
               	addq	$0x28, %rsp
               	retq

<make>:
               	movq	%rdi, %rax
               	movq	%rsi, %rdx
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x68, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, -0x10(%rbp)
               	movl	$0x9, %eax
               	movl	$0xa, %r9d
               	movl	$0x3, %edx
               	movq	%rdx, -0x8(%rbp)
               	movl	$0x1, %r8d
               	movl	$0x2, %ebx
               	movl	$0x4, %r12d
               	movl	$0x5, %r13d
               	movl	$0x6, %ecx
               	movl	$0x7, %esi
               	movsd	<rip>, %xmm0
               	movl	$0x9, %edi
               	subq	$0x20, %rsp
               	movq	%rcx, (%rsp)
               	movq	%rsi, 0x8(%rsp)
               	movq	%rax, 0x10(%rsp)
               	movq	%r9, 0x18(%rsp)
               	movq	%rbx, %rsi
               	movq	%rdi, %r9
               	movq	%r12, %rcx
               	movq	%r8, %rdi
               	movq	%r13, %r8
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x1e5, %rax            # imm = 0x1E5
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	-0x8(%rbp), %rdi
               	movq	-0x8(%rbp), %rax
               	leaq	0x1(%rax), %r8
               	movq	-0x8(%rbp), %rdx
               	movq	%rdx, %rbx
               	shlq	%rbx
               	movl	$0x4, %r12d
               	movl	$0x5, %r13d
               	movq	-0x8(%rbp), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movq	-0x8(%rbp), %rax
               	movq	-0x8(%rbp), %r9
               	movl	$0xb, %ecx
               	movl	$0x5, %edx
               	movl	$0x6, %esi
               	subq	$0x20, %rsp
               	movq	%rdx, (%rsp)
               	movq	%rsi, 0x8(%rsp)
               	movq	%r9, 0x10(%rsp)
               	movq	%rcx, 0x18(%rsp)
               	movq	%r8, %rsi
               	movq	%rax, %r9
               	movq	%r13, %r8
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x158, %rax            # imm = 0x158
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x3, %edi
               	movl	$0x4, %esi
               	callq	<addr>
               	movq	-0x8(%rbp), %rcx
               	movq	-0x8(%rbp), %rsi
               	addq	$0x5, %rsi
               	movl	$0x1, %edi
               	movl	$0x2, %r8d
               	movl	$0x7, %r9d
               	movl	$0x8, %ebx
               	subq	$0x10, %rsp
               	movq	%rcx, (%rsp)
               	movq	%rsi, 0x8(%rsp)
               	movq	%r8, %rsi
               	movq	%rdx, %rcx
               	movq	%r9, %r8
               	movq	%rbx, %r9
               	movq	%rax, %rdx
               	callq	<addr>
               	addq	$0x10, %rsp
               	cmpq	$0xc6, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	-0x10(%rbp), %rax
               	movq	(%rax), %rbx
               	movl	$0x1, %edi
               	movl	$0x2, %r8d
               	movl	$0x3, %r12d
               	movl	$0x4, %r13d
               	movl	$0x5, %r10d
               	movq	%r10, 0x28(%rsp)
               	movl	$0x6, %eax
               	movl	$0x7, %r9d
               	movsd	<rip>, %xmm0
               	movl	$0x9, %ecx
               	movl	$0x9, %edx
               	movl	$0xa, %esi
               	subq	$0x20, %rsp
               	movq	%rax, (%rsp)
               	movq	%r9, 0x8(%rsp)
               	movq	%rdx, 0x10(%rsp)
               	movq	%rsi, 0x18(%rsp)
               	movq	%r8, %rsi
               	movq	%rcx, %r9
               	movq	%r13, %rcx
               	movq	%r12, %rdx
               	movq	0x48(%rsp), %r8
               	callq	*%rbx
               	addq	$0x20, %rsp
               	cmpq	$0x1e5, %rax            # imm = 0x1E5
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	-0x50(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movsd	-0x50(%rbp), %xmm0
               	movsd	-0x48(%rbp), %xmm1
               	movsd	-0x40(%rbp), %xmm2
               	movsd	-0x38(%rbp), %xmm3
               	movsd	-0x30(%rbp), %xmm4
               	movsd	-0x28(%rbp), %xmm5
               	movl	$0x2, %eax
               	movsd	<rip>, %xmm6
               	subq	$0x20, %rsp
               	movq	%xmm0, %r10
               	movq	%r10, (%rsp)
               	movq	%xmm1, %r10
               	movq	%r10, 0x8(%rsp)
               	movq	%rax, 0x10(%rsp)
               	movq	%xmm6, %r10
               	movq	%r10, 0x18(%rsp)
               	movapd	%xmm4, %xmm6
               	movapd	%xmm5, %xmm7
               	movapd	%xmm0, %xmm4
               	movapd	%xmm1, %xmm5
               	callq	<addr>
               	addq	$0x20, %rsp
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
