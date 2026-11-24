
fp_volatile_bank_across_calls.x64:	file format elf64-x86-64

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

<spread>:
               	subq	$0x18, %rsp
               	vaddsd	<rip>, %xmm0, %xmm3
               	vaddsd	<rip>, %xmm0, %xmm4
               	vaddsd	<rip>, %xmm0, %xmm5
               	vaddsd	<rip>, %xmm0, %xmm6
               	vaddsd	<rip>, %xmm1, %xmm7
               	vaddsd	<rip>, %xmm1, %xmm8
               	vaddsd	<rip>, %xmm1, %xmm2
               	vaddsd	<rip>, %xmm1, %xmm9
               	vmulsd	%xmm1, %xmm0, %xmm10
               	vsubsd	%xmm1, %xmm0, %xmm11
               	vmulsd	<rip>, %xmm0, %xmm12
               	vmulsd	<rip>, %xmm1, %xmm13
               	vaddsd	%xmm1, %xmm0, %xmm14
               	movsd	%xmm14, 0x8(%rsp)
               	vsubsd	%xmm0, %xmm1, %xmm14
               	movsd	%xmm14, (%rsp)
               	vmulsd	<rip>, %xmm0, %xmm0
               	vmulsd	<rip>, %xmm1, %xmm1
               	mulsd	%xmm6, %xmm5
               	vfmadd213sd	%xmm5, %xmm4, %xmm3 # xmm3 = (xmm4 * xmm3) + xmm5
               	vfmadd231sd	%xmm8, %xmm7, %xmm3 # xmm3 = (xmm7 * xmm8) + xmm3
               	vfmadd213sd	%xmm3, %xmm9, %xmm2 # xmm2 = (xmm9 * xmm2) + xmm3
               	vfmadd231sd	%xmm11, %xmm10, %xmm2 # xmm2 = (xmm10 * xmm11) + xmm2
               	vfmadd231sd	%xmm13, %xmm12, %xmm2 # xmm2 = (xmm12 * xmm13) + xmm2
               	movsd	0x8(%rsp), %xmm14
               	vfmadd231sd	(%rsp), %xmm14, %xmm2 # xmm2 = (xmm14 * mem) + xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
               	addq	$0x18, %rsp
               	retq

<across>:
               	subq	$0x88, %rsp
               	vmulsd	<rip>, %xmm0, %xmm14
               	movsd	%xmm14, 0x78(%rsp)
               	vmulsd	<rip>, %xmm0, %xmm14
               	movsd	%xmm14, 0x70(%rsp)
               	vmulsd	<rip>, %xmm0, %xmm14
               	movsd	%xmm14, 0x68(%rsp)
               	vmulsd	<rip>, %xmm0, %xmm14
               	movsd	%xmm14, 0x60(%rsp)
               	vmulsd	<rip>, %xmm1, %xmm14
               	movsd	%xmm14, 0x58(%rsp)
               	vmulsd	<rip>, %xmm1, %xmm14
               	movsd	%xmm14, 0x50(%rsp)
               	vmulsd	<rip>, %xmm1, %xmm14
               	movsd	%xmm14, 0x48(%rsp)
               	vmulsd	<rip>, %xmm1, %xmm14
               	movsd	%xmm14, 0x40(%rsp)
               	vaddsd	%xmm1, %xmm0, %xmm14
               	movsd	%xmm14, 0x38(%rsp)
               	vsubsd	%xmm1, %xmm0, %xmm14
               	movsd	%xmm14, 0x30(%rsp)
               	vmulsd	%xmm1, %xmm0, %xmm14
               	movsd	%xmm14, 0x28(%rsp)
               	vaddsd	<rip>, %xmm0, %xmm14
               	movsd	%xmm14, 0x20(%rsp)
               	movsd	%xmm0, 0x10(%rsp)
               	movsd	%xmm1, 0x8(%rsp)
               	callq	<addr>
               	movsd	%xmm0, 0x18(%rsp)
               	movsd	0x10(%rsp), %xmm0
               	movsd	0x8(%rsp), %xmm1
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	movapd	%xmm15, %xmm0
               	callq	<addr>
               	movsd	0x18(%rsp), %xmm14
               	vaddsd	%xmm0, %xmm14, %xmm0
               	vaddsd	0x78(%rsp), %xmm0, %xmm0
               	movsd	0x70(%rsp), %xmm14
               	vfmadd231sd	<rip>, %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movsd	0x68(%rsp), %xmm14
               	vfmadd231sd	<rip>, %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movsd	0x60(%rsp), %xmm14
               	vfmadd231sd	<rip>, %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movsd	0x58(%rsp), %xmm14
               	vfmadd231sd	<rip>, %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movsd	0x50(%rsp), %xmm14
               	vfmadd231sd	<rip>, %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movsd	0x48(%rsp), %xmm14
               	vfmadd231sd	<rip>, %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movsd	0x40(%rsp), %xmm14
               	vfmadd231sd	<rip>, %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movsd	0x38(%rsp), %xmm14
               	vfmadd231sd	<rip>, %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movsd	0x30(%rsp), %xmm14
               	vfmadd231sd	<rip>, %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movsd	0x28(%rsp), %xmm14
               	vfmadd231sd	<rip>, %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	movsd	0x20(%rsp), %xmm14
               	vfmadd231sd	<rip>, %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	addq	$0x88, %rsp
               	retq

<across_ref>:
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	0x1(%rdi), %rax
               	leaq	0x2(%rdi), %rcx
               	imulq	%rcx, %rax
               	leaq	0x3(%rdi), %rcx
               	leaq	0x4(%rdi), %rdx
               	imulq	%rdx, %rcx
               	addq	%rcx, %rax
               	leaq	0x5(%rsi), %rcx
               	leaq	0x6(%rsi), %rdx
               	imulq	%rdx, %rcx
               	addq	%rcx, %rax
               	leaq	0x7(%rsi), %rcx
               	leaq	0x8(%rsi), %rdx
               	imulq	%rdx, %rcx
               	leaq	(%rax,%rcx), %rdx
               	movq	%rdi, %rax
               	imulq	%rsi, %rax
               	movq	%rdi, %rcx
               	subq	%rsi, %rcx
               	movq	%rax, %r8
               	imulq	%rcx, %r8
               	addq	%rdx, %r8
               	leaq	(%rdi,%rdi,2), %rdx
               	movq	%rdx, %r9
               	imulq	%rsi, %r9
               	leaq	(%r9,%r9,4), %r9
               	leaq	(%r8,%r9), %rbx
               	leaq	(%rdi,%rsi), %r8
               	movq	%rsi, %r9
               	subq	%rdi, %r9
               	movq	%r8, %r12
               	imulq	%r9, %r12
               	addq	%r12, %rbx
               	imulq	$0x7, %rdi, %r12
               	imulq	%rsi, %r12
               	leaq	(%r12,%r12,8), %r12
               	addq	%r12, %rbx
               	leaq	0x1(%rsi), %r12
               	leaq	0x2(%rsi), %r13
               	imulq	%r13, %r12
               	leaq	0x3(%rsi), %r13
               	leaq	0x4(%rsi), %r14
               	imulq	%r14, %r13
               	addq	%r13, %r12
               	leaq	0x5(%rdi), %r13
               	leaq	0x6(%rdi), %r14
               	imulq	%r14, %r13
               	addq	%r13, %r12
               	leaq	0x7(%rdi), %r13
               	leaq	0x8(%rdi), %r14
               	imulq	%r14, %r13
               	addq	%r13, %r12
               	imulq	%r9, %rax
               	leaq	(%r12,%rax), %r9
               	leaq	(%rsi,%rsi,2), %rax
               	movq	%rax, %r12
               	imulq	%rdi, %r12
               	leaq	(%r12,%r12,4), %r12
               	addq	%r12, %r9
               	imulq	%r8, %rcx
               	leaq	(%r9,%rcx), %r8
               	imulq	$0x7, %rsi, %rcx
               	movq	%rcx, %r9
               	imulq	%rdi, %r9
               	leaq	(%r9,%r9,8), %r9
               	addq	%r9, %r8
               	addq	%rbx, %r8
               	movq	%rdi, %r9
               	shlq	%r9
               	addq	%r9, %r8
               	shlq	%rdx
               	addq	%r8, %rdx
               	leaq	(%rdi,%rdi,4), %r8
               	leaq	(%r8,%r8,2), %r8
               	addq	%r8, %rdx
               	imulq	$0x7, %rdi, %r8
               	shlq	$0x2, %r8
               	addq	%r8, %rdx
               	movq	%rsi, %r8
               	shlq	%r8
               	leaq	(%r8,%r8,4), %r8
               	addq	%r8, %rdx
               	imulq	$0x6, %rax, %rax
               	addq	%rdx, %rax
               	leaq	(%rsi,%rsi,4), %rdx
               	imulq	$0x7, %rdx, %rdx
               	addq	%rdx, %rax
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	leaq	(%rdi,%rsi), %rcx
               	leaq	(%rcx,%rcx,8), %rcx
               	addq	%rcx, %rax
               	movq	%rdi, %rcx
               	subq	%rsi, %rcx
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	imulq	%rdi, %rsi
               	imulq	$0xb, %rsi, %rcx
               	addq	%rcx, %rax
               	leaq	0xb(%rdi), %rcx
               	imulq	$0xc, %rcx, %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	retq

<main>:
               	subq	$0x18, %rsp
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	xorl	%eax, %eax
               	shlq	%rax
               	incq	%rax
               	addq	$0x18, %rsp
               	retq
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	callq	<addr>
               	movsd	%xmm0, 0x8(%rsp)
               	movl	$0x3, %edi
               	movl	$0x5, %esi
               	callq	<addr>
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movsd	0x8(%rsp), %xmm14
               	ucomisd	%xmm0, %xmm14
               	jp	<addr>
               	je	<addr>
               	xorl	%eax, %eax
               	shlq	%rax
               	addq	$0x2, %rax
               	addq	$0x18, %rsp
               	retq
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	callq	<addr>
               	movsd	%xmm0, 0x8(%rsp)
               	movq	$-0x4, %rdi
               	movl	$0x9, %esi
               	callq	<addr>
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movsd	0x8(%rsp), %xmm14
               	ucomisd	%xmm0, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	callq	<addr>
               	movsd	%xmm0, 0x8(%rsp)
               	movl	$0x3e8, %edi            # imm = 0x3E8
               	movq	$-0x4d, %rsi
               	callq	<addr>
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movsd	0x8(%rsp), %xmm14
               	ucomisd	%xmm0, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	xorps	%xmm0, %xmm0
               	movsd	<rip>, %xmm1
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	xorps	%xmm0, %xmm0
               	movsd	<rip>, %xmm1
               	callq	<addr>
               	movsd	%xmm0, 0x8(%rsp)
               	xorl	%edi, %edi
               	movl	$0x1, %esi
               	callq	<addr>
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movsd	0x8(%rsp), %xmm14
               	ucomisd	%xmm0, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
