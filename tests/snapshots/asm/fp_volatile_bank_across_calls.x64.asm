
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
               	movq	%rdi, %r10
               	subq	%rsi, %r10
               	movq	%rax, %rdx
               	imulq	%r10, %rdx
               	addq	%rdx, %rcx
               	leaq	(%rdi,%rdi,2), %r8
               	movq	%r8, %rdx
               	imulq	%rsi, %rdx
               	leaq	(%rdx,%rdx,4), %rdx
               	leaq	(%rcx,%rdx), %r9
               	leaq	(%rdi,%rsi), %rdx
               	movq	%rsi, %rcx
               	subq	%rdi, %rcx
               	movq	%rdx, %r11
               	imulq	%rcx, %r11
               	addq	%r9, %r11
               	imulq	$0x7, %rdi, %r9
               	movq	%r9, %rbx
               	imulq	%rsi, %rbx
               	leaq	(%rbx,%rbx,8), %rbx
               	leaq	(%r11,%rbx), %r12
               	leaq	0x1(%rsi), %r11
               	leaq	0x2(%rsi), %rbx
               	imulq	%rbx, %r11
               	leaq	0x3(%rsi), %rbx
               	leaq	0x4(%rsi), %r13
               	imulq	%r13, %rbx
               	addq	%r11, %rbx
               	leaq	0x5(%rdi), %r11
               	leaq	0x6(%rdi), %r13
               	imulq	%r13, %r11
               	addq	%r11, %rbx
               	leaq	0x7(%rdi), %r11
               	leaq	0x8(%rdi), %r13
               	imulq	%r13, %r11
               	addq	%rbx, %r11
               	imulq	%rax, %rcx
               	addq	%r11, %rcx
               	leaq	(%rsi,%rsi,2), %r11
               	movq	%r11, %rbx
               	imulq	%rdi, %rbx
               	leaq	(%rbx,%rbx,4), %rbx
               	addq	%rbx, %rcx
               	imulq	%r10, %rdx
               	addq	%rcx, %rdx
               	imulq	$0x7, %rsi, %rcx
               	movq	%rcx, %r10
               	imulq	%rdi, %r10
               	leaq	(%r10,%r10,8), %r10
               	addq	%r10, %rdx
               	addq	%r12, %rdx
               	movq	%rdi, %r10
               	shlq	%r10
               	addq	%r10, %rdx
               	shlq	%r8
               	addq	%r8, %rdx
               	leaq	(%rdi,%rdi,4), %r8
               	leaq	(%r8,%r8,2), %r8
               	addq	%r8, %rdx
               	shlq	$0x2, %r9
               	addq	%r9, %rdx
               	movq	%rsi, %r8
               	shlq	%r8
               	leaq	(%r8,%r8,4), %r8
               	addq	%r8, %rdx
               	imulq	$0x6, %r11, %r8
               	addq	%r8, %rdx
               	leaq	(%rsi,%rsi,4), %r8
               	imulq	$0x7, %r8, %r8
               	addq	%r8, %rdx
               	shlq	$0x3, %rcx
               	addq	%rdx, %rcx
               	leaq	(%rdi,%rsi), %rdx
               	leaq	(%rdx,%rdx,8), %rdx
               	addq	%rdx, %rcx
               	movq	%rdi, %rdx
               	subq	%rsi, %rdx
               	imulq	$0xa, %rdx, %rdx
               	addq	%rdx, %rcx
               	imulq	$0xb, %rax, %rax
               	addq	%rcx, %rax
               	leaq	0xb(%rdi), %rcx
               	imulq	$0xc, %rcx, %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
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
