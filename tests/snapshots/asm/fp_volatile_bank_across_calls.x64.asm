
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
               	subq	$0x28, %rsp
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
               	movsd	%xmm14, 0x18(%rsp)
               	vsubsd	%xmm0, %xmm1, %xmm14
               	movsd	%xmm14, 0x10(%rsp)
               	vmulsd	<rip>, %xmm0, %xmm14
               	movsd	%xmm14, 0x8(%rsp)
               	vmulsd	<rip>, %xmm1, %xmm1
               	vmulsd	%xmm6, %xmm5, %xmm0
               	vfmadd231sd	%xmm4, %xmm3, %xmm0 # xmm0 = (xmm3 * xmm4) + xmm0
               	vfmadd231sd	%xmm8, %xmm7, %xmm0 # xmm0 = (xmm7 * xmm8) + xmm0
               	vfmadd231sd	%xmm9, %xmm2, %xmm0 # xmm0 = (xmm2 * xmm9) + xmm0
               	vfmadd231sd	%xmm11, %xmm10, %xmm0 # xmm0 = (xmm10 * xmm11) + xmm0
               	vfmadd231sd	%xmm13, %xmm12, %xmm0 # xmm0 = (xmm12 * xmm13) + xmm0
               	movsd	0x18(%rsp), %xmm14
               	vfmadd231sd	0x10(%rsp), %xmm14, %xmm0 # xmm0 = (xmm14 * mem) + xmm0
               	vfmadd231sd	0x8(%rsp), %xmm1, %xmm0 # xmm0 = (xmm1 * mem) + xmm0
               	addq	$0x28, %rsp
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
               	addq	%rax, %rcx
               	leaq	0x5(%rsi), %rax
               	leaq	0x6(%rsi), %rdx
               	imulq	%rdx, %rax
               	addq	%rax, %rcx
               	leaq	0x7(%rsi), %rax
               	leaq	0x8(%rsi), %rdx
               	imulq	%rdx, %rax
               	addq	%rax, %rcx
               	movq	%rdi, %rax
               	imulq	%rsi, %rax
               	movq	%rdi, %r8
               	subq	%rsi, %r8
               	movq	%rax, %rdx
               	imulq	%r8, %rdx
               	addq	%rdx, %rcx
               	leaq	(%rdi,%rdi,2), %rdx
               	movq	%rdx, %r9
               	imulq	%rsi, %r9
               	leaq	(%r9,%r9,4), %r9
               	leaq	(%rcx,%r9), %rbx
               	leaq	(%rdi,%rsi), %rcx
               	movq	%rsi, %r9
               	subq	%rdi, %r9
               	movq	%rcx, %r12
               	imulq	%r9, %r12
               	addq	%rbx, %r12
               	imulq	$0x7, %rdi, %rbx
               	imulq	%rsi, %rbx
               	leaq	(%rbx,%rbx,8), %rbx
               	leaq	(%r12,%rbx), %r13
               	leaq	0x1(%rsi), %rbx
               	leaq	0x2(%rsi), %r12
               	imulq	%r12, %rbx
               	leaq	0x3(%rsi), %r12
               	leaq	0x4(%rsi), %r14
               	imulq	%r14, %r12
               	addq	%rbx, %r12
               	leaq	0x5(%rdi), %rbx
               	leaq	0x6(%rdi), %r14
               	imulq	%r14, %rbx
               	addq	%rbx, %r12
               	leaq	0x7(%rdi), %rbx
               	leaq	0x8(%rdi), %r14
               	imulq	%r14, %rbx
               	addq	%r12, %rbx
               	imulq	%r9, %rax
               	addq	%rbx, %rax
               	leaq	(%rsi,%rsi,2), %r9
               	movq	%r9, %rbx
               	imulq	%rdi, %rbx
               	leaq	(%rbx,%rbx,4), %rbx
               	addq	%rbx, %rax
               	imulq	%r8, %rcx
               	addq	%rax, %rcx
               	imulq	$0x7, %rsi, %rax
               	movq	%rax, %r8
               	imulq	%rdi, %r8
               	leaq	(%r8,%r8,8), %r8
               	addq	%r8, %rcx
               	addq	%r13, %rcx
               	movq	%rdi, %r8
               	shlq	%r8
               	addq	%r8, %rcx
               	shlq	%rdx
               	addq	%rdx, %rcx
               	leaq	(%rdi,%rdi,4), %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	addq	%rcx, %rdx
               	imulq	$0x7, %rdi, %rcx
               	shlq	$0x2, %rcx
               	addq	%rdx, %rcx
               	movq	%rsi, %rdx
               	shlq	%rdx
               	leaq	(%rdx,%rdx,4), %rdx
               	addq	%rdx, %rcx
               	imulq	$0x6, %r9, %rdx
               	addq	%rdx, %rcx
               	leaq	(%rsi,%rsi,4), %rdx
               	imulq	$0x7, %rdx, %rdx
               	addq	%rdx, %rcx
               	shlq	$0x3, %rax
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
