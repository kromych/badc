
avx2_gathers_and_masked_transfers_follow_the_sdm.x64:	file format elf64-x86-64

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

<__badc_round>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r9
               	movq	%rcx, %rbx
               	movslq	%edx, %rdx
               	movslq	%esi, %rsi
               	movl	$0x1, %ecx
               	cmpl	$0x7f, %edx
               	jne	<addr>
               	movl	$0x8, %eax
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	shlxq	%rax, %rcx, %r12
               	movq	%r12, %rcx
               	xorq	$-0x1, %rcx
               	andq	%r9, %rcx
               	shrxq	%rsi, %rcx, %r8
               	subq	%rdx, %r8
               	movq	%r9, %rax
               	andq	%r12, %rax
               	testq	%rax, %rax
               	setne	%r13b
               	movzbq	%r13b, %r13
               	testb	$0x4, %bl
               	je	<addr>
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %eax
               	shrq	$0xd, %rax
               	movq	%rax, %rdi
               	andq	$0x3, %rdi
               	cmpl	%esi, %r8d
               	jl	<addr>
               	movq	%r9, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	testl	%r8d, %r8d
               	jge	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	%r9, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	shlxq	%rsi, %rdx, %r8
               	xorl	%eax, %eax
               	testl	%edi, %edi
               	jne	<addr>
               	decq	%rdx
               	movslq	%edx, %rdx
               	shlxq	%rsi, %rdx, %rdx
               	cmpq	%rdx, %rcx
               	seta	%dl
               	movzbq	%dl, %rdx
               	cmpl	$0x1, %edi
               	je	<addr>
               	cmpl	$0x2, %edi
               	jne	<addr>
               	cmpl	$0x1, %edi
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpl	%ecx, %r13d
               	sete	%dl
               	movzbq	%dl, %rdx
               	testb	$0x8, %bl
               	jne	<addr>
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x10(%rbp)
               	movsd	-0x10(%rbp), %xmm0
               	movabsq	$0x3c30000000000000, %rcx # imm = 0x3C30000000000000
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x10(%rbp)
               	testq	%rdx, %rdx
               	je	<addr>
               	addq	%r8, %rax
               	movq	%r9, %rcx
               	andq	%r12, %rcx
               	orq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	xorl	%edx, %edx
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rsi, %rdx
               	subq	%r8, %rdx
               	movslq	%edx, %rdx
               	shlxq	%rdx, %rax, %r8
               	leaq	-0x1(%r8), %rsi
               	andq	%rcx, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	%r9, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	%rcx, %rax
               	subq	%rsi, %rax
               	testl	%edi, %edi
               	jne	<addr>
               	movq	%r8, %rdx
               	shrq	%rdx
               	cmpq	%rdx, %rsi
               	movl	$0x1, %edx
               	ja	<addr>
               	movq	%r8, %rdx
               	shrq	%rdx
               	cmpq	%rdx, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorl	%edx, %edx
               	testq	%rsi, %rsi
               	je	<addr>
               	andq	%r8, %rcx
               	testq	%rcx, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	movq	%rbx, %rdi
               	andq	$0x3, %rdi
               	jmp	<addr>
               	movl	$0xb, %eax
               	jmp	<addr>

<__badc_round_f>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, %rcx
               	ucomiss	%xmm0, %xmm0
               	jp	<addr>
               	je	<addr>
               	addss	%xmm0, %xmm0
               	leave
               	retq
               	movl	$0x0, -0x18(%rbp)
               	movss	%xmm0, -0x18(%rbp)
               	movl	-0x18(%rbp), %eax
               	movl	%eax, -0x10(%rbp)
               	movl	%eax, %edi
               	movl	$0x17, %esi
               	movl	$0x7f, %edx
               	callq	<addr>
               	movl	%eax, -0x10(%rbp)
               	movss	-0x10(%rbp), %xmm0
               	leave
               	retq

<__badc_round_d>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %rcx
               	ucomisd	%xmm0, %xmm0
               	jp	<addr>
               	je	<addr>
               	addsd	%xmm0, %xmm0
               	leave
               	retq
               	movq	$0x0, -0x10(%rbp)
               	movsd	%xmm0, -0x10(%rbp)
               	movq	-0x10(%rbp), %rdi
               	movq	%rdi, -0x10(%rbp)
               	movl	$0x34, %esi
               	movl	$0x3ff, %edx            # imm = 0x3FF
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	movsd	-0x10(%rbp), %xmm0
               	leave
               	retq

<_mm256_loadu_si256>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	leaq	(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movq	-0x20(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_storeu_si256>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leave
               	retq

<_mm256_castsi256_si128>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	0x20(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	(%rsp), %rcx
               	movq	%rcx, 0x20(%rsp)
               	movq	0x8(%rsp), %rcx
               	movq	%rcx, 0x28(%rsp)
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq

<_mm256_testz_si256>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	(%rsp), %rax
               	movq	0x20(%rsp), %rcx
               	andq	%rcx, %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x28(%rsp), %rdx
               	andq	%rdx, %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x30(%rsp), %rsi
               	andq	%rsi, %rdx
               	movq	0x18(%rsp), %rsi
               	movq	0x38(%rsp), %rdi
               	andq	%rdi, %rsi
               	orq	%rcx, %rax
               	orq	%rdx, %rax
               	orq	%rsi, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq

<_mm256_permutevar8x32_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movl	0x20(%rsp), %eax
               	movl	0x24(%rsp), %ecx
               	movl	0x28(%rsp), %edx
               	movl	0x2c(%rsp), %esi
               	movl	0x30(%rsp), %edi
               	movl	0x34(%rsp), %r8d
               	movl	0x38(%rsp), %r9d
               	movl	0x3c(%rsp), %ebx
               	leaq	0x40(%rsp), %r12
               	andq	$0x7, %rax
               	movl	(%r12,%rax,4), %eax
               	movl	%eax, 0x60(%rsp)
               	leaq	0x40(%rsp), %rax
               	andq	$0x7, %rcx
               	movl	(%rax,%rcx,4), %eax
               	movl	%eax, 0x64(%rsp)
               	leaq	0x40(%rsp), %rax
               	andq	$0x7, %rdx
               	movl	(%rax,%rdx,4), %eax
               	movl	%eax, 0x68(%rsp)
               	leaq	0x40(%rsp), %rax
               	andq	$0x7, %rsi
               	movl	(%rax,%rsi,4), %eax
               	movl	%eax, 0x6c(%rsp)
               	leaq	0x40(%rsp), %rax
               	andq	$0x7, %rdi
               	movl	(%rax,%rdi,4), %ecx
               	movl	%ecx, 0x70(%rsp)
               	andq	$0x7, %r8
               	movl	(%rax,%r8,4), %ecx
               	movl	%ecx, 0x74(%rsp)
               	andq	$0x7, %r9
               	movl	(%rax,%r9,4), %eax
               	movl	%eax, 0x78(%rsp)
               	leaq	0x60(%rsp), %rcx
               	leaq	0x40(%rsp), %rax
               	andq	$0x7, %rbx
               	movl	(%rax,%rbx,4), %eax
               	movl	%eax, 0x7c(%rsp)
               	movq	-0x10(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<_mm256_permute4x64_epi64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	-0x20(%rbp), %rax
               	leaq	0x20(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movq	(%rsp), %rcx
               	movq	%rcx, 0x20(%rsp)
               	movq	0x18(%rsp), %rcx
               	movq	%rcx, 0x28(%rsp)
               	movq	0x8(%rsp), %rcx
               	movq	%rcx, 0x30(%rsp)
               	movq	0x10(%rsp), %rcx
               	leaq	0x20(%rsp), %rdx
               	movq	%rcx, 0x38(%rsp)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<__badc_lo_si>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	0x20(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	(%rsp), %rcx
               	movq	%rcx, 0x20(%rsp)
               	movq	0x8(%rsp), %rcx
               	movq	%rcx, 0x28(%rsp)
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq

<__badc_hi_si>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	0x20(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rsp), %rcx
               	movq	%rcx, 0x20(%rsp)
               	movq	0x18(%rsp), %rcx
               	movq	%rcx, 0x28(%rsp)
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq

<__badc_join_si>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movups	%xmm0, 0x20(%rsp)
               	movups	%xmm1, 0x30(%rsp)
               	movq	-0x30(%rbp), %rax
               	leaq	(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movq	0x20(%rsp), %rcx
               	movq	%rcx, (%rsp)
               	movq	0x28(%rsp), %rcx
               	movq	%rcx, 0x8(%rsp)
               	movq	0x30(%rsp), %rcx
               	movq	%rcx, 0x10(%rsp)
               	movq	0x38(%rsp), %rcx
               	movq	%rcx, 0x18(%rsp)
               	leaq	(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_set_epi16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x60(%rbp)
               	movswq	%si, %rsi
               	movswq	%r9w, %r9
               	movswq	%r8w, %r8
               	movswq	%cx, %rcx
               	movswq	%dx, %rdx
               	movq	-0x60(%rbp), %rax
               	leaq	(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movswq	0x60(%rbp), %rdi
               	movw	%di, (%rsp)
               	movswq	0x58(%rbp), %rdi
               	movw	%di, 0x2(%rsp)
               	movswq	0x50(%rbp), %rdi
               	movw	%di, 0x4(%rsp)
               	movswq	0x48(%rbp), %rdi
               	movw	%di, 0x6(%rsp)
               	movswq	0x40(%rbp), %rdi
               	movw	%di, 0x8(%rsp)
               	movswq	0x38(%rbp), %rdi
               	movw	%di, 0xa(%rsp)
               	movswq	0x30(%rbp), %rdi
               	movw	%di, 0xc(%rsp)
               	movswq	0x28(%rbp), %rdi
               	movw	%di, 0xe(%rsp)
               	movswq	0x20(%rbp), %rdi
               	movw	%di, 0x10(%rsp)
               	movswq	0x18(%rbp), %rdi
               	movw	%di, 0x12(%rsp)
               	movswq	0x10(%rbp), %rdi
               	movw	%di, 0x14(%rsp)
               	movw	%r9w, 0x16(%rsp)
               	movw	%r8w, 0x18(%rsp)
               	leaq	(%rsp), %rdi
               	movw	%cx, 0x1a(%rsp)
               	movw	%dx, 0x1c(%rsp)
               	movw	%si, 0x1e(%rsp)
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_setr_epi16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x60(%rbp)
               	movswq	%si, %rsi
               	movswq	%r9w, %r9
               	movswq	%r8w, %r8
               	movswq	%cx, %rcx
               	movswq	%dx, %rdx
               	movq	-0x60(%rbp), %rax
               	leaq	(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movw	%si, (%rsp)
               	movw	%dx, 0x2(%rsp)
               	movw	%cx, 0x4(%rsp)
               	movw	%r8w, 0x6(%rsp)
               	movw	%r9w, 0x8(%rsp)
               	movswq	0x10(%rbp), %rcx
               	movw	%cx, 0xa(%rsp)
               	movswq	0x18(%rbp), %rcx
               	movw	%cx, 0xc(%rsp)
               	movswq	0x20(%rbp), %rcx
               	movw	%cx, 0xe(%rsp)
               	movswq	0x28(%rbp), %rcx
               	movw	%cx, 0x10(%rsp)
               	movswq	0x30(%rbp), %rcx
               	movw	%cx, 0x12(%rsp)
               	movswq	0x38(%rbp), %rcx
               	movw	%cx, 0x14(%rsp)
               	movswq	0x40(%rbp), %rcx
               	movw	%cx, 0x16(%rsp)
               	movswq	0x48(%rbp), %rcx
               	movw	%cx, 0x18(%rsp)
               	movswq	0x50(%rbp), %rcx
               	movw	%cx, 0x1a(%rsp)
               	movswq	0x58(%rbp), %rcx
               	movw	%cx, 0x1c(%rsp)
               	movswq	0x60(%rbp), %rcx
               	movw	%cx, 0x1e(%rsp)
               	leaq	(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_setr_epi64x>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	-0x50(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	%rsi, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%r8, 0x18(%rax)
               	leave
               	retq

<_mm256_setr_m128i>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%rbx
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movups	%xmm0, 0x20(%rsp)
               	movups	%xmm1, 0x30(%rsp)
               	movq	-0x30(%rbp), %rbx
               	leaq	(%rsp), %rdi
               	leaq	0x20(%rsp), %r9
               	leaq	0x30(%rsp), %rax
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_extract_epi16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %rax
               	andq	$0xf, %rdi
               	movzwq	(%rax,%rdi,2), %rax
               	leave
               	retq

<_mm256_insert_epi16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movw	%si, 0x3a(%rsp)
               	movq	-0x30(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_cvtsi256_si32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movl	(%rsp), %eax
               	leave
               	retq

<_mm256_stream_si256>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leave
               	retq

<_mm256_stream_load_si256>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	-0x20(%rbp), %rbx
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	leaq	(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_lddqu_si256>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	-0x20(%rbp), %rbx
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	leaq	(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_loadu2_m128i>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%rbx
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movq	-0x30(%rbp), %rbx
               	leaq	(%rsp), %rdi
               	leaq	0x20(%rsp), %r9
               	movdqu	(%rdx), %xmm15
               	movdqu	%xmm15, (%r9)
               	leaq	0x30(%rsp), %rax
               	movdqu	(%rsi), %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_storeu2_m128i>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x20(%rsp), %rcx
               	leaq	0x30(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%r12)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x20(%rsp), %rcx
               	leaq	0x30(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rbx)
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq

<_mm256_testc_si256>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	(%rsp), %rax
               	xorq	$-0x1, %rax
               	movq	0x8(%rsp), %rcx
               	xorq	$-0x1, %rcx
               	movq	0x10(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movq	0x18(%rsp), %rsi
               	xorq	$-0x1, %rsi
               	movq	0x20(%rsp), %rdi
               	andq	%rdi, %rax
               	movq	0x28(%rsp), %rdi
               	andq	%rdi, %rcx
               	movq	0x30(%rsp), %rdi
               	andq	%rdi, %rdx
               	movq	0x38(%rsp), %rdi
               	andq	%rdi, %rsi
               	orq	%rcx, %rax
               	orq	%rdx, %rax
               	orq	%rsi, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq

<_mm256_testnzc_si256>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	xorl	%ecx, %ecx
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	testl	%eax, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %rax
               	leave
               	retq

<_mm256_maskload_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movl	%ecx, -0x8(%rbp)
               	movl	(%rdx,%rax,4), %edi
               	testl	%edi, %edi
               	jge	<addr>
               	leaq	-0x8(%rbp), %rdi
               	movq	%rax, %r8
               	shlq	$0x2, %r8
               	addq	%rsi, %r8
               	movl	(%r8), %r10d
               	movl	%r10d, (%rdi)
               	leaq	0x40(%rsp), %rdi
               	movl	-0x8(%rbp), %r8d
               	movl	%r8d, (%rdi,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	-0x30(%rbp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_maskstore_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x20(%rsp), %rax
               	leaq	0x60(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	xorl	%eax, %eax
               	movl	(%rdx,%rax,4), %ecx
               	testl	%ecx, %ecx
               	jge	<addr>
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rsi,%rcx), %r8
               	movl	(%r8), %r8d
               	movl	%r8d, -0x8(%rbp)
               	addq	%rdi, %rcx
               	leaq	-0x8(%rbp), %r8
               	movl	(%r8), %r10d
               	movl	%r10d, (%rcx)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leave
               	retq

<_mm256_maskload_epi64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movq	%rcx, -0x8(%rbp)
               	movq	(%rdx,%rax,8), %rdi
               	testq	%rdi, %rdi
               	jge	<addr>
               	leaq	-0x8(%rbp), %rdi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	addq	%rsi, %r8
               	movq	(%r8), %r10
               	movq	%r10, (%rdi)
               	leaq	0x40(%rsp), %rdi
               	movq	-0x8(%rbp), %r8
               	movq	%r8, (%rdi,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	-0x30(%rbp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_maskstore_epi64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x20(%rsp), %rax
               	leaq	0x60(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	xorl	%eax, %eax
               	movq	(%rdx,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rsi,%rcx), %r8
               	movq	(%r8), %r8
               	movq	%r8, -0x8(%rbp)
               	addq	%rdi, %rcx
               	leaq	-0x8(%rbp), %r8
               	movq	(%r8), %r10
               	movq	%r10, (%rcx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leave
               	retq

<_mm256_mask_i32gather_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%rbx
               	subq	$0xe0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x40(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x60(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x68(%rbp), %r10
               	movq	%r10, 0x58(%rsp)
               	movslq	%edx, %rdx
               	leaq	(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x40(%rsp), %rax
               	leaq	0x80(%rsp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0xa0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x20(%rsp), %rax
               	leaq	0xc0(%rsp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	xorl	%eax, %eax
               	movl	(%rcx,%rax,4), %r9d
               	movl	%r9d, -0x8(%rbp)
               	movl	(%rdi,%rax,4), %r9d
               	testl	%r9d, %r9d
               	jge	<addr>
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r8,%rax,4), %rbx
               	imulq	%rdx, %rbx
               	addq	%rsi, %rbx
               	movl	(%rbx), %r10d
               	movl	%r10d, (%r9)
               	leaq	0xa0(%rsp), %r9
               	movl	-0x8(%rbp), %ebx
               	movl	%ebx, (%r9,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	-0x40(%rbp), %rax
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_i32gather_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	0x20(%rsp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movups	%xmm14, 0x10(%r9)
               	movl	$0xffffffff, 0x20(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x24(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x28(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x2c(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x30(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x34(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x38(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x3c(%rsp) # imm = 0xFFFFFFFF
               	movq	-0x30(%rbp), %rbx
               	leaq	0x60(%rsp), %rdi
               	leaq	0x40(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	(%rsp), %rcx
               	subq	$0x60, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0x60(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_mask_i32gather_epi64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%rbx
               	subq	$0xc0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movups	%xmm0, 0xa0(%rsp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movslq	%edx, %rdx
               	leaq	(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x20(%rsp), %rax
               	leaq	0x60(%rsp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x80(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0xa0(%rsp), %rax
               	leaq	0xb0(%rsp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	xorl	%eax, %eax
               	movq	(%rcx,%rax,8), %r9
               	movq	%r9, -0x8(%rbp)
               	movq	(%rdi,%rax,8), %r9
               	testq	%r9, %r9
               	jge	<addr>
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r8,%rax,4), %rbx
               	imulq	%rdx, %rbx
               	addq	%rsi, %rbx
               	movq	(%rbx), %r10
               	movq	%r10, (%r9)
               	leaq	0x80(%rsp), %r9
               	movq	-0x8(%rbp), %rbx
               	movq	%rbx, (%r9,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	-0x50(%rbp), %rax
               	leaq	0x80(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_i32gather_epi64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x40(%rbp)
               	movups	%xmm0, 0x60(%rsp)
               	leaq	(%rsp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movups	%xmm14, 0x10(%r9)
               	movq	$-0x1, (%rsp)
               	movq	$-0x1, 0x8(%rsp)
               	movq	$-0x1, 0x10(%rsp)
               	movq	$-0x1, 0x18(%rsp)
               	movq	-0x40(%rbp), %rbx
               	leaq	0x40(%rsp), %rdi
               	leaq	0x20(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x60(%rsp), %rcx
               	subq	$0x40, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rcx, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x40(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_mask_i64gather_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0xa0, %rsp
               	andq	$-0x20, %rsp
               	movups	%xmm0, 0x40(%rsp)
               	movups	%xmm1, 0x50(%rsp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movslq	%esi, %rsi
               	leaq	0x40(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x50(%rsp), %rax
               	leaq	0x70(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x80(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	xorl	%eax, %eax
               	movl	(%rcx,%rax,4), %r9d
               	movl	%r9d, -0x8(%rbp)
               	movl	(%rdx,%rax,4), %r9d
               	testl	%r9d, %r9d
               	jge	<addr>
               	leaq	-0x8(%rbp), %r9
               	movq	(%r8,%rax,8), %rbx
               	imulq	%rsi, %rbx
               	addq	%rdi, %rbx
               	movl	(%rbx), %r10d
               	movl	%r10d, (%r9)
               	leaq	0x80(%rsp), %r9
               	movl	-0x8(%rbp), %ebx
               	movl	%ebx, (%r9,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x80(%rsp), %rax
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_i64gather_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	0x20(%rsp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movl	$0xffffffff, 0x20(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x24(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x28(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x2c(%rsp) # imm = 0xFFFFFFFF
               	leaq	0x30(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	(%rsp), %rcx
               	subq	$0x20, %rsp
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x40(%rsp)
               	leaq	0x40(%rsp), %rax
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq

<_mm256_mask_i64gather_epi64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%rbx
               	subq	$0xe0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x40(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x60(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x68(%rbp), %r10
               	movq	%r10, 0x58(%rsp)
               	movslq	%edx, %rdx
               	leaq	(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x40(%rsp), %rax
               	leaq	0x80(%rsp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0xa0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x20(%rsp), %rax
               	leaq	0xc0(%rsp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	xorl	%eax, %eax
               	movq	(%rcx,%rax,8), %r9
               	movq	%r9, -0x8(%rbp)
               	movq	(%rdi,%rax,8), %r9
               	testq	%r9, %r9
               	jge	<addr>
               	leaq	-0x8(%rbp), %r9
               	movq	(%r8,%rax,8), %rbx
               	imulq	%rdx, %rbx
               	addq	%rsi, %rbx
               	movq	(%rbx), %r10
               	movq	%r10, (%r9)
               	leaq	0xa0(%rsp), %r9
               	movq	-0x8(%rbp), %rbx
               	movq	%rbx, (%r9,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	-0x40(%rbp), %rax
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_i64gather_epi64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	0x20(%rsp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movups	%xmm14, 0x10(%r9)
               	movq	$-0x1, 0x20(%rsp)
               	movq	$-0x1, 0x28(%rsp)
               	movq	$-0x1, 0x30(%rsp)
               	movq	$-0x1, 0x38(%rsp)
               	movq	-0x30(%rbp), %rbx
               	leaq	0x60(%rsp), %rdi
               	leaq	0x40(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	(%rsp), %rcx
               	subq	$0x60, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0x60(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_mask_i32gather_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%rbx
               	subq	$0xe0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x40(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x60(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x68(%rbp), %r10
               	movq	%r10, 0x58(%rsp)
               	movslq	%edx, %rdx
               	leaq	(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x40(%rsp), %rax
               	leaq	0x80(%rsp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0xa0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x20(%rsp), %rax
               	leaq	0xc0(%rsp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	xorl	%eax, %eax
               	movl	(%rcx,%rax,4), %r9d
               	movl	%r9d, -0x8(%rbp)
               	movl	(%rdi,%rax,4), %r9d
               	testl	%r9d, %r9d
               	jge	<addr>
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r8,%rax,4), %rbx
               	imulq	%rdx, %rbx
               	addq	%rsi, %rbx
               	movl	(%rbx), %r10d
               	movl	%r10d, (%r9)
               	leaq	0xa0(%rsp), %r9
               	movl	-0x8(%rbp), %ebx
               	movl	%ebx, (%r9,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	-0x40(%rbp), %rax
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_i32gather_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	0x20(%rsp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movups	%xmm14, 0x10(%r9)
               	movl	$0xffffffff, 0x20(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x24(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x28(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x2c(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x30(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x34(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x38(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x3c(%rsp) # imm = 0xFFFFFFFF
               	movq	-0x30(%rbp), %rbx
               	leaq	0x60(%rsp), %rdi
               	leaq	0x40(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	(%rsp), %rcx
               	subq	$0x60, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0x60(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_mask_i32gather_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%rbx
               	subq	$0xc0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movups	%xmm0, 0xa0(%rsp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movslq	%edx, %rdx
               	leaq	(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x20(%rsp), %rax
               	leaq	0x60(%rsp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x80(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0xa0(%rsp), %rax
               	leaq	0xb0(%rsp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	xorl	%eax, %eax
               	movq	(%rcx,%rax,8), %r9
               	movq	%r9, -0x8(%rbp)
               	movq	(%rdi,%rax,8), %r9
               	testq	%r9, %r9
               	jge	<addr>
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r8,%rax,4), %rbx
               	imulq	%rdx, %rbx
               	addq	%rsi, %rbx
               	movq	(%rbx), %r10
               	movq	%r10, (%r9)
               	leaq	0x80(%rsp), %r9
               	movq	-0x8(%rbp), %rbx
               	movq	%rbx, (%r9,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	-0x50(%rbp), %rax
               	leaq	0x80(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_i32gather_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x40(%rbp)
               	movups	%xmm0, 0x60(%rsp)
               	leaq	(%rsp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movups	%xmm14, 0x10(%r9)
               	movq	$-0x1, (%rsp)
               	movq	$-0x1, 0x8(%rsp)
               	movq	$-0x1, 0x10(%rsp)
               	movq	$-0x1, 0x18(%rsp)
               	movq	-0x40(%rbp), %rbx
               	leaq	0x40(%rsp), %rdi
               	leaq	0x20(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x60(%rsp), %rcx
               	subq	$0x40, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rcx, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x40(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_mask_i64gather_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0xa0, %rsp
               	andq	$-0x20, %rsp
               	movups	%xmm0, 0x40(%rsp)
               	movups	%xmm1, 0x50(%rsp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movslq	%esi, %rsi
               	leaq	0x40(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x50(%rsp), %rax
               	leaq	0x70(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x80(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	xorl	%eax, %eax
               	movl	(%rcx,%rax,4), %r9d
               	movl	%r9d, -0x8(%rbp)
               	movl	(%rdx,%rax,4), %r9d
               	testl	%r9d, %r9d
               	jge	<addr>
               	leaq	-0x8(%rbp), %r9
               	movq	(%r8,%rax,8), %rbx
               	imulq	%rsi, %rbx
               	addq	%rdi, %rbx
               	movl	(%rbx), %r10d
               	movl	%r10d, (%r9)
               	leaq	0x80(%rsp), %r9
               	movl	-0x8(%rbp), %ebx
               	movl	%ebx, (%r9,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x80(%rsp), %rax
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_i64gather_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	0x20(%rsp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movl	$0xffffffff, 0x20(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x24(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x28(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x2c(%rsp) # imm = 0xFFFFFFFF
               	leaq	0x30(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	(%rsp), %rcx
               	subq	$0x20, %rsp
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x40(%rsp)
               	leaq	0x40(%rsp), %rax
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq

<_mm256_mask_i64gather_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%rbx
               	subq	$0xe0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x40(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x60(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x68(%rbp), %r10
               	movq	%r10, 0x58(%rsp)
               	movslq	%edx, %rdx
               	leaq	(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x40(%rsp), %rax
               	leaq	0x80(%rsp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0xa0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x20(%rsp), %rax
               	leaq	0xc0(%rsp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	xorl	%eax, %eax
               	movq	(%rcx,%rax,8), %r9
               	movq	%r9, -0x8(%rbp)
               	movq	(%rdi,%rax,8), %r9
               	testq	%r9, %r9
               	jge	<addr>
               	leaq	-0x8(%rbp), %r9
               	movq	(%r8,%rax,8), %rbx
               	imulq	%rdx, %rbx
               	addq	%rsi, %rbx
               	movq	(%rbx), %r10
               	movq	%r10, (%r9)
               	leaq	0xa0(%rsp), %r9
               	movq	-0x8(%rbp), %rbx
               	movq	%rbx, (%r9,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	-0x40(%rbp), %rax
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_i64gather_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	0x20(%rsp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movups	%xmm14, 0x10(%r9)
               	movq	$-0x1, 0x20(%rsp)
               	movq	$-0x1, 0x28(%rsp)
               	movq	$-0x1, 0x30(%rsp)
               	movq	$-0x1, 0x38(%rsp)
               	movq	-0x30(%rbp), %rbx
               	leaq	0x60(%rsp), %rdi
               	leaq	0x40(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	(%rsp), %rcx
               	subq	$0x60, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0x60(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<__badc_lo_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movl	(%rsp), %eax
               	movl	0x4(%rsp), %ecx
               	movl	0x8(%rsp), %edx
               	movl	0xc(%rsp), %esi
               	leaq	0x20(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	%eax, 0x20(%rsp)
               	movl	%ecx, 0x24(%rsp)
               	movl	%edx, 0x28(%rsp)
               	leaq	0x20(%rsp), %rax
               	movl	%esi, 0x2c(%rsp)
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq

<__badc_hi_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movl	0x10(%rsp), %eax
               	movl	0x14(%rsp), %ecx
               	movl	0x18(%rsp), %edx
               	movl	0x1c(%rsp), %esi
               	leaq	0x20(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movl	%eax, 0x20(%rsp)
               	movl	%ecx, 0x24(%rsp)
               	movl	%edx, 0x28(%rsp)
               	leaq	0x20(%rsp), %rax
               	movl	%esi, 0x2c(%rsp)
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq

<__badc_join_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, -0x30(%rbp)
               	movups	%xmm0, -0x50(%rbp)
               	movups	%xmm1, -0x40(%rbp)
               	movl	-0x50(%rbp), %ecx
               	movl	-0x4c(%rbp), %edx
               	movl	-0x48(%rbp), %esi
               	movl	-0x44(%rbp), %edi
               	movl	-0x40(%rbp), %r8d
               	movl	-0x3c(%rbp), %r9d
               	movl	-0x38(%rbp), %ebx
               	movl	-0x34(%rbp), %r12d
               	movq	-0x30(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movl	%ecx, (%rax)
               	movl	%edx, 0x4(%rax)
               	movl	%esi, 0x8(%rax)
               	movl	%edi, 0xc(%rax)
               	movl	%r8d, 0x10(%rax)
               	movl	%r9d, 0x14(%rax)
               	movl	%ebx, 0x18(%rax)
               	movl	%r12d, 0x1c(%rax)
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<__badc_lo_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	(%rsp), %rcx
               	movq	0x8(%rsp), %rdx
               	leaq	0x20(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rcx, 0x20(%rsp)
               	movq	%rdx, 0x28(%rsp)
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq

<__badc_hi_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x10(%rsp), %rcx
               	movq	0x18(%rsp), %rdx
               	leaq	0x20(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rcx, 0x20(%rsp)
               	movq	%rdx, 0x28(%rsp)
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq

<__badc_join_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movups	%xmm0, -0x50(%rbp)
               	movups	%xmm1, -0x40(%rbp)
               	movq	-0x50(%rbp), %rcx
               	movq	-0x48(%rbp), %rdx
               	movq	-0x40(%rbp), %rsi
               	movq	-0x38(%rbp), %rdi
               	movq	-0x30(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	leave
               	retq

<_mm256_storeu_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leave
               	retq

<_mm256_storeu_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leave
               	retq

<_mm256_castps_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	-0x10(%rbp), %rax
               	leaq	(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_castsi256_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	-0x10(%rbp), %rax
               	leaq	(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_castsi256_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	-0x10(%rbp), %rax
               	leaq	(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_castps256_ps128>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x20(%rsp), %rax
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq

<_mm256_castpd256_pd128>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x20(%rsp), %rax
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq

<_mm256_maskload_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movl	%ecx, -0x8(%rbp)
               	movl	(%rdx,%rax,4), %edi
               	testl	%edi, %edi
               	jge	<addr>
               	leaq	-0x8(%rbp), %rdi
               	movq	%rax, %r8
               	shlq	$0x2, %r8
               	addq	%rsi, %r8
               	movl	(%r8), %r10d
               	movl	%r10d, (%rdi)
               	leaq	0x40(%rsp), %rdi
               	movl	-0x8(%rbp), %r8d
               	movl	%r8d, (%rdi,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	-0x30(%rbp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_maskstore_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x20(%rsp), %rax
               	leaq	0x60(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	xorl	%eax, %eax
               	movl	(%rdx,%rax,4), %ecx
               	testl	%ecx, %ecx
               	jge	<addr>
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rsi,%rcx), %r8
               	movl	(%r8), %r8d
               	movl	%r8d, -0x8(%rbp)
               	addq	%rdi, %rcx
               	leaq	-0x8(%rbp), %r8
               	movl	(%r8), %r10d
               	movl	%r10d, (%rcx)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leave
               	retq

<_mm256_maskload_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movq	%rcx, -0x8(%rbp)
               	movq	(%rdx,%rax,8), %rdi
               	testq	%rdi, %rdi
               	jge	<addr>
               	leaq	-0x8(%rbp), %rdi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	addq	%rsi, %r8
               	movq	(%r8), %r10
               	movq	%r10, (%rdi)
               	leaq	0x40(%rsp), %rdi
               	movq	-0x8(%rbp), %r8
               	movq	%r8, (%rdi,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	-0x30(%rbp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_maskstore_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x20(%rsp), %rax
               	leaq	0x60(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	xorl	%eax, %eax
               	movq	(%rdx,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rsi,%rcx), %r8
               	movq	(%r8), %r8
               	movq	%r8, -0x8(%rbp)
               	addq	%rdi, %rcx
               	leaq	-0x8(%rbp), %r8
               	movq	(%r8), %r10
               	movq	%r10, (%rcx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leave
               	retq

<_mm256_permutevar_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movl	0x20(%rsp), %eax
               	movl	0x24(%rsp), %ecx
               	movl	0x28(%rsp), %edx
               	movl	0x2c(%rsp), %esi
               	movl	0x30(%rsp), %edi
               	movl	0x34(%rsp), %r8d
               	movl	0x38(%rsp), %r9d
               	movl	0x3c(%rsp), %ebx
               	leaq	0x40(%rsp), %r12
               	andq	$0x3, %rax
               	movl	(%r12,%rax,4), %eax
               	movl	%eax, 0x60(%rsp)
               	leaq	0x40(%rsp), %rax
               	andq	$0x3, %rcx
               	movl	(%rax,%rcx,4), %eax
               	movl	%eax, 0x64(%rsp)
               	leaq	0x40(%rsp), %rax
               	andq	$0x3, %rdx
               	movl	(%rax,%rdx,4), %eax
               	movl	%eax, 0x68(%rsp)
               	leaq	0x40(%rsp), %rax
               	andq	$0x3, %rsi
               	movl	(%rax,%rsi,4), %eax
               	movl	%eax, 0x6c(%rsp)
               	leaq	0x40(%rsp), %rax
               	andq	$0x3, %rdi
               	orq	$0x4, %rdi
               	movl	(%rax,%rdi,4), %ecx
               	movl	%ecx, 0x70(%rsp)
               	andq	$0x3, %r8
               	orq	$0x4, %r8
               	movl	(%rax,%r8,4), %ecx
               	movl	%ecx, 0x74(%rsp)
               	andq	$0x3, %r9
               	orq	$0x4, %r9
               	movl	(%rax,%r9,4), %eax
               	movl	%eax, 0x78(%rsp)
               	leaq	0x60(%rsp), %rcx
               	leaq	0x40(%rsp), %rax
               	andq	$0x3, %rbx
               	orq	$0x4, %rbx
               	movl	(%rax,%rbx,4), %eax
               	movl	%eax, 0x7c(%rsp)
               	movq	-0x10(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<_mm256_permutevar_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	(%rsp), %rcx
               	leaq	0x40(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movq	0x20(%rsp), %rcx
               	movq	0x28(%rsp), %rdx
               	movq	0x30(%rsp), %rsi
               	movq	0x38(%rsp), %rdi
               	sarq	%rcx
               	andq	$0x1, %rcx
               	movq	(%rax,%rcx,8), %rax
               	movq	%rax, 0x60(%rsp)
               	leaq	0x40(%rsp), %rax
               	sarq	%rdx
               	andq	$0x1, %rdx
               	movq	(%rax,%rdx,8), %rcx
               	movq	%rcx, 0x68(%rsp)
               	leaq	0x60(%rsp), %rcx
               	sarq	%rsi
               	andq	$0x1, %rsi
               	orq	$0x2, %rsi
               	movq	(%rax,%rsi,8), %rdx
               	movq	%rdx, 0x70(%rsp)
               	sarq	%rdi
               	andq	$0x1, %rdi
               	orq	$0x2, %rdi
               	movq	(%rax,%rdi,8), %rax
               	movq	%rax, 0x78(%rsp)
               	movq	-0x10(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_permute4x64_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movl	$0x9c, %esi
               	movq	-0x20(%rbp), %rbx
               	leaq	0x20(%rsp), %rdi
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x20(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_permutevar8x32_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x10(%rbp), %rbx
               	leaq	0x40(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x40(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_testz_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movl	(%rsp), %eax
               	movl	0x4(%rsp), %ecx
               	movl	0x8(%rsp), %edx
               	movl	0xc(%rsp), %esi
               	movl	0x10(%rsp), %edi
               	movl	0x14(%rsp), %r8d
               	movl	0x18(%rsp), %r9d
               	movl	0x1c(%rsp), %ebx
               	movl	0x20(%rsp), %r12d
               	movl	0x24(%rsp), %r13d
               	movl	0x28(%rsp), %r14d
               	movl	0x2c(%rsp), %r15d
               	movl	0x30(%rsp), %r10d
               	movq	%r10, -0x8(%rbp)
               	movl	0x34(%rsp), %r10d
               	movq	%r10, -0x10(%rbp)
               	movl	0x38(%rsp), %r10d
               	movq	%r10, -0x18(%rbp)
               	movl	0x3c(%rsp), %r10d
               	movq	%r10, -0x20(%rbp)
               	movslq	%eax, %rax
               	movslq	%r12d, %r12
               	andq	%r12, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movslq	%ecx, %rcx
               	movslq	%r13d, %r12
               	andq	%r12, %rcx
               	testq	%rcx, %rcx
               	setge	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movslq	%edx, %rcx
               	movslq	%r14d, %rdx
               	andq	%rdx, %rcx
               	testq	%rcx, %rcx
               	setge	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movslq	%esi, %rcx
               	movslq	%r15d, %rdx
               	andq	%rdx, %rcx
               	testq	%rcx, %rcx
               	setge	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movslq	%edi, %rcx
               	movq	-0x8(%rbp), %rdx
               	movslq	%edx, %rdx
               	andq	%rdx, %rcx
               	testq	%rcx, %rcx
               	setge	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movslq	%r8d, %rcx
               	movq	-0x10(%rbp), %rdx
               	movslq	%edx, %rdx
               	andq	%rdx, %rcx
               	testq	%rcx, %rcx
               	setge	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movslq	%r9d, %rcx
               	movq	-0x18(%rbp), %rdx
               	movslq	%edx, %rdx
               	andq	%rdx, %rcx
               	testq	%rcx, %rcx
               	setge	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movslq	%ebx, %rcx
               	movq	-0x20(%rbp), %rdx
               	movslq	%edx, %rdx
               	andq	%rdx, %rcx
               	testq	%rcx, %rcx
               	setge	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<_mm256_testc_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movl	(%rsp), %eax
               	movl	0x4(%rsp), %ecx
               	movl	0x8(%rsp), %edx
               	movl	0xc(%rsp), %esi
               	movl	0x10(%rsp), %edi
               	movl	0x14(%rsp), %r8d
               	movl	0x18(%rsp), %r9d
               	movl	0x1c(%rsp), %ebx
               	movl	0x20(%rsp), %r12d
               	movl	0x24(%rsp), %r13d
               	movl	0x28(%rsp), %r14d
               	movl	0x2c(%rsp), %r15d
               	movl	0x30(%rsp), %r10d
               	movq	%r10, -0x8(%rbp)
               	movl	0x34(%rsp), %r10d
               	movq	%r10, -0x10(%rbp)
               	movl	0x38(%rsp), %r10d
               	movq	%r10, -0x18(%rbp)
               	movl	0x3c(%rsp), %r10d
               	movq	%r10, -0x20(%rbp)
               	movslq	%eax, %rax
               	xorq	$-0x1, %rax
               	movslq	%r12d, %r12
               	andq	%r12, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movslq	%ecx, %rcx
               	xorq	$-0x1, %rcx
               	movslq	%r13d, %r12
               	andq	%r12, %rcx
               	testq	%rcx, %rcx
               	setge	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movslq	%edx, %rcx
               	xorq	$-0x1, %rcx
               	movslq	%r14d, %rdx
               	andq	%rdx, %rcx
               	testq	%rcx, %rcx
               	setge	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movslq	%esi, %rcx
               	xorq	$-0x1, %rcx
               	movslq	%r15d, %rdx
               	andq	%rdx, %rcx
               	testq	%rcx, %rcx
               	setge	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movslq	%edi, %rcx
               	xorq	$-0x1, %rcx
               	movq	-0x8(%rbp), %rdx
               	movslq	%edx, %rdx
               	andq	%rdx, %rcx
               	testq	%rcx, %rcx
               	setge	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movslq	%r8d, %rcx
               	xorq	$-0x1, %rcx
               	movq	-0x10(%rbp), %rdx
               	movslq	%edx, %rdx
               	andq	%rdx, %rcx
               	testq	%rcx, %rcx
               	setge	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movslq	%r9d, %rcx
               	xorq	$-0x1, %rcx
               	movq	-0x18(%rbp), %rdx
               	movslq	%edx, %rdx
               	andq	%rdx, %rcx
               	testq	%rcx, %rcx
               	setge	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movslq	%ebx, %rcx
               	xorq	$-0x1, %rcx
               	movq	-0x20(%rbp), %rdx
               	movslq	%edx, %rdx
               	andq	%rdx, %rcx
               	testq	%rcx, %rcx
               	setge	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<_mm256_testz_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	movq	0x20(%rsp), %rdi
               	movq	0x28(%rsp), %r8
               	movq	0x30(%rsp), %r9
               	movq	0x38(%rsp), %rbx
               	andq	%rdi, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	andq	%r8, %rcx
               	testq	%rcx, %rcx
               	setge	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	andq	%r9, %rdx
               	testq	%rdx, %rdx
               	setge	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	andq	%rbx, %rsi
               	testq	%rsi, %rsi
               	setge	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_testc_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	movq	0x20(%rsp), %rdi
               	movq	0x28(%rsp), %r8
               	movq	0x30(%rsp), %r9
               	movq	0x38(%rsp), %rbx
               	xorq	$-0x1, %rax
               	andq	%rdi, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	xorq	$-0x1, %rcx
               	andq	%r8, %rcx
               	testq	%rcx, %rcx
               	setge	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	xorq	$-0x1, %rdx
               	andq	%r9, %rdx
               	testq	%rdx, %rdx
               	setge	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	xorq	$-0x1, %rsi
               	andq	%rbx, %rsi
               	testq	%rsi, %rsi
               	setge	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_testnzc_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	xorl	%ecx, %ecx
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	testl	%eax, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %rax
               	leave
               	retq

<_mm256_testnzc_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	xorl	%ecx, %ecx
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	testl	%eax, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %rax
               	leave
               	retq

<_mm256_round_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	%rsi, %rbx
               	movq	-0x20(%rbp), %r12
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x40(%rsp)
               	leaq	0x40(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x60(%rsp), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	movss	%xmm0, 0x60(%rsp)
               	movss	0x64(%rsp), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	movss	%xmm0, 0x64(%rsp)
               	movss	0x68(%rsp), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	movss	%xmm0, 0x68(%rsp)
               	movss	0x6c(%rsp), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	movss	%xmm0, 0x6c(%rsp)
               	movups	0x60(%rsp), %xmm0
               	movups	%xmm0, 0x50(%rsp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x40(%rsp)
               	leaq	0x40(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x60(%rsp), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	movss	%xmm0, 0x60(%rsp)
               	movss	0x64(%rsp), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	movss	%xmm0, 0x64(%rsp)
               	movss	0x68(%rsp), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	movss	%xmm0, 0x68(%rsp)
               	movss	0x6c(%rsp), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	movss	%xmm0, 0x6c(%rsp)
               	leaq	0x40(%rsp), %r9
               	movups	0x60(%rsp), %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	leaq	0x20(%rsp), %rdi
               	leaq	0x50(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x20(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r12)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r12)
               	movq	%r12, %rax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<_mm256_round_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	%rsi, %rbx
               	movq	-0x20(%rbp), %r12
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x40(%rsp)
               	leaq	0x40(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x60(%rsp), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsd	%xmm0, 0x60(%rsp)
               	movsd	0x68(%rsp), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsd	%xmm0, 0x68(%rsp)
               	movups	0x60(%rsp), %xmm0
               	movups	%xmm0, 0x50(%rsp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x40(%rsp)
               	leaq	0x40(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x60(%rsp), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsd	%xmm0, 0x60(%rsp)
               	movsd	0x68(%rsp), %xmm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsd	%xmm0, 0x68(%rsp)
               	leaq	0x40(%rsp), %r9
               	movups	0x60(%rsp), %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	leaq	0x20(%rsp), %rdi
               	leaq	0x50(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x20(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r12)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r12)
               	movq	%r12, %rax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<_mm256_dp_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%rbx
               	subq	$0xc0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x30(%rbp), %rbx
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x70(%rsp)
               	leaq	0x70(%rsp), %rax
               	leaq	0xa0(%rsp), %rsi
               	leaq	0x60(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0xb5, %edx
               	xorl	%eax, %eax
               	leaq	-0x10(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	leaq	0x4(%rax), %r8
               	sarxq	%r8, %rdx, %r8
               	testb	$0x1, %r8b
               	je	<addr>
               	leaq	(%rsi,%rcx), %r8
               	movss	(%r8), %xmm0
               	leaq	0x60(%rsp), %r8
               	addq	%r8, %rcx
               	movss	(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	movss	%xmm0, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movss	-0x10(%rbp), %xmm0
               	movss	-0xc(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0x8(%rbp), %xmm1
               	movss	-0x4(%rbp), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	leaq	0xa0(%rsp), %rcx
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rcx
               	sarxq	%rax, %rdx, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	movss	%xmm1, (%rcx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	0xa0(%rsp), %xmm0
               	movups	%xmm0, 0x80(%rsp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x90(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x70(%rsp)
               	leaq	0x70(%rsp), %rax
               	leaq	0xa0(%rsp), %rcx
               	leaq	0x90(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0xb5, %edx
               	xorl	%eax, %eax
               	leaq	-0x10(%rbp), %rsi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rsi
               	leaq	0x4(%rax), %rdi
               	sarxq	%rdi, %rdx, %rdi
               	testb	$0x1, %dil
               	je	<addr>
               	leaq	0xa0(%rsp), %rdi
               	addq	%rcx, %rdi
               	movss	(%rdi), %xmm0
               	leaq	0x60(%rsp), %rdi
               	addq	%rdi, %rcx
               	movss	(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	movss	%xmm0, (%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movss	-0x10(%rbp), %xmm0
               	movss	-0xc(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0x8(%rbp), %xmm1
               	movss	-0x4(%rbp), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	leaq	0xa0(%rsp), %rcx
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rcx
               	sarxq	%rax, %rdx, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	movss	%xmm1, (%rcx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %r9
               	movups	0xa0(%rsp), %xmm0
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x40(%rsp), %rdi
               	leaq	0x80(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_stream_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leave
               	retq

<_mm256_stream_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leave
               	retq

<_mm256_loadu2_m128>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%rbx
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movq	-0x30(%rbp), %rbx
               	leaq	(%rsp), %rdi
               	leaq	0x20(%rsp), %r9
               	movups	(%rdx), %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x30(%rsp), %rax
               	movups	(%rsi), %xmm0
               	movups	%xmm0, 0x30(%rsp)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_loadu2_m128d>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%rbx
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movq	-0x30(%rbp), %rbx
               	leaq	(%rsp), %rdi
               	leaq	0x20(%rsp), %r9
               	movups	(%rdx), %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x30(%rsp), %rax
               	movups	(%rsi), %xmm0
               	movups	%xmm0, 0x30(%rsp)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_storeu2_m128>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x20(%rsp), %rcx
               	leaq	0x30(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r12)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x20(%rsp), %rcx
               	leaq	0x30(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq

<_mm256_storeu2_m128d>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x20(%rsp), %rcx
               	leaq	0x30(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r12)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x20(%rsp), %rcx
               	leaq	0x30(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq

<prepare>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r14
               	movq	%r9, 0x38(%rsp)
               	movslq	%r8d, %r11
               	movq	%r11, 0x48(%rsp)
               	movq	%rcx, %r13
               	movslq	%edx, %rbx
               	movq	%rsi, 0x40(%rsp)
               	xorl	%esi, %esi
               	movl	$0x80, %edx
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x40(%r14), %rdx
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rsi
               	shrq	$0xc, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rsi
               	shlq	$0x19, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rsi
               	shrq	$0x1b, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rcx
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	xorl	%r12d, %r12d
               	cmpl	0x40(%rsp), %r12d
               	jge	<addr>
               	movl	$0x1, %r9d
               	movq	0x38(%rsp), %r10
               	testl	%r10d, %r10d
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	shrq	$0x3e, %rax
               	testl	%eax, %eax
               	setne	%r9b
               	movzbq	%r9b, %r9
               	testq	%r9, %r9
               	je	<addr>
               	movl	$0x1f8, %eax            # imm = 0x1F8
               	cltd
               	idivl	0x48(%rsp)
               	movslq	%eax, %rcx
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rdx
               	shrq	$0xc, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdx
               	shlq	$0x19, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rdx
               	shrq	$0x1b, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %rsi
               	movq	%rcx, %rdi
               	shlq	%rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	subq	%rcx, %rdx
               	xorl	%eax, %eax
               	cmpl	%r13d, %eax
               	jge	<addr>
               	movq	%r13, %rcx
               	imulq	%r12, %rcx
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	movslq	%edi, %rdi
               	shrxq	%rdi, %rdx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%r14,%rcx)
               	incq	%rax
               	cmpl	%r13d, %eax
               	jl	<addr>
               	leaq	0x20(%r14), %rdi
               	testq	%r9, %r9
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	decq	%rcx
               	movslq	%ecx, %rcx
               	shlxq	%rcx, %rax, %rcx
               	xorl	%eax, %eax
               	cmpl	%ebx, %eax
               	jge	<addr>
               	movq	%rbx, %rsi
               	imulq	%r12, %rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	movslq	%r8d, %r8
               	shrxq	%r8, %rcx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rdi,%rsi)
               	incq	%rax
               	cmpl	%ebx, %eax
               	jl	<addr>
               	leaq	0x60(%r14), %r15
               	testq	%r9, %r9
               	je	<addr>
               	movq	%rdx, %rax
               	imulq	0x48(%rsp), %rax
               	movq	$0x0, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x200, %rcx            # imm = 0x200
               	leaq	(%rcx,%rax), %rsi
               	movq	%rbx, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	-0x8(%rbp), %rcx
               	xorl	%eax, %eax
               	cmpl	%ebx, %eax
               	jge	<addr>
               	movq	%rbx, %rdx
               	imulq	%r12, %rdx
               	addq	%rax, %rdx
               	movslq	%edx, %rdx
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	movslq	%edi, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%r15,%rdx)
               	incq	%rax
               	cmpl	%ebx, %eax
               	jge	<addr>
               	jmp	<addr>
               	leaq	0x40(%r14), %rax
               	movq	$0x0, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	movq	%rbx, %rcx
               	imulq	%r12, %rcx
               	movslq	%ecx, %rcx
               	leaq	(%rax,%rcx), %rsi
               	movq	%rbx, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	-0x8(%rbp), %rcx
               	jmp	<addr>
               	movl	$0x7f, %ecx
               	jmp	<addr>
               	movl	$0x10000000, %edx       # imm = 0x10000000
               	jmp	<addr>
               	incq	%r12
               	cmpl	0x40(%rsp), %r12d
               	jl	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<check_gathers>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xe0, %rsp
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1e0, %rsp            # imm = 0x1E0
               	movq	$0x0, (%rsp)
               	andq	$-0x20, %rsp
               	movq	$0x0, (%rsp)
               	movslq	%edi, %rbx
               	movl	$0x4, %esi
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x1, %r8d
               	movq	%rsi, %rdx
               	movq	%rbx, %r9
               	movq	%rsi, %rcx
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x720(%rsp), %rsi
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rdx
               	addq	$0x40, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x730(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rdi
               	leaq	0xca0(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xcb0(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xcc0(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xca0(%rsp), %rcx
               	leaq	0xcd0(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xce0(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xcf0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xd00(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0xcd0(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0x88(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	leaq	0xd00(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0xcf0(%rsp), %rsi
               	movl	-0x88(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x7a0(%rsp), %rax
               	movups	0xcf0(%rsp), %xmm0
               	movups	%xmm0, 0x7a0(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x730(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %r12d
               	xorl	%eax, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x4, %edx
               	movl	$0x1, %r8d
               	movq	%rdx, %rcx
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %r9
               	leaq	-0x80(%rbp), %rax
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0xc0(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	movl	$0x1, %edx
               	subq	$0x60, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0xc0(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x60(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movl	$0x1, %r8d
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x720(%rsp), %rsi
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rdx
               	addq	$0x40, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x730(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rdi
               	leaq	0xd40(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xd50(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xd60(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xd40(%rsp), %rcx
               	leaq	0xd70(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xd80(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xd90(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x780(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0xd70(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	%rsi, -0xe0(%rbp)
               	movq	(%rcx,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xe0(%rbp), %rsi
               	leaq	0x780(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	addq	%rdx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0xd90(%rsp), %rsi
               	movq	-0xe0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x7c0(%rsp), %rax
               	movups	0xd90(%rsp), %xmm0
               	movups	%xmm0, 0x7c0(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x730(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movl	$0x1, %r8d
               	movq	%rsi, %rcx
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %r9
               	leaq	-0x80(%rbp), %rax
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x100(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	0x700(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	movl	$0x1, %edx
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x100(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x60(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x1, %r8d
               	movq	%rsi, %rdx
               	movq	%rbx, %r9
               	movq	%rsi, %rcx
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rcx
               	addq	$0x40, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x740(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	movups	0x720(%rsp), %xmm0
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x700(%rsp), %rdx
               	movups	0x710(%rsp), %xmm1
               	leaq	0xdd0(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xde0(%rsp), %rdx
               	movups	%xmm0, 0xde0(%rsp)
               	movups	%xmm1, 0xdf0(%rsp)
               	leaq	0xe00(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x790(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movl	(%rdx,%rax,4), %esi
               	movl	%esi, -0xd8(%rbp)
               	leaq	0xdf0(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xd8(%rbp), %rsi
               	leaq	0x790(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	addq	%rcx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0xe00(%rsp), %rsi
               	movl	-0xd8(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x7e0(%rsp), %rax
               	movups	0xe00(%rsp), %xmm0
               	movups	%xmm0, 0x7e0(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x740(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x4, %edx
               	movl	$0x1, %r8d
               	movq	%rdx, %rcx
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %r9
               	leaq	-0x80(%rbp), %rax
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x160(%rsp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x180(%rsp), %rdi
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x180(%rsp), %r9
               	movl	$0x1, %edx
               	leaq	0x140(%rsp), %rdi
               	leaq	0x160(%rsp), %rax
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %rsi
               	leaq	(%rsp), %rcx
               	subq	$0x60, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0x140(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x80(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movl	$0x1, %r8d
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rcx
               	addq	$0x40, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x750(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	movups	0x720(%rsp), %xmm0
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x700(%rsp), %rdx
               	movups	0x710(%rsp), %xmm1
               	leaq	0xe30(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xe40(%rsp), %rdx
               	movups	%xmm0, 0xe40(%rsp)
               	movups	%xmm1, 0xe50(%rsp)
               	leaq	0xe60(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xe70(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movq	(%rdx,%rax,8), %rsi
               	movq	%rsi, -0xd0(%rbp)
               	leaq	0xe50(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xd0(%rbp), %rsi
               	leaq	0xe70(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	addq	%rcx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0xe60(%rsp), %rsi
               	movq	-0xd0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x800(%rsp), %rax
               	movups	0xe60(%rsp), %xmm0
               	movups	%xmm0, 0x800(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x750(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movl	$0x1, %r8d
               	movq	%rsi, %rcx
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %r9
               	leaq	-0x80(%rbp), %rax
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x160(%rsp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x180(%rsp), %rdi
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x180(%rsp), %r9
               	movl	$0x1, %edx
               	leaq	0x1c0(%rsp), %rdi
               	leaq	0x160(%rsp), %rax
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %rsi
               	leaq	0x700(%rsp), %rcx
               	subq	$0x40, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rcx, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x1c0(%rsp), %rax
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0xa0(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	movl	$0x8, %ecx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x4, %edx
               	movl	$0x1, %r8d
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x720(%rsp), %rsi
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rdx
               	addq	$0x40, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x730(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rdi
               	leaq	0xea0(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xeb0(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xec0(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xea0(%rsp), %rcx
               	leaq	0xed0(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xee0(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xef0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xf00(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0xed0(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0xc8(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xc8(%rbp), %rsi
               	leaq	0xf00(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0xef0(%rsp), %rsi
               	movl	-0xc8(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x820(%rsp), %rax
               	movups	0xef0(%rsp), %xmm0
               	movups	%xmm0, 0x820(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x730(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %ecx
               	movl	$0x1, %r8d
               	movq	%rsi, %rdx
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %r9
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%r9)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rdx
               	addq	$0x40, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %rax
               	movl	$0x1, %esi
               	subq	$0x20, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rcx, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x840(%rsp)
               	leaq	0x840(%rsp), %rax
               	leaq	0x730(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x730(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x1, %r8d
               	movq	%rdx, %rcx
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x720(%rsp), %rsi
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rdx
               	addq	$0x40, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x730(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rdi
               	leaq	0xf40(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xf50(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xf60(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xf40(%rsp), %rcx
               	leaq	0xf70(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xf80(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xf90(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xfa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0xf70(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	%rsi, -0xc0(%rbp)
               	movq	(%rcx,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xc0(%rbp), %rsi
               	leaq	0xfa0(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	addq	%rdx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0xf90(%rsp), %rsi
               	movq	-0xc0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x860(%rsp), %rax
               	movups	0xf90(%rsp), %xmm0
               	movups	%xmm0, 0x860(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x730(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movl	$0x1, %r8d
               	movq	%rdx, %rcx
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %r9
               	leaq	-0x80(%rbp), %rax
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x200(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	movl	$0x1, %edx
               	subq	$0x60, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0x200(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x60(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x4, %edx
               	movl	$0x8, %ecx
               	movl	$0x1, %r8d
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rcx
               	addq	$0x40, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x740(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	movups	0x720(%rsp), %xmm0
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x700(%rsp), %rdx
               	movups	0x710(%rsp), %xmm1
               	leaq	0xfe0(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xff0(%rsp), %rdx
               	movups	%xmm0, 0xff0(%rsp)
               	movups	%xmm1, 0x1000(%rsp)
               	leaq	0x1010(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x1020(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movl	(%rdx,%rax,4), %esi
               	movl	%esi, -0xb8(%rbp)
               	leaq	0x1000(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xb8(%rbp), %rsi
               	leaq	0x1020(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	addq	%rcx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0x1010(%rsp), %rsi
               	movl	-0xb8(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x880(%rsp), %rax
               	movups	0x1010(%rsp), %xmm0
               	movups	%xmm0, 0x880(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x740(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %ecx
               	movl	$0x1, %r8d
               	movq	%rsi, %rdx
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rcx
               	addq	$0x40, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x160(%rsp), %r9
               	movups	0x720(%rsp), %xmm0
               	movups	%xmm0, 0x160(%rsp)
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %rax
               	movups	0x710(%rsp), %xmm0
               	movups	%xmm0, 0x180(%rsp)
               	leaq	0x180(%rsp), %rcx
               	movl	$0x1, %esi
               	subq	$0x20, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rcx, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x8a0(%rsp)
               	leaq	0x8a0(%rsp), %rax
               	leaq	0x740(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x740(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x1, %r8d
               	movq	%rdx, %rcx
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rcx
               	addq	$0x40, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x750(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	movups	0x720(%rsp), %xmm0
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x700(%rsp), %rdx
               	movups	0x710(%rsp), %xmm1
               	leaq	0x1050(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x1060(%rsp), %rdx
               	movups	%xmm0, 0x1060(%rsp)
               	movups	%xmm1, 0x1070(%rsp)
               	leaq	0x1080(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x1090(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movq	(%rdx,%rax,8), %rsi
               	movq	%rsi, -0xb0(%rbp)
               	leaq	0x1070(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xb0(%rbp), %rsi
               	leaq	0x1090(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	addq	%rcx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0x1080(%rsp), %rsi
               	movq	-0xb0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x8c0(%rsp), %rax
               	movups	0x1080(%rsp), %xmm0
               	movups	%xmm0, 0x8c0(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x750(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movl	$0x1, %r8d
               	movq	%rdx, %rcx
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %r9
               	leaq	-0x80(%rbp), %rax
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x160(%rsp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x180(%rsp), %rdi
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x180(%rsp), %r9
               	movl	$0x1, %edx
               	leaq	0x240(%rsp), %rdi
               	leaq	0x160(%rsp), %rax
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %rsi
               	leaq	(%rsp), %rcx
               	subq	$0x60, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0x240(%rsp), %rax
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0xa0(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	movl	$0x4, %esi
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %r8d
               	movq	%rsi, %rdx
               	movq	%rbx, %r9
               	movq	%rsi, %rcx
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x720(%rsp), %rsi
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rdx
               	addq	$0x40, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x730(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rdi
               	leaq	0xca0(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xcb0(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xcc0(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xca0(%rsp), %rcx
               	leaq	0xcd0(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xce0(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xcf0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xd00(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0xcd0(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0x88(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	leaq	0xd00(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	%rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0xcf0(%rsp), %rsi
               	movl	-0x88(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x8e0(%rsp), %rax
               	movups	0xcf0(%rsp), %xmm0
               	movups	%xmm0, 0x8e0(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x730(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x4, %edx
               	movl	$0x2, %r8d
               	movq	%rdx, %rcx
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %r9
               	leaq	-0x80(%rbp), %rax
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x280(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	movl	$0x2, %edx
               	subq	$0x60, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0x280(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x60(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movq	%rsi, %r8
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x720(%rsp), %rsi
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rdx
               	addq	$0x40, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x730(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rdi
               	leaq	0xd40(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xd50(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xd60(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xd40(%rsp), %rcx
               	leaq	0xd70(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xd80(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xd90(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x780(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0xd70(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	%rsi, -0xe0(%rbp)
               	movq	(%rcx,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xe0(%rbp), %rsi
               	leaq	0x780(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	%rdi
               	addq	%rdx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0xd90(%rsp), %rsi
               	movq	-0xe0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x900(%rsp), %rax
               	movups	0xd90(%rsp), %xmm0
               	movups	%xmm0, 0x900(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x730(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movl	$0x2, %r8d
               	movq	%rsi, %rcx
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %r9
               	leaq	-0x80(%rbp), %rax
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x2c0(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	0x700(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	movl	$0x2, %edx
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x2c0(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x60(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x2, %r8d
               	movq	%rsi, %rdx
               	movq	%rbx, %r9
               	movq	%rsi, %rcx
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rcx
               	addq	$0x40, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x740(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	movups	0x720(%rsp), %xmm0
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x700(%rsp), %rdx
               	movups	0x710(%rsp), %xmm1
               	leaq	0xdd0(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xde0(%rsp), %rdx
               	movups	%xmm0, 0xde0(%rsp)
               	movups	%xmm1, 0xdf0(%rsp)
               	leaq	0xe00(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x790(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movl	(%rdx,%rax,4), %esi
               	movl	%esi, -0xd8(%rbp)
               	leaq	0xdf0(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xd8(%rbp), %rsi
               	leaq	0x790(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	%rdi
               	addq	%rcx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0xe00(%rsp), %rsi
               	movl	-0xd8(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x920(%rsp), %rax
               	movups	0xe00(%rsp), %xmm0
               	movups	%xmm0, 0x920(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x740(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x4, %edx
               	movl	$0x2, %r8d
               	movq	%rdx, %rcx
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %r9
               	leaq	-0x80(%rbp), %rax
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x160(%rsp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x180(%rsp), %rdi
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x180(%rsp), %r9
               	movl	$0x2, %edx
               	leaq	0x300(%rsp), %rdi
               	leaq	0x160(%rsp), %rax
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %rsi
               	leaq	(%rsp), %rcx
               	subq	$0x60, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0x300(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x80(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movq	%rsi, %r8
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rcx
               	addq	$0x40, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x750(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	movups	0x720(%rsp), %xmm0
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x700(%rsp), %rdx
               	movups	0x710(%rsp), %xmm1
               	leaq	0xe30(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xe40(%rsp), %rdx
               	movups	%xmm0, 0xe40(%rsp)
               	movups	%xmm1, 0xe50(%rsp)
               	leaq	0xe60(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xe70(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movq	(%rdx,%rax,8), %rsi
               	movq	%rsi, -0xd0(%rbp)
               	leaq	0xe50(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xd0(%rbp), %rsi
               	leaq	0xe70(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	%rdi
               	addq	%rcx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0xe60(%rsp), %rsi
               	movq	-0xd0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x940(%rsp), %rax
               	movups	0xe60(%rsp), %xmm0
               	movups	%xmm0, 0x940(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x750(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movl	$0x2, %r8d
               	movq	%rsi, %rcx
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %r9
               	leaq	-0x80(%rbp), %rax
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x160(%rsp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x180(%rsp), %rdi
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x180(%rsp), %r9
               	movl	$0x2, %edx
               	leaq	0x340(%rsp), %rdi
               	leaq	0x160(%rsp), %rax
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %rsi
               	leaq	0x700(%rsp), %rcx
               	subq	$0x40, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rcx, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x340(%rsp), %rax
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0xa0(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	movl	$0x8, %ecx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x4, %edx
               	movq	%rsi, %r8
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x720(%rsp), %rsi
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rdx
               	addq	$0x40, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x730(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rdi
               	leaq	0xea0(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xeb0(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xec0(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xea0(%rsp), %rcx
               	leaq	0xed0(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xee0(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xef0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xf00(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0xed0(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0xc8(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xc8(%rbp), %rsi
               	leaq	0xf00(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	shlq	%rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0xef0(%rsp), %rsi
               	movl	-0xc8(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x960(%rsp), %rax
               	movups	0xef0(%rsp), %xmm0
               	movups	%xmm0, 0x960(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x730(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %ecx
               	movl	$0x2, %r8d
               	movq	%rsi, %rdx
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %r9
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%r9)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rdx
               	addq	$0x40, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %rax
               	movl	$0x2, %esi
               	subq	$0x20, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rcx, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x980(%rsp)
               	leaq	0x980(%rsp), %rax
               	leaq	0x730(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x730(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movq	%rdx, %rcx
               	movq	%rbx, %r9
               	movq	%rsi, %r8
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x720(%rsp), %rsi
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rdx
               	addq	$0x40, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x730(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rdi
               	leaq	0xf40(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xf50(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xf60(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xf40(%rsp), %rcx
               	leaq	0xf70(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xf80(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xf90(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xfa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0xf70(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	%rsi, -0xc0(%rbp)
               	movq	(%rcx,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xc0(%rbp), %rsi
               	leaq	0xfa0(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	shlq	%rdi
               	addq	%rdx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0xf90(%rsp), %rsi
               	movq	-0xc0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x9a0(%rsp), %rax
               	movups	0xf90(%rsp), %xmm0
               	movups	%xmm0, 0x9a0(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x730(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movl	$0x2, %r8d
               	movq	%rdx, %rcx
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %r9
               	leaq	-0x80(%rbp), %rax
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x380(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	movl	$0x2, %edx
               	subq	$0x60, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0x380(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x60(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x4, %edx
               	movl	$0x8, %ecx
               	movq	%rsi, %r8
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rcx
               	addq	$0x40, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x740(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	movups	0x720(%rsp), %xmm0
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x700(%rsp), %rdx
               	movups	0x710(%rsp), %xmm1
               	leaq	0xfe0(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xff0(%rsp), %rdx
               	movups	%xmm0, 0xff0(%rsp)
               	movups	%xmm1, 0x1000(%rsp)
               	leaq	0x1010(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x1020(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movl	(%rdx,%rax,4), %esi
               	movl	%esi, -0xb8(%rbp)
               	leaq	0x1000(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xb8(%rbp), %rsi
               	leaq	0x1020(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	shlq	%rdi
               	addq	%rcx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0x1010(%rsp), %rsi
               	movl	-0xb8(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x9c0(%rsp), %rax
               	movups	0x1010(%rsp), %xmm0
               	movups	%xmm0, 0x9c0(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x740(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %ecx
               	movl	$0x2, %r8d
               	movq	%rsi, %rdx
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rcx
               	addq	$0x40, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x160(%rsp), %r9
               	movups	0x720(%rsp), %xmm0
               	movups	%xmm0, 0x160(%rsp)
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %rax
               	movups	0x710(%rsp), %xmm0
               	movups	%xmm0, 0x180(%rsp)
               	leaq	0x180(%rsp), %rcx
               	movl	$0x2, %esi
               	subq	$0x20, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rcx, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x9e0(%rsp)
               	leaq	0x9e0(%rsp), %rax
               	leaq	0x740(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x740(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movq	%rdx, %rcx
               	movq	%rbx, %r9
               	movq	%rsi, %r8
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rcx
               	addq	$0x40, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x750(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	movups	0x720(%rsp), %xmm0
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x700(%rsp), %rdx
               	movups	0x710(%rsp), %xmm1
               	leaq	0x1050(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x1060(%rsp), %rdx
               	movups	%xmm0, 0x1060(%rsp)
               	movups	%xmm1, 0x1070(%rsp)
               	leaq	0x1080(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x1090(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movq	(%rdx,%rax,8), %rsi
               	movq	%rsi, -0xb0(%rbp)
               	leaq	0x1070(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xb0(%rbp), %rsi
               	leaq	0x1090(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	shlq	%rdi
               	addq	%rcx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0x1080(%rsp), %rsi
               	movq	-0xb0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0xa00(%rsp), %rax
               	movups	0x1080(%rsp), %xmm0
               	movups	%xmm0, 0xa00(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x750(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movl	$0x2, %r8d
               	movq	%rdx, %rcx
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %r9
               	leaq	-0x80(%rbp), %rax
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x160(%rsp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x180(%rsp), %rdi
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x180(%rsp), %r9
               	movl	$0x2, %edx
               	leaq	0x3c0(%rsp), %rdi
               	leaq	0x160(%rsp), %rax
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %rsi
               	leaq	(%rsp), %rcx
               	subq	$0x60, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0x3c0(%rsp), %rax
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0xa0(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	movl	$0x4, %esi
               	leaq	-0x80(%rbp), %rdi
               	movq	%rsi, %rdx
               	movq	%rbx, %r9
               	movq	%rsi, %r8
               	movq	%rsi, %rcx
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x720(%rsp), %rsi
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rdx
               	addq	$0x40, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x730(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rdi
               	leaq	0xca0(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xcb0(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xcc0(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xca0(%rsp), %rcx
               	leaq	0xcd0(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xce0(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xcf0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xd00(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0xcd0(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0x88(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	leaq	0xd00(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	$0x2, %rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0xcf0(%rsp), %rsi
               	movl	-0x88(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0xa20(%rsp), %rax
               	movups	0xcf0(%rsp), %xmm0
               	movups	%xmm0, 0xa20(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x730(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x4, %edx
               	movq	%rdx, %rcx
               	movq	%rbx, %r9
               	movq	%rdx, %r8
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %r9
               	leaq	-0x80(%rbp), %rax
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x400(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	movl	$0x4, %edx
               	subq	$0x60, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0x400(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x60(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movq	%rcx, %r8
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x720(%rsp), %rsi
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rdx
               	addq	$0x40, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x730(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rdi
               	leaq	0xd40(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xd50(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xd60(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xd40(%rsp), %rcx
               	leaq	0xd70(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xd80(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xd90(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x780(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0xd70(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	%rsi, -0xe0(%rbp)
               	movq	(%rcx,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xe0(%rbp), %rsi
               	leaq	0x780(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	$0x2, %rdi
               	addq	%rdx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0xd90(%rsp), %rsi
               	movq	-0xe0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0xa40(%rsp), %rax
               	movups	0xd90(%rsp), %xmm0
               	movups	%xmm0, 0xa40(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x730(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movq	%rsi, %rcx
               	movq	%rbx, %r9
               	movq	%rsi, %r8
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %r9
               	leaq	-0x80(%rbp), %rax
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x440(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	0x700(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	movl	$0x4, %edx
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x440(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x60(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movq	%rsi, %rdx
               	movq	%rbx, %r9
               	movq	%rsi, %r8
               	movq	%rsi, %rcx
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rcx
               	addq	$0x40, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x760(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	movups	0x720(%rsp), %xmm0
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x700(%rsp), %rdx
               	movups	0x710(%rsp), %xmm1
               	leaq	0xdd0(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xde0(%rsp), %rdx
               	movups	%xmm0, 0xde0(%rsp)
               	movups	%xmm1, 0xdf0(%rsp)
               	leaq	0xe00(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x790(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movl	(%rdx,%rax,4), %esi
               	movl	%esi, -0xd8(%rbp)
               	leaq	0xdf0(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xd8(%rbp), %rsi
               	leaq	0x790(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	$0x2, %rdi
               	addq	%rcx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0xe00(%rsp), %rsi
               	movl	-0xd8(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0xa60(%rsp), %rax
               	movups	0xe00(%rsp), %xmm0
               	movups	%xmm0, 0xa60(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x760(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x4, %edx
               	movq	%rdx, %rcx
               	movq	%rbx, %r9
               	movq	%rdx, %r8
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %r9
               	leaq	-0x80(%rbp), %rax
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x160(%rsp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x180(%rsp), %rdi
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x180(%rsp), %r9
               	movl	$0x4, %edx
               	leaq	0x480(%rsp), %rdi
               	leaq	0x160(%rsp), %rax
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %rsi
               	leaq	(%rsp), %rcx
               	subq	$0x60, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0x480(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x80(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movq	%rcx, %r8
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rcx
               	addq	$0x40, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x770(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	movups	0x720(%rsp), %xmm0
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x700(%rsp), %rdx
               	movups	0x710(%rsp), %xmm1
               	leaq	0xe30(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xe40(%rsp), %rdx
               	movups	%xmm0, 0xe40(%rsp)
               	movups	%xmm1, 0xe50(%rsp)
               	leaq	0xe60(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xe70(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movq	(%rdx,%rax,8), %rsi
               	movq	%rsi, -0xd0(%rbp)
               	leaq	0xe50(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xd0(%rbp), %rsi
               	leaq	0xe70(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	$0x2, %rdi
               	addq	%rcx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0xe60(%rsp), %rsi
               	movq	-0xd0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0xa80(%rsp), %rax
               	movups	0xe60(%rsp), %xmm0
               	movups	%xmm0, 0xa80(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x770(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movq	%rsi, %rcx
               	movq	%rbx, %r9
               	movq	%rsi, %r8
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %r9
               	leaq	-0x80(%rbp), %rax
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x160(%rsp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x180(%rsp), %rdi
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x180(%rsp), %r9
               	movl	$0x4, %edx
               	leaq	0x4c0(%rsp), %rdi
               	leaq	0x160(%rsp), %rax
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %rsi
               	leaq	0x700(%rsp), %rcx
               	subq	$0x40, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rcx, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x4c0(%rsp), %rax
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0xa0(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	movl	$0x8, %ecx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x4, %edx
               	movq	%rdx, %r8
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x720(%rsp), %rsi
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rdx
               	addq	$0x40, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x730(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rdi
               	leaq	0xea0(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xeb0(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xec0(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xea0(%rsp), %rcx
               	leaq	0xed0(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xee0(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xef0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xf00(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0xed0(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0xc8(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xc8(%rbp), %rsi
               	leaq	0xf00(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	shlq	$0x2, %rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0xef0(%rsp), %rsi
               	movl	-0xc8(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0xaa0(%rsp), %rax
               	movups	0xef0(%rsp), %xmm0
               	movups	%xmm0, 0xaa0(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x730(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %ecx
               	movq	%rsi, %rdx
               	movq	%rbx, %r9
               	movq	%rsi, %r8
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %r9
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%r9)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rdx
               	addq	$0x40, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %rax
               	movl	$0x4, %esi
               	subq	$0x20, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rcx, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xac0(%rsp)
               	leaq	0xac0(%rsp), %rax
               	leaq	0x730(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x730(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %r8d
               	movq	%rdx, %rcx
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x720(%rsp), %rsi
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rdx
               	addq	$0x40, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x730(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rdi
               	leaq	0xf40(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xf50(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xf60(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xf40(%rsp), %rcx
               	leaq	0xf70(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xf80(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xf90(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xfa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0xf70(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	%rsi, -0xc0(%rbp)
               	movq	(%rcx,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xc0(%rbp), %rsi
               	leaq	0xfa0(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	shlq	$0x2, %rdi
               	addq	%rdx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0xf90(%rsp), %rsi
               	movq	-0xc0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0xae0(%rsp), %rax
               	movups	0xf90(%rsp), %xmm0
               	movups	%xmm0, 0xae0(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x730(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movq	%rdx, %rcx
               	movq	%rbx, %r9
               	movq	%rsi, %r8
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %r9
               	leaq	-0x80(%rbp), %rax
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x500(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	movl	$0x4, %edx
               	subq	$0x60, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0x500(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x60(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x4, %edx
               	movl	$0x8, %ecx
               	movq	%rdx, %r8
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rcx
               	addq	$0x40, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x760(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	movups	0x720(%rsp), %xmm0
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x700(%rsp), %rdx
               	movups	0x710(%rsp), %xmm1
               	leaq	0xfe0(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xff0(%rsp), %rdx
               	movups	%xmm0, 0xff0(%rsp)
               	movups	%xmm1, 0x1000(%rsp)
               	leaq	0x1010(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x1020(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movl	(%rdx,%rax,4), %esi
               	movl	%esi, -0xb8(%rbp)
               	leaq	0x1000(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xb8(%rbp), %rsi
               	leaq	0x1020(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	shlq	$0x2, %rdi
               	addq	%rcx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0x1010(%rsp), %rsi
               	movl	-0xb8(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0xb00(%rsp), %rax
               	movups	0x1010(%rsp), %xmm0
               	movups	%xmm0, 0xb00(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x760(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %ecx
               	movq	%rsi, %rdx
               	movq	%rbx, %r9
               	movq	%rsi, %r8
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rcx
               	addq	$0x40, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x160(%rsp), %r9
               	movups	0x720(%rsp), %xmm0
               	movups	%xmm0, 0x160(%rsp)
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %rax
               	movups	0x710(%rsp), %xmm0
               	movups	%xmm0, 0x180(%rsp)
               	leaq	0x180(%rsp), %rcx
               	movl	$0x4, %esi
               	subq	$0x20, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rcx, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xb20(%rsp)
               	leaq	0xb20(%rsp), %rax
               	leaq	0x760(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x760(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %r8d
               	movq	%rdx, %rcx
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rcx
               	addq	$0x40, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x770(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	movups	0x720(%rsp), %xmm0
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x700(%rsp), %rdx
               	movups	0x710(%rsp), %xmm1
               	leaq	0x1050(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x1060(%rsp), %rdx
               	movups	%xmm0, 0x1060(%rsp)
               	movups	%xmm1, 0x1070(%rsp)
               	leaq	0x1080(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x1090(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movq	(%rdx,%rax,8), %rsi
               	movq	%rsi, -0xb0(%rbp)
               	leaq	0x1070(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xb0(%rbp), %rsi
               	leaq	0x1090(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	shlq	$0x2, %rdi
               	addq	%rcx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0x1080(%rsp), %rsi
               	movq	-0xb0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0xb40(%rsp), %rax
               	movups	0x1080(%rsp), %xmm0
               	movups	%xmm0, 0xb40(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x770(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movq	%rdx, %rcx
               	movq	%rbx, %r9
               	movq	%rsi, %r8
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %r9
               	leaq	-0x80(%rbp), %rax
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x160(%rsp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x180(%rsp), %rdi
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x180(%rsp), %r9
               	movl	$0x4, %edx
               	leaq	0x540(%rsp), %rdi
               	leaq	0x160(%rsp), %rax
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %rsi
               	leaq	(%rsp), %rcx
               	subq	$0x60, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0x540(%rsp), %rax
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0xa0(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	movl	$0x4, %esi
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x8, %r8d
               	movq	%rsi, %rdx
               	movq	%rbx, %r9
               	movq	%rsi, %rcx
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x720(%rsp), %rsi
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rdx
               	addq	$0x40, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x730(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rdi
               	leaq	0xca0(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xcb0(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xcc0(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xca0(%rsp), %rcx
               	leaq	0xcd0(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xce0(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xcf0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xd00(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0xcd0(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0x88(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	leaq	0xd00(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	$0x3, %rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0xcf0(%rsp), %rsi
               	movl	-0x88(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0xb60(%rsp), %rax
               	movups	0xcf0(%rsp), %xmm0
               	movups	%xmm0, 0xb60(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x730(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x4, %edx
               	movq	%rdx, %rcx
               	movq	%rbx, %r9
               	movq	%rsi, %r8
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %r9
               	leaq	-0x80(%rbp), %rax
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x580(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	movl	$0x8, %edx
               	subq	$0x60, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0x580(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x60(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movq	%rdx, %r8
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x720(%rsp), %rsi
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rdx
               	addq	$0x40, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x730(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rdi
               	leaq	0xd40(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xd50(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xd60(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xd40(%rsp), %rcx
               	leaq	0xd70(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xd80(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xd90(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x780(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0xd70(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	%rsi, -0xe0(%rbp)
               	movq	(%rcx,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xe0(%rbp), %rsi
               	leaq	0x780(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	$0x3, %rdi
               	addq	%rdx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0xd90(%rsp), %rsi
               	movq	-0xe0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0xb80(%rsp), %rax
               	movups	0xd90(%rsp), %xmm0
               	movups	%xmm0, 0xb80(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x730(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movq	%rsi, %rcx
               	movq	%rbx, %r9
               	movq	%rdx, %r8
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %r9
               	leaq	-0x80(%rbp), %rax
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x5c0(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	0x700(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	movl	$0x8, %edx
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x5c0(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x60(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %r8d
               	movq	%rsi, %rdx
               	movq	%rbx, %r9
               	movq	%rsi, %rcx
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rcx
               	addq	$0x40, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x780(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	movups	0x720(%rsp), %xmm0
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x700(%rsp), %rdx
               	movups	0x710(%rsp), %xmm1
               	leaq	0xdd0(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xde0(%rsp), %rdx
               	movups	%xmm0, 0xde0(%rsp)
               	movups	%xmm1, 0xdf0(%rsp)
               	leaq	0xe00(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x790(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movl	(%rdx,%rax,4), %esi
               	movl	%esi, -0xd8(%rbp)
               	leaq	0xdf0(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xd8(%rbp), %rsi
               	leaq	0x790(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	$0x3, %rdi
               	addq	%rcx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0xe00(%rsp), %rsi
               	movl	-0xd8(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0xba0(%rsp), %rax
               	movups	0xe00(%rsp), %xmm0
               	movups	%xmm0, 0xba0(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x780(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x4, %edx
               	movq	%rdx, %rcx
               	movq	%rbx, %r9
               	movq	%rsi, %r8
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %r9
               	leaq	-0x80(%rbp), %rax
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x160(%rsp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x180(%rsp), %rdi
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x180(%rsp), %r9
               	movl	$0x8, %edx
               	leaq	0x600(%rsp), %rdi
               	leaq	0x160(%rsp), %rax
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %rsi
               	leaq	(%rsp), %rcx
               	subq	$0x60, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0x600(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x80(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movq	%rdx, %r8
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rcx
               	addq	$0x40, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x790(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	movups	0x720(%rsp), %xmm0
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x700(%rsp), %rdx
               	movups	0x710(%rsp), %xmm1
               	leaq	0xe30(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xe40(%rsp), %rdx
               	movups	%xmm0, 0xe40(%rsp)
               	movups	%xmm1, 0xe50(%rsp)
               	leaq	0xe60(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xe70(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movq	(%rdx,%rax,8), %rsi
               	movq	%rsi, -0xd0(%rbp)
               	leaq	0xe50(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xd0(%rbp), %rsi
               	leaq	0xe70(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	$0x3, %rdi
               	addq	%rcx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0xe60(%rsp), %rsi
               	movq	-0xd0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0xbc0(%rsp), %rax
               	movups	0xe60(%rsp), %xmm0
               	movups	%xmm0, 0xbc0(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x790(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movq	%rsi, %rcx
               	movq	%rbx, %r9
               	movq	%rdx, %r8
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %r9
               	leaq	-0x80(%rbp), %rax
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x160(%rsp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x180(%rsp), %rdi
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x180(%rsp), %r9
               	movl	$0x8, %edx
               	leaq	0x640(%rsp), %rdi
               	leaq	0x160(%rsp), %rax
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %rsi
               	leaq	0x700(%rsp), %rcx
               	subq	$0x40, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rcx, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x640(%rsp), %rax
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0xa0(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	movl	$0x8, %ecx
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x4, %edx
               	movq	%rcx, %r8
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x720(%rsp), %rsi
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rdx
               	addq	$0x40, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x730(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rdi
               	leaq	0xea0(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xeb0(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xec0(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xea0(%rsp), %rcx
               	leaq	0xed0(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xee0(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xef0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xf00(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0xed0(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0xc8(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xc8(%rbp), %rsi
               	leaq	0xf00(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	shlq	$0x3, %rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0xef0(%rsp), %rsi
               	movl	-0xc8(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0xbe0(%rsp), %rax
               	movups	0xef0(%rsp), %xmm0
               	movups	%xmm0, 0xbe0(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x730(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %ecx
               	movq	%rsi, %rdx
               	movq	%rbx, %r9
               	movq	%rcx, %r8
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %r9
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%r9)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rdx
               	addq	$0x40, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %rax
               	movl	$0x8, %esi
               	subq	$0x20, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rcx, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xc00(%rsp)
               	leaq	0xc00(%rsp), %rax
               	leaq	0x730(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x730(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movq	%rdx, %rcx
               	movq	%rbx, %r9
               	movq	%rdx, %r8
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x720(%rsp), %rsi
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rdx
               	addq	$0x40, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x730(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rdi
               	leaq	0xf40(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xf50(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xf60(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xf40(%rsp), %rcx
               	leaq	0xf70(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xf80(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xf90(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xfa0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0xf70(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	%rsi, -0xc0(%rbp)
               	movq	(%rcx,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xc0(%rbp), %rsi
               	leaq	0xfa0(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	shlq	$0x3, %rdi
               	addq	%rdx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0xf90(%rsp), %rsi
               	movq	-0xc0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0xc20(%rsp), %rax
               	movups	0xf90(%rsp), %xmm0
               	movups	%xmm0, 0xc20(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x730(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movq	%rdx, %rcx
               	movq	%rbx, %r9
               	movq	%rdx, %r8
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %r9
               	leaq	-0x80(%rbp), %rax
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x680(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	movl	$0x8, %edx
               	subq	$0x60, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0x680(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x60(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x4, %edx
               	movl	$0x8, %ecx
               	movq	%rcx, %r8
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rcx
               	addq	$0x40, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x780(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	movups	0x720(%rsp), %xmm0
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x700(%rsp), %rdx
               	movups	0x710(%rsp), %xmm1
               	leaq	0xfe0(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xff0(%rsp), %rdx
               	movups	%xmm0, 0xff0(%rsp)
               	movups	%xmm1, 0x1000(%rsp)
               	leaq	0x1010(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x1020(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movl	(%rdx,%rax,4), %esi
               	movl	%esi, -0xb8(%rbp)
               	leaq	0x1000(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xb8(%rbp), %rsi
               	leaq	0x1020(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	shlq	$0x3, %rdi
               	addq	%rcx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0x1010(%rsp), %rsi
               	movl	-0xb8(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0xc40(%rsp), %rax
               	movups	0x1010(%rsp), %xmm0
               	movups	%xmm0, 0xc40(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x780(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %ecx
               	movq	%rsi, %rdx
               	movq	%rbx, %r9
               	movq	%rcx, %r8
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rcx
               	addq	$0x40, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x160(%rsp), %r9
               	movups	0x720(%rsp), %xmm0
               	movups	%xmm0, 0x160(%rsp)
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %rax
               	movups	0x710(%rsp), %xmm0
               	movups	%xmm0, 0x180(%rsp)
               	leaq	0x180(%rsp), %rcx
               	movl	$0x8, %esi
               	subq	$0x20, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rcx, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xc60(%rsp)
               	leaq	0xc60(%rsp), %rax
               	leaq	0x780(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x780(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x8, %edx
               	movq	%rdx, %rcx
               	movq	%rbx, %r9
               	movq	%rdx, %r8
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	leaq	-0x80(%rbp), %rcx
               	addq	$0x40, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x790(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	movups	0x720(%rsp), %xmm0
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x700(%rsp), %rdx
               	movups	0x710(%rsp), %xmm1
               	leaq	0x1050(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x1060(%rsp), %rdx
               	movups	%xmm0, 0x1060(%rsp)
               	movups	%xmm1, 0x1070(%rsp)
               	leaq	0x1080(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x1090(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movq	(%rdx,%rax,8), %rsi
               	movq	%rsi, -0xb0(%rbp)
               	leaq	0x1070(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xb0(%rbp), %rsi
               	leaq	0x1090(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	shlq	$0x3, %rdi
               	addq	%rcx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0x1080(%rsp), %rsi
               	movq	-0xb0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0xc80(%rsp), %rax
               	movups	0x1080(%rsp), %xmm0
               	movups	%xmm0, 0xc80(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x790(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0x8, %edx
               	movq	%rdx, %rcx
               	movq	%rbx, %r9
               	movq	%rdx, %r8
               	callq	<addr>
               	leaq	0x700(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x710(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x720(%rsp), %rcx
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %r9
               	leaq	-0x80(%rbp), %rax
               	addq	$0x40, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x160(%rsp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x180(%rsp), %rdi
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x180(%rsp), %r9
               	movl	$0x8, %edx
               	leaq	0x6c0(%rsp), %rdi
               	leaq	0x160(%rsp), %rax
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x200(%rcx), %rsi
               	leaq	(%rsp), %rcx
               	subq	$0x60, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x50(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x58(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0x6c0(%rsp), %rax
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0xa0(%rsp), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	orq	%rax, %r12
               	movq	%r12, %rax
               	leaq	-0xf0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	0x6e0(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	(%rsp), %r9
               	movl	$0x8, %edx
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x6e0(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rcx
               	leaq	0xe80(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xe90(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	$-0x1, 0xe90(%rsp)
               	movq	$-0x1, 0xe98(%rsp)
               	leaq	0xf10(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xf20(%rsp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xf30(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xfb0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xf20(%rsp), %rcx
               	leaq	0xfc0(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xfd0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x1030(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x1040(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	leaq	0xfc0(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	%rsi, -0x90(%rbp)
               	movq	(%rcx,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0x90(%rbp), %rsi
               	leaq	0x1040(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	shlq	$0x3, %rdi
               	addq	%rdx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0x1030(%rsp), %rsi
               	movq	-0x90(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0x1030(%rsp), %xmm0
               	leaq	0xc90(%rsp), %rax
               	movups	%xmm0, 0xc90(%rsp)
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x8, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xc70(%rsp)
               	leaq	0xc70(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rcx
               	leaq	0x740(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x750(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0xffffffff, 0x750(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x754(%rsp) # imm = 0xFFFFFFFF
               	leaq	0xd10(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xd20(%rsp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xd30(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xda0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xd20(%rsp), %rcx
               	leaq	0xdb0(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xdc0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xe10(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xe20(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	leaq	0xdb0(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0x98(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x98(%rbp), %rsi
               	leaq	0xe20(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	shlq	$0x3, %rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0xe10(%rsp), %rsi
               	movl	-0x98(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0xe10(%rsp), %xmm0
               	leaq	0xc50(%rsp), %rax
               	movups	%xmm0, 0xc50(%rsp)
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	0x6a0(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	(%rsp), %r9
               	movl	$0x8, %edx
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x6a0(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rcx
               	leaq	0x1140(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x1150(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	$-0x1, 0x1150(%rsp)
               	movq	$-0x1, 0x1158(%rsp)
               	leaq	0x1160(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x1170(%rsp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x1180(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x1190(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x1170(%rsp), %rcx
               	leaq	0x11a0(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x11b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x11c0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x11d0(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	leaq	0x11a0(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	%rsi, -0xa0(%rbp)
               	movq	(%rcx,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xa0(%rbp), %rsi
               	leaq	0x11d0(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	shlq	$0x3, %rdi
               	addq	%rdx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0x11c0(%rsp), %rsi
               	movq	-0xa0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0x11c0(%rsp), %xmm0
               	leaq	0xc30(%rsp), %rax
               	movups	%xmm0, 0xc30(%rsp)
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x8, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xc10(%rsp)
               	leaq	0xc10(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rcx
               	leaq	0x10a0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x10b0(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0xffffffff, 0x10b0(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x10b4(%rsp) # imm = 0xFFFFFFFF
               	leaq	0x10c0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x10d0(%rsp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x10e0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x10f0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x10d0(%rsp), %rcx
               	leaq	0x1100(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x1110(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x1120(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x1130(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	leaq	0x1100(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0xa8(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xa8(%rbp), %rsi
               	leaq	0x1130(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	shlq	$0x3, %rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0x1120(%rsp), %rsi
               	movl	-0xa8(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0x1120(%rsp), %xmm0
               	leaq	0xbf0(%rsp), %rax
               	movups	%xmm0, 0xbf0(%rsp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	0x660(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	0x700(%rsp), %r9
               	movl	$0x8, %edx
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	0x660(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rcx
               	leaq	0x770(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xa0(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	$-0x1, 0xa0(%rsp)
               	movq	$-0x1, 0xa8(%rsp)
               	leaq	0x180(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x160(%rsp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x760(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x180(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x160(%rsp), %rcx
               	leaq	0x770(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x160(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x180(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	leaq	0x770(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	%rsi, -0x88(%rbp)
               	movq	(%rcx,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	leaq	0x180(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	$0x3, %rdi
               	addq	%rdx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0x160(%rsp), %rsi
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0x160(%rsp), %xmm0
               	leaq	0xbd0(%rsp), %rax
               	movups	%xmm0, 0xbd0(%rsp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	0x620(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	(%rsp), %r9
               	movl	$0x8, %edx
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x620(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xa0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movl	$0xffffffff, 0xa0(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xa4(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xa8(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xac(%rsp) # imm = 0xFFFFFFFF
               	leaq	0x180(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x160(%rsp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x770(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x180(%rsp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x160(%rsp), %rcx
               	leaq	0x80(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x160(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x180(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0x80(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0x88(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	leaq	0x180(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	$0x3, %rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0x160(%rsp), %rsi
               	movl	-0x88(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	0x160(%rsp), %xmm0
               	leaq	0xbb0(%rsp), %rax
               	movups	%xmm0, 0xbb0(%rsp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	0x5e0(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	0x700(%rsp), %r9
               	movl	$0x8, %edx
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	0x5e0(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rcx
               	leaq	0x80(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xa0(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	$-0x1, 0xa0(%rsp)
               	movq	$-0x1, 0xa8(%rsp)
               	leaq	0x180(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x160(%rsp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x770(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x180(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x160(%rsp), %rcx
               	leaq	0x80(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x160(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x180(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	leaq	0x80(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	%rsi, -0x88(%rbp)
               	movq	(%rcx,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	leaq	0x180(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	$0x3, %rdi
               	addq	%rdx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0x160(%rsp), %rsi
               	movq	-0x88(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0x160(%rsp), %xmm0
               	leaq	0xb90(%rsp), %rax
               	movups	%xmm0, 0xb90(%rsp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	0x5a0(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	(%rsp), %r9
               	movl	$0x8, %edx
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x5a0(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xa0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movl	$0xffffffff, 0xa0(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xa4(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xa8(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xac(%rsp) # imm = 0xFFFFFFFF
               	leaq	0x180(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x160(%rsp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x770(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x180(%rsp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x160(%rsp), %rcx
               	leaq	0x80(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x160(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x180(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0x80(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0x88(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	leaq	0x180(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	$0x3, %rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0x160(%rsp), %rsi
               	movl	-0x88(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	0x160(%rsp), %xmm0
               	leaq	0xb70(%rsp), %rax
               	movups	%xmm0, 0xb70(%rsp)
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	0x560(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	(%rsp), %r9
               	movl	$0x4, %edx
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x560(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rcx
               	leaq	0xe80(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xe90(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	$-0x1, 0xe90(%rsp)
               	movq	$-0x1, 0xe98(%rsp)
               	leaq	0xf10(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xf20(%rsp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xf30(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xfb0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xf20(%rsp), %rcx
               	leaq	0xfc0(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xfd0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x1030(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x1040(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	leaq	0xfc0(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	%rsi, -0x90(%rbp)
               	movq	(%rcx,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0x90(%rbp), %rsi
               	leaq	0x1040(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	shlq	$0x2, %rdi
               	addq	%rdx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0x1030(%rsp), %rsi
               	movq	-0x90(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0x1030(%rsp), %xmm0
               	leaq	0xb50(%rsp), %rax
               	movups	%xmm0, 0xb50(%rsp)
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x4, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xb30(%rsp)
               	leaq	0xb30(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rcx
               	leaq	0x740(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x750(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0xffffffff, 0x750(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x754(%rsp) # imm = 0xFFFFFFFF
               	leaq	0xd10(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xd20(%rsp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xd30(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xda0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xd20(%rsp), %rcx
               	leaq	0xdb0(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xdc0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xe10(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xe20(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	leaq	0xdb0(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0x98(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x98(%rbp), %rsi
               	leaq	0xe20(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	shlq	$0x2, %rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0xe10(%rsp), %rsi
               	movl	-0x98(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0xe10(%rsp), %xmm0
               	leaq	0xb10(%rsp), %rax
               	movups	%xmm0, 0xb10(%rsp)
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	0x520(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	(%rsp), %r9
               	movl	$0x4, %edx
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x520(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rcx
               	leaq	0x1140(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x1150(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	$-0x1, 0x1150(%rsp)
               	movq	$-0x1, 0x1158(%rsp)
               	leaq	0x1160(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x1170(%rsp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x1180(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x1190(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x1170(%rsp), %rcx
               	leaq	0x11a0(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x11b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x11c0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x11d0(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	leaq	0x11a0(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	%rsi, -0xa0(%rbp)
               	movq	(%rcx,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xa0(%rbp), %rsi
               	leaq	0x11d0(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	shlq	$0x2, %rdi
               	addq	%rdx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0x11c0(%rsp), %rsi
               	movq	-0xa0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0x11c0(%rsp), %xmm0
               	leaq	0xaf0(%rsp), %rax
               	movups	%xmm0, 0xaf0(%rsp)
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x4, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0xad0(%rsp)
               	leaq	0xad0(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rcx
               	leaq	0x10a0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x10b0(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0xffffffff, 0x10b0(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x10b4(%rsp) # imm = 0xFFFFFFFF
               	leaq	0x10c0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x10d0(%rsp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x10e0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x10f0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x10d0(%rsp), %rcx
               	leaq	0x1100(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x1110(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x1120(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x1130(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	leaq	0x1100(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0xa8(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xa8(%rbp), %rsi
               	leaq	0x1130(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	shlq	$0x2, %rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0x1120(%rsp), %rsi
               	movl	-0xa8(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0x1120(%rsp), %xmm0
               	leaq	0xab0(%rsp), %rax
               	movups	%xmm0, 0xab0(%rsp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	0x4e0(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	0x700(%rsp), %r9
               	movl	$0x4, %edx
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	0x4e0(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x700(%rsp), %rdx
               	leaq	0xe80(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xe90(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	$-0x1, 0xe90(%rsp)
               	movq	$-0x1, 0xe98(%rsp)
               	xorl	%esi, %esi
               	leaq	0xe30(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0xe90(%rsp), %xmm0
               	leaq	0xe40(%rsp), %rdx
               	movq	%rsi, %xmm14
               	movups	%xmm14, 0xe40(%rsp)
               	movups	%xmm0, 0xe50(%rsp)
               	leaq	0xe60(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xe30(%rsp), %rax
               	leaq	0xe70(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movq	(%rdx,%rax,8), %rsi
               	movq	%rsi, -0xd0(%rbp)
               	leaq	0xe50(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xd0(%rbp), %rsi
               	leaq	0xe70(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	$0x2, %rdi
               	addq	%rcx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0xe60(%rsp), %rsi
               	movq	-0xd0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0xe60(%rsp), %xmm0
               	leaq	0xa90(%rsp), %rax
               	movups	%xmm0, 0xa90(%rsp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	0x4a0(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	(%rsp), %r9
               	movl	$0x4, %edx
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x4a0(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x700(%rsp), %rax
               	leaq	0xe10(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0xe20(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0xffffffff, 0xe20(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xe24(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xe28(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xe2c(%rsp) # imm = 0xFFFFFFFF
               	xorl	%eax, %eax
               	leaq	0xdd0(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0xe20(%rsp), %xmm0
               	leaq	0xde0(%rsp), %rdx
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xde0(%rsp)
               	movups	%xmm0, 0xdf0(%rsp)
               	leaq	0xe00(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xdd0(%rsp), %rax
               	leaq	0x790(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movl	(%rdx,%rax,4), %esi
               	movl	%esi, -0xd8(%rbp)
               	leaq	0xdf0(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xd8(%rbp), %rsi
               	leaq	0x790(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	$0x2, %rdi
               	addq	%rcx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0xe00(%rsp), %rsi
               	movl	-0xd8(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	0xe00(%rsp), %xmm0
               	leaq	0xa70(%rsp), %rax
               	movups	%xmm0, 0xa70(%rsp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	0x460(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	0x700(%rsp), %r9
               	movl	$0x4, %edx
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	0x460(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rcx
               	leaq	0xda0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xdb0(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	$-0x1, 0xdb0(%rsp)
               	movq	$-0x1, 0xdb8(%rsp)
               	leaq	0xdc0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xd40(%rsp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xd50(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xd60(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xd40(%rsp), %rcx
               	leaq	0xd70(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xd80(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xd90(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x780(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	leaq	0xd70(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	%rsi, -0xe0(%rbp)
               	movq	(%rcx,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xe0(%rbp), %rsi
               	leaq	0x780(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	$0x2, %rdi
               	addq	%rdx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0xd90(%rsp), %rsi
               	movq	-0xe0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0xd90(%rsp), %xmm0
               	leaq	0xa50(%rsp), %rax
               	movups	%xmm0, 0xa50(%rsp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	0x420(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	(%rsp), %r9
               	movl	$0x4, %edx
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x420(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rax
               	leaq	0xd10(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xd20(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movl	$0xffffffff, 0xd20(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xd24(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xd28(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xd2c(%rsp) # imm = 0xFFFFFFFF
               	leaq	0xd30(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xca0(%rsp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xcb0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xcc0(%rsp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xca0(%rsp), %rcx
               	leaq	0xcd0(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xce0(%rsp), %rcx
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xcf0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xd00(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0xcd0(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0x88(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	leaq	0xd00(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	$0x2, %rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0xcf0(%rsp), %rsi
               	movl	-0x88(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	0xcf0(%rsp), %xmm0
               	leaq	0xa30(%rsp), %rax
               	movups	%xmm0, 0xa30(%rsp)
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	0x3e0(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	(%rsp), %r9
               	movl	$0x2, %edx
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x3e0(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x700(%rsp), %rdx
               	leaq	0x760(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x770(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	$-0x1, 0x770(%rsp)
               	movq	$-0x1, 0x778(%rsp)
               	xorl	%esi, %esi
               	leaq	0x1050(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x770(%rsp), %xmm0
               	leaq	0x1060(%rsp), %rdx
               	movq	%rsi, %xmm14
               	movups	%xmm14, 0x1060(%rsp)
               	movups	%xmm0, 0x1070(%rsp)
               	leaq	0x1080(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x1050(%rsp), %rax
               	leaq	0x1090(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movq	(%rdx,%rax,8), %rsi
               	movq	%rsi, -0xb0(%rbp)
               	leaq	0x1070(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xb0(%rbp), %rsi
               	leaq	0x1090(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	shlq	%rdi
               	addq	%rcx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0x1080(%rsp), %rsi
               	movq	-0xb0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0x1080(%rsp), %xmm0
               	leaq	0xa10(%rsp), %rax
               	movups	%xmm0, 0xa10(%rsp)
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x2, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x9f0(%rsp)
               	leaq	0x9f0(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x700(%rsp), %rdx
               	leaq	0x1030(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x1040(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0xffffffff, 0x1040(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x1044(%rsp) # imm = 0xFFFFFFFF
               	xorl	%esi, %esi
               	leaq	0xfe0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x1040(%rsp), %xmm0
               	leaq	0xff0(%rsp), %rdx
               	movq	%rsi, %xmm14
               	movups	%xmm14, 0xff0(%rsp)
               	movups	%xmm0, 0x1000(%rsp)
               	leaq	0x1010(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xfe0(%rsp), %rax
               	leaq	0x1020(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movl	(%rdx,%rax,4), %esi
               	movl	%esi, -0xb8(%rbp)
               	leaq	0x1000(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xb8(%rbp), %rsi
               	leaq	0x1020(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	shlq	%rdi
               	addq	%rcx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0x1010(%rsp), %rsi
               	movl	-0xb8(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0x1010(%rsp), %xmm0
               	leaq	0x9d0(%rsp), %rax
               	movups	%xmm0, 0x9d0(%rsp)
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	0x3a0(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	(%rsp), %r9
               	movl	$0x2, %edx
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x3a0(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rcx
               	leaq	0xfb0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xfc0(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	$-0x1, 0xfc0(%rsp)
               	movq	$-0x1, 0xfc8(%rsp)
               	leaq	0xfd0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xf40(%rsp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xf50(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xf60(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xf40(%rsp), %rcx
               	leaq	0xf70(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xf80(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xf90(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xfa0(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	leaq	0xf70(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	%rsi, -0xc0(%rbp)
               	movq	(%rcx,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xc0(%rbp), %rsi
               	leaq	0xfa0(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	shlq	%rdi
               	addq	%rdx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0xf90(%rsp), %rsi
               	movq	-0xc0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0xf90(%rsp), %xmm0
               	leaq	0x9b0(%rsp), %rax
               	movups	%xmm0, 0x9b0(%rsp)
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x2, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x990(%rsp)
               	leaq	0x990(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rcx
               	leaq	0xf10(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xf20(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0xffffffff, 0xf20(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xf24(%rsp) # imm = 0xFFFFFFFF
               	leaq	0xf30(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xea0(%rsp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xeb0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xec0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xea0(%rsp), %rcx
               	leaq	0xed0(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xee0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xef0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xf00(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	leaq	0xed0(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0xc8(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xc8(%rbp), %rsi
               	leaq	0xf00(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	shlq	%rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0xef0(%rsp), %rsi
               	movl	-0xc8(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0xef0(%rsp), %xmm0
               	leaq	0x970(%rsp), %rax
               	movups	%xmm0, 0x970(%rsp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	0x360(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	0x700(%rsp), %r9
               	movl	$0x2, %edx
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	0x360(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x700(%rsp), %rdx
               	leaq	0xe80(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xe90(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	$-0x1, 0xe90(%rsp)
               	movq	$-0x1, 0xe98(%rsp)
               	xorl	%esi, %esi
               	leaq	0xe30(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0xe90(%rsp), %xmm0
               	leaq	0xe40(%rsp), %rdx
               	movq	%rsi, %xmm14
               	movups	%xmm14, 0xe40(%rsp)
               	movups	%xmm0, 0xe50(%rsp)
               	leaq	0xe60(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xe30(%rsp), %rax
               	leaq	0xe70(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movq	(%rdx,%rax,8), %rsi
               	movq	%rsi, -0xd0(%rbp)
               	leaq	0xe50(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xd0(%rbp), %rsi
               	leaq	0xe70(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	%rdi
               	addq	%rcx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0xe60(%rsp), %rsi
               	movq	-0xd0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0xe60(%rsp), %xmm0
               	leaq	0x950(%rsp), %rax
               	movups	%xmm0, 0x950(%rsp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	0x320(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	(%rsp), %r9
               	movl	$0x2, %edx
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x320(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x700(%rsp), %rax
               	leaq	0xe10(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0xe20(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0xffffffff, 0xe20(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xe24(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xe28(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xe2c(%rsp) # imm = 0xFFFFFFFF
               	xorl	%eax, %eax
               	leaq	0xdd0(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0xe20(%rsp), %xmm0
               	leaq	0xde0(%rsp), %rdx
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xde0(%rsp)
               	movups	%xmm0, 0xdf0(%rsp)
               	leaq	0xe00(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xdd0(%rsp), %rax
               	leaq	0x790(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movl	(%rdx,%rax,4), %esi
               	movl	%esi, -0xd8(%rbp)
               	leaq	0xdf0(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xd8(%rbp), %rsi
               	leaq	0x790(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	%rdi
               	addq	%rcx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0xe00(%rsp), %rsi
               	movl	-0xd8(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	0xe00(%rsp), %xmm0
               	leaq	0x930(%rsp), %rax
               	movups	%xmm0, 0x930(%rsp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	0x2e0(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	0x700(%rsp), %r9
               	movl	$0x2, %edx
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	0x2e0(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rcx
               	leaq	0xda0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xdb0(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	$-0x1, 0xdb0(%rsp)
               	movq	$-0x1, 0xdb8(%rsp)
               	leaq	0xdc0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xd40(%rsp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xd50(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xd60(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xd40(%rsp), %rcx
               	leaq	0xd70(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xd80(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xd90(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x780(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	leaq	0xd70(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	%rsi, -0xe0(%rbp)
               	movq	(%rcx,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xe0(%rbp), %rsi
               	leaq	0x780(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	%rdi
               	addq	%rdx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0xd90(%rsp), %rsi
               	movq	-0xe0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0xd90(%rsp), %xmm0
               	leaq	0x910(%rsp), %rax
               	movups	%xmm0, 0x910(%rsp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	0x2a0(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	(%rsp), %r9
               	movl	$0x2, %edx
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x2a0(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rax
               	leaq	0xd10(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xd20(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movl	$0xffffffff, 0xd20(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xd24(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xd28(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xd2c(%rsp) # imm = 0xFFFFFFFF
               	leaq	0xd30(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xca0(%rsp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xcb0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xcc0(%rsp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xca0(%rsp), %rcx
               	leaq	0xcd0(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xce0(%rsp), %rcx
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xcf0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xd00(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0xcd0(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0x88(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	leaq	0xd00(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	%rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0xcf0(%rsp), %rsi
               	movl	-0x88(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	0xcf0(%rsp), %xmm0
               	leaq	0x8f0(%rsp), %rax
               	movups	%xmm0, 0x8f0(%rsp)
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	0x260(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	(%rsp), %r9
               	movl	$0x1, %edx
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x260(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x700(%rsp), %rdx
               	leaq	0x760(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x770(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	$-0x1, 0x770(%rsp)
               	movq	$-0x1, 0x778(%rsp)
               	xorl	%esi, %esi
               	leaq	0x1050(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x770(%rsp), %xmm0
               	leaq	0x1060(%rsp), %rdx
               	movq	%rsi, %xmm14
               	movups	%xmm14, 0x1060(%rsp)
               	movups	%xmm0, 0x1070(%rsp)
               	leaq	0x1080(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x1050(%rsp), %rax
               	leaq	0x1090(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movq	(%rdx,%rax,8), %rsi
               	movq	%rsi, -0xb0(%rbp)
               	leaq	0x1070(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xb0(%rbp), %rsi
               	leaq	0x1090(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	addq	%rcx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0x1080(%rsp), %rsi
               	movq	-0xb0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0x1080(%rsp), %xmm0
               	leaq	0x8d0(%rsp), %rax
               	movups	%xmm0, 0x8d0(%rsp)
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x1, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x8b0(%rsp)
               	leaq	0x8b0(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x700(%rsp), %rdx
               	leaq	0x1030(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x1040(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0xffffffff, 0x1040(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x1044(%rsp) # imm = 0xFFFFFFFF
               	xorl	%esi, %esi
               	leaq	0xfe0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x1040(%rsp), %xmm0
               	leaq	0xff0(%rsp), %rdx
               	movq	%rsi, %xmm14
               	movups	%xmm14, 0xff0(%rsp)
               	movups	%xmm0, 0x1000(%rsp)
               	leaq	0x1010(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xfe0(%rsp), %rax
               	leaq	0x1020(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movl	(%rdx,%rax,4), %esi
               	movl	%esi, -0xb8(%rbp)
               	leaq	0x1000(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xb8(%rbp), %rsi
               	leaq	0x1020(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	addq	%rcx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0x1010(%rsp), %rsi
               	movl	-0xb8(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0x1010(%rsp), %xmm0
               	leaq	0x890(%rsp), %rax
               	movups	%xmm0, 0x890(%rsp)
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	0x220(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	(%rsp), %r9
               	movl	$0x1, %edx
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x220(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rcx
               	leaq	0xfb0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xfc0(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	$-0x1, 0xfc0(%rsp)
               	movq	$-0x1, 0xfc8(%rsp)
               	leaq	0xfd0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xf40(%rsp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xf50(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xf60(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xf40(%rsp), %rcx
               	leaq	0xf70(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xf80(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xf90(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xfa0(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	leaq	0xf70(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	%rsi, -0xc0(%rbp)
               	movq	(%rcx,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xc0(%rbp), %rsi
               	leaq	0xfa0(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	addq	%rdx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0xf90(%rsp), %rsi
               	movq	-0xc0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0xf90(%rsp), %xmm0
               	leaq	0x870(%rsp), %rax
               	movups	%xmm0, 0x870(%rsp)
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x1, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x850(%rsp)
               	leaq	0x850(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rcx
               	leaq	0xf10(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xf20(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0xffffffff, 0xf20(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xf24(%rsp) # imm = 0xFFFFFFFF
               	leaq	0xf30(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xea0(%rsp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xeb0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xec0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xea0(%rsp), %rcx
               	leaq	0xed0(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xee0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xef0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xf00(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	leaq	0xed0(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0xc8(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xc8(%rbp), %rsi
               	leaq	0xf00(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0xef0(%rsp), %rsi
               	movl	-0xc8(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0xef0(%rsp), %xmm0
               	leaq	0x830(%rsp), %rax
               	movups	%xmm0, 0x830(%rsp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	0x1e0(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	0x700(%rsp), %r9
               	movl	$0x1, %edx
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	0x1e0(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x700(%rsp), %rdx
               	leaq	0xe80(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xe90(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	$-0x1, 0xe90(%rsp)
               	movq	$-0x1, 0xe98(%rsp)
               	xorl	%esi, %esi
               	leaq	0xe30(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0xe90(%rsp), %xmm0
               	leaq	0xe40(%rsp), %rdx
               	movq	%rsi, %xmm14
               	movups	%xmm14, 0xe40(%rsp)
               	movups	%xmm0, 0xe50(%rsp)
               	leaq	0xe60(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xe30(%rsp), %rax
               	leaq	0xe70(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movq	(%rdx,%rax,8), %rsi
               	movq	%rsi, -0xd0(%rbp)
               	leaq	0xe50(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xd0(%rbp), %rsi
               	leaq	0xe70(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	addq	%rcx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0xe60(%rsp), %rsi
               	movq	-0xd0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0xe60(%rsp), %xmm0
               	leaq	0x810(%rsp), %rax
               	movups	%xmm0, 0x810(%rsp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	0x1a0(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	(%rsp), %r9
               	movl	$0x1, %edx
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x1a0(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x700(%rsp), %rax
               	leaq	0xe10(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0xe20(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0xffffffff, 0xe20(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xe24(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xe28(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xe2c(%rsp) # imm = 0xFFFFFFFF
               	xorl	%eax, %eax
               	leaq	0xdd0(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0xe20(%rsp), %xmm0
               	leaq	0xde0(%rsp), %rdx
               	movq	%rax, %xmm14
               	movups	%xmm14, 0xde0(%rsp)
               	movups	%xmm0, 0xdf0(%rsp)
               	leaq	0xe00(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xdd0(%rsp), %rax
               	leaq	0x790(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movl	(%rdx,%rax,4), %esi
               	movl	%esi, -0xd8(%rbp)
               	leaq	0xdf0(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xd8(%rbp), %rsi
               	leaq	0x790(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	addq	%rcx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0xe00(%rsp), %rsi
               	movl	-0xd8(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	0xe00(%rsp), %xmm0
               	leaq	0x7f0(%rsp), %rax
               	movups	%xmm0, 0x7f0(%rsp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	0x120(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	0x700(%rsp), %r9
               	movl	$0x1, %edx
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	0x120(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rcx
               	leaq	0xda0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xdb0(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	$-0x1, 0xdb0(%rsp)
               	movq	$-0x1, 0xdb8(%rsp)
               	leaq	0xdc0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xd40(%rsp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xd50(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xd60(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xd40(%rsp), %rcx
               	leaq	0xd70(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xd80(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xd90(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x780(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	leaq	0xd70(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	%rsi, -0xe0(%rbp)
               	movq	(%rcx,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xe0(%rbp), %rsi
               	leaq	0x780(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	addq	%rdx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0xd90(%rsp), %rsi
               	movq	-0xe0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0xd90(%rsp), %xmm0
               	leaq	0x7d0(%rsp), %rax
               	movups	%xmm0, 0x7d0(%rsp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	0xe0(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	(%rsp), %r9
               	movl	$0x1, %edx
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0xe0(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %r12d
               	jmp	<addr>
               	xorl	%r12d, %r12d
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x700(%rsp), %rax
               	leaq	0xd10(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xd20(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movl	$0xffffffff, 0xd20(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xd24(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xd28(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xd2c(%rsp) # imm = 0xFFFFFFFF
               	leaq	0xd30(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xca0(%rsp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xcb0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xcc0(%rsp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xca0(%rsp), %rcx
               	leaq	0xcd0(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xce0(%rsp), %rcx
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xcf0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xd00(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0xcd0(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0x88(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x88(%rbp), %rsi
               	leaq	0xd00(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0xcf0(%rsp), %rsi
               	movl	-0x88(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	0xcf0(%rsp), %xmm0
               	leaq	0x7b0(%rsp), %rax
               	movups	%xmm0, 0x7b0(%rsp)
               	jmp	<addr>

<check_masked_moves>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x108, %rsp            # imm = 0x108
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x320, %rsp            # imm = 0x320
               	andq	$-0x20, %rsp
               	leaq	-0xa0(%rbp), %rdx
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rdi
               	shrq	$0xc, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rdi
               	shlq	$0x19, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rdi
               	shrq	$0x1b, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, <rip> # <addr>
               	imulq	%rsi, %rcx
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	-0x80(%rbp), %rdx
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rdi
               	shrq	$0xc, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rdi
               	shlq	$0x19, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rdi
               	shrq	$0x1b, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, <rip> # <addr>
               	imulq	%rsi, %rcx
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	-0x60(%rbp), %rdx
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rdi
               	shrq	$0xc, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rdi
               	shlq	$0x19, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rdi
               	shrq	$0x1b, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, <rip> # <addr>
               	imulq	%rsi, %rcx
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	xorl	%r15d, %r15d
               	movl	$0x4, %ebx
               	movl	$0x10, %r14d
               	xorl	%r12d, %r12d
               	movl	%r14d, %eax
               	cltd
               	idivl	%ebx
               	cmpl	%eax, %r12d
               	jge	<addr>
               	leaq	-0x40(%rbp), %r13
               	leaq	-0x60(%rbp), %rcx
               	movq	%rbx, %rax
               	imulq	%r12, %rax
               	leaq	(%rax,%rbx), %rdx
               	decq	%rdx
               	movslq	%edx, %rdx
               	movzbq	(%rcx,%rdx), %rcx
               	testb	$-0x80, %cl
               	je	<addr>
               	leaq	-0xa0(%rbp), %rcx
               	movq	$0x0, -0xe8(%rbp)
               	leaq	-0xe8(%rbp), %rdi
               	movslq	%eax, %rax
               	leaq	(%rcx,%rax), %rsi
               	movq	%rbx, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	-0xe8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	cmpl	%ebx, %ecx
               	jge	<addr>
               	movq	%rbx, %rsi
               	imulq	%r12, %rsi
               	addq	%rcx, %rsi
               	movslq	%esi, %rsi
               	movq	%rcx, %rdi
               	shlq	$0x3, %rdi
               	movslq	%edi, %rdi
               	shrxq	%rdi, %rdx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%r13,%rsi)
               	incq	%rcx
               	cmpl	%ebx, %ecx
               	jge	<addr>
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	incq	%r12
               	movl	%r14d, %eax
               	cltd
               	idivl	%ebx
               	cmpl	%eax, %r12d
               	jl	<addr>
               	leaq	0x140(%rsp), %rax
               	leaq	-0x60(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	(%rsp), %r9
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	0x150(%rsp), %rdx
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	cmpl	$0x4, %ebx
               	jne	<addr>
               	cmpl	$0x10, %r14d
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rcx
               	leaq	0x170(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x180(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movl	$0x0, -0xe0(%rbp)
               	leaq	0x180(%rsp), %rdx
               	movl	(%rdx,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0xe0(%rbp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	addq	%rcx, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	leaq	0x190(%rsp), %rdx
               	movl	-0xe0(%rbp), %esi
               	movl	%esi, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	0x190(%rsp), %xmm0
               	movups	%xmm0, 0x160(%rsp)
               	leaq	-0xa0(%rbp), %rdx
               	leaq	0x140(%rsp), %rcx
               	leaq	0x1a0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x1b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movl	%ecx, -0xd8(%rbp)
               	leaq	0x1b0(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xd8(%rbp), %rsi
               	movq	%rax, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0x1c0(%rsp), %rsi
               	movl	-0xd8(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	0x1c0(%rsp), %xmm0
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x160(%rsp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %r15
               	xorl	%r12d, %r12d
               	movl	%r14d, %eax
               	cltd
               	idivl	%ebx
               	cmpl	%eax, %r12d
               	jge	<addr>
               	leaq	-0x40(%rbp), %r13
               	leaq	-0x60(%rbp), %rax
               	movq	%rbx, %rcx
               	imulq	%r12, %rcx
               	leaq	(%rcx,%rbx), %rdx
               	decq	%rdx
               	movslq	%edx, %rdx
               	movzbq	(%rax,%rdx), %rax
               	testb	$-0x80, %al
               	je	<addr>
               	leaq	-0x80(%rbp), %rax
               	movq	$0x0, -0xe8(%rbp)
               	leaq	-0xe8(%rbp), %rdi
               	movslq	%ecx, %rcx
               	leaq	(%rax,%rcx), %rsi
               	movq	%rbx, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	-0xe8(%rbp), %rdx
               	xorl	%ecx, %ecx
               	cmpl	%ebx, %ecx
               	jge	<addr>
               	movq	%rbx, %rsi
               	imulq	%r12, %rsi
               	addq	%rcx, %rsi
               	movslq	%esi, %rsi
               	movq	%rcx, %rdi
               	shlq	$0x3, %rdi
               	movslq	%edi, %rdi
               	shrxq	%rdi, %rdx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%r13,%rsi)
               	incq	%rcx
               	cmpl	%ebx, %ecx
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0xa0(%rbp), %rax
               	jmp	<addr>
               	incq	%r12
               	movl	%r14d, %eax
               	cltd
               	idivl	%ebx
               	cmpl	%eax, %r12d
               	jl	<addr>
               	xorl	%r12d, %r12d
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0xa0(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	cmpl	$0x4, %ebx
               	jne	<addr>
               	cmpl	$0x10, %r14d
               	jne	<addr>
               	testq	%r12, %r12
               	je	<addr>
               	leaq	0x140(%rsp), %rcx
               	movups	0x150(%rsp), %xmm0
               	leaq	0x230(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x240(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm0, 0x250(%rsp)
               	xorl	%ecx, %ecx
               	leaq	0x240(%rsp), %rsi
               	movl	(%rsi,%rcx,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	0x250(%rsp), %rdi
               	movq	%rcx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rdi
               	movl	(%rdi), %edi
               	movl	%edi, -0xc0(%rbp)
               	addq	%rdx, %rsi
               	leaq	-0xc0(%rbp), %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movq	%r14, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	leaq	(%rax,%r14), %rdi
               	leaq	-0xa0(%rbp), %rax
               	leaq	(%rax,%r14), %rsi
               	movl	$0x20, %edx
               	subq	%r14, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	leaq	0x140(%rsp), %rax
               	leaq	0x150(%rsp), %rcx
               	leaq	0x260(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x270(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x260(%rsp), %rcx
               	leaq	0x280(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x290(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%ecx, %ecx
               	leaq	0x280(%rsp), %rsi
               	movl	(%rsi,%rcx,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	0x290(%rsp), %rdi
               	movq	%rcx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rdi
               	movl	(%rdi), %edi
               	movl	%edi, -0xb8(%rbp)
               	addq	%rdx, %rsi
               	leaq	-0xb8(%rbp), %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jge	<addr>
               	jmp	<addr>
               	cmpl	$0x4, %ebx
               	jne	<addr>
               	testq	%r12, %r12
               	je	<addr>
               	leaq	-0x20(%rbp), %r13
               	leaq	(%rsp), %r10
               	movq	%r10, -0xf8(%rbp)
               	leaq	0x100(%rsp), %rdi
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x100(%rsp), %r9
               	subq	$0x40, %rsp
               	movq	-0xf8(%rbp), %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%r13, %rdi
               	callq	<addr>
               	addq	$0x40, %rsp
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	jmp	<addr>
               	cmpl	$0x10, %r14d
               	jne	<addr>
               	testq	%r12, %r12
               	je	<addr>
               	leaq	-0x20(%rbp), %rsi
               	leaq	0x140(%rsp), %rcx
               	movups	0x150(%rsp), %xmm0
               	leaq	0x2a0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x2b0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm0, 0x2c0(%rsp)
               	xorl	%ecx, %ecx
               	leaq	0x2b0(%rsp), %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	0x2c0(%rsp), %rdi
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	movq	%rdi, -0xb0(%rbp)
               	addq	%rsi, %rdx
               	leaq	-0xb0(%rbp), %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rdx)
               	incq	%rcx
               	cmpl	$0x2, %ecx
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rsi
               	leaq	0x140(%rsp), %rax
               	leaq	0x150(%rsp), %rcx
               	leaq	0x2d0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x2e0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x2d0(%rsp), %rcx
               	leaq	0x2f0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x300(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%ecx, %ecx
               	leaq	0x2f0(%rsp), %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	0x300(%rsp), %rdi
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	movq	%rdi, -0xa8(%rbp)
               	addq	%rsi, %rdx
               	leaq	-0xa8(%rbp), %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rdx)
               	incq	%rcx
               	cmpl	$0x2, %ecx
               	jge	<addr>
               	jmp	<addr>
               	testq	%r12, %r12
               	je	<addr>
               	leaq	-0x20(%rbp), %r13
               	leaq	(%rsp), %r10
               	movq	%r10, -0xf8(%rbp)
               	leaq	0x120(%rsp), %rdi
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x120(%rsp), %r9
               	subq	$0x40, %rsp
               	movq	-0xf8(%rbp), %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%r13, %rdi
               	callq	<addr>
               	addq	$0x40, %rsp
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	jmp	<addr>
               	orq	%rcx, %r15
               	incq	%r12
               	cmpl	$0x2, %r12d
               	jge	<addr>
               	jmp	<addr>
               	cmpl	$0x4, %ebx
               	jne	<addr>
               	leaq	0x40(%rsp), %r12
               	leaq	0x80(%rsp), %rdi
               	leaq	-0xa0(%rbp), %rsi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x80(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r12)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r12)
               	leaq	0xa0(%rsp), %rdi
               	leaq	-0xa0(%rbp), %rsi
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0xa0(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x40(%rsp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %r15
               	jmp	<addr>
               	cmpl	$0x10, %r14d
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rcx
               	leaq	0x140(%rsp), %rdx
               	leaq	0x1d0(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x1e0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	movq	$0x0, -0xd0(%rbp)
               	leaq	0x1e0(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0xd0(%rbp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	addq	%rcx, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	leaq	0x1f0(%rsp), %rdx
               	movq	-0xd0(%rbp), %rsi
               	movq	%rsi, (%rdx,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0x1f0(%rsp), %xmm0
               	movups	%xmm0, 0x160(%rsp)
               	leaq	-0xa0(%rbp), %rdx
               	leaq	0x140(%rsp), %rcx
               	leaq	0x200(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x210(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movq	%rcx, -0xc8(%rbp)
               	leaq	0x210(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xc8(%rbp), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0x220(%rsp), %rsi
               	movq	-0xc8(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0x220(%rsp), %xmm0
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x160(%rsp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %r15
               	jmp	<addr>
               	leaq	0x40(%rsp), %r12
               	leaq	0xc0(%rsp), %rdi
               	leaq	-0xa0(%rbp), %rsi
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0xc0(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r12)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r12)
               	leaq	0xe0(%rsp), %rdi
               	leaq	-0xa0(%rbp), %rsi
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0xe0(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x40(%rsp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %r15
               	jmp	<addr>
               	addq	$0x10, %r14
               	cmpl	$0x20, %r14d
               	jle	<addr>
               	addq	$0x4, %rbx
               	cmpl	$0x8, %ebx
               	jle	<addr>
               	testq	%r15, %r15
               	je	<addr>
               	movl	$0x8, %eax
               	leaq	-0x130(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>

<check_lane_access>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0xc0, %rsp
               	andq	$-0x20, %rsp
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movw	%ax, -0x60(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movw	%ax, -0x5e(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movw	%ax, -0x5c(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movw	%ax, -0x5a(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movw	%ax, -0x58(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movw	%ax, -0x56(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movw	%ax, -0x54(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movw	%ax, -0x52(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movw	%ax, -0x50(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movw	%ax, -0x4e(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movw	%ax, -0x4c(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movw	%ax, -0x4a(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movw	%ax, -0x48(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movw	%ax, -0x46(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movw	%ax, -0x44(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movw	%ax, -0x42(%rbp)
               	leaq	-0x40(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movq	%rax, -0x40(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movq	%rax, -0x38(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movq	%rax, -0x30(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movq	%rax, -0x28(%rbp)
               	leaq	0xa0(%rsp), %rdi
               	movswq	-0x42(%rbp), %rsi
               	movswq	-0x44(%rbp), %rdx
               	movswq	-0x46(%rbp), %rcx
               	movswq	-0x48(%rbp), %r8
               	movswq	-0x4a(%rbp), %r9
               	movswq	-0x4c(%rbp), %rax
               	movswq	-0x4e(%rbp), %rbx
               	movswq	-0x50(%rbp), %r12
               	movswq	-0x52(%rbp), %r13
               	movswq	-0x54(%rbp), %r14
               	movswq	-0x56(%rbp), %r15
               	movswq	-0x58(%rbp), %r10
               	movq	%r10, -0x78(%rbp)
               	movswq	-0x5a(%rbp), %r10
               	movq	%r10, -0x80(%rbp)
               	movswq	-0x5c(%rbp), %r10
               	movq	%r10, -0x88(%rbp)
               	movswq	-0x5e(%rbp), %r10
               	movq	%r10, -0x90(%rbp)
               	movswq	-0x60(%rbp), %r10
               	movq	%r10, -0x98(%rbp)
               	subq	$0x60, %rsp
               	movq	%rax, (%rsp)
               	movq	%rbx, 0x8(%rsp)
               	movq	%r12, 0x10(%rsp)
               	movq	%r13, 0x18(%rsp)
               	movq	%r14, 0x20(%rsp)
               	movq	%r15, 0x28(%rsp)
               	movq	-0x78(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	-0x80(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x88(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	-0x90(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	-0x98(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0xa0(%rsp), %rax
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0xa0(%rsp), %rdi
               	movswq	-0x60(%rbp), %rsi
               	movswq	-0x5e(%rbp), %rdx
               	movswq	-0x5c(%rbp), %rcx
               	movswq	-0x5a(%rbp), %r8
               	movswq	-0x58(%rbp), %r9
               	movswq	-0x56(%rbp), %rax
               	movswq	-0x54(%rbp), %rbx
               	movswq	-0x52(%rbp), %r12
               	movswq	-0x50(%rbp), %r13
               	movswq	-0x4e(%rbp), %r14
               	movswq	-0x4c(%rbp), %r15
               	movswq	-0x4a(%rbp), %r10
               	movq	%r10, -0x78(%rbp)
               	movswq	-0x48(%rbp), %r10
               	movq	%r10, -0x80(%rbp)
               	movswq	-0x46(%rbp), %r10
               	movq	%r10, -0x88(%rbp)
               	movswq	-0x44(%rbp), %r10
               	movq	%r10, -0x90(%rbp)
               	movswq	-0x42(%rbp), %r10
               	movq	%r10, -0x98(%rbp)
               	subq	$0x60, %rsp
               	movq	%rax, (%rsp)
               	movq	%rbx, 0x8(%rsp)
               	movq	%r12, 0x10(%rsp)
               	movq	%r13, 0x18(%rsp)
               	movq	%r14, 0x20(%rsp)
               	movq	%r15, 0x28(%rsp)
               	movq	-0x78(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	-0x80(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x88(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	-0x90(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	-0x98(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	leaq	0xa0(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	(%rsp), %rdi
               	leaq	-0x60(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ebx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x20(%rsp), %rdi
               	leaq	-0x60(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	leaq	0xa0(%rsp), %rdi
               	movq	-0x40(%rbp), %rsi
               	movq	-0x38(%rbp), %rdx
               	movq	-0x30(%rbp), %rcx
               	movq	-0x28(%rbp), %r8
               	callq	<addr>
               	leaq	0xa0(%rsp), %rax
               	leaq	0x40(%rsp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	leaq	0x60(%rsp), %r9
               	leaq	-0x40(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	leaq	0x80(%rsp), %rcx
               	addq	$0x10, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xa0(%rsp), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rcx, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0xa0(%rsp), %rax
               	leaq	0x60(%rsp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	leaq	(%rsp), %r9
               	xorl	%edi, %edi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movswq	-0x60(%rbp), %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	cmpl	%ecx, %eax
               	movl	$0x1, %eax
               	jne	<addr>
               	leaq	(%rsp), %r9
               	movl	$0x9, %edi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movswq	-0x4e(%rbp), %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	cmpl	%ecx, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	(%rsp), %r9
               	movl	$0xf, %edi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movswq	-0x42(%rbp), %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	cmpl	%ecx, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %rbx
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x60(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movq	-0x40(%rbp), %rsi
               	movw	%si, -0x6(%rbp)
               	leaq	0xa0(%rsp), %rdi
               	leaq	(%rsp), %r9
               	movl	$0xd, %edx
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0xa0(%rsp), %rax
               	leaq	0x80(%rsp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	leaq	-0x68(%rbp), %rax
               	leaq	-0x40(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movl	-0x68(%rbp), %ecx
               	cmpl	%ecx, %eax
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rbx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	leaq	-0xd0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>

<check_transfers>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc8, %rsp
               	pushq	%rbx
               	subq	$0xc0, %rsp
               	andq	$-0x20, %rsp
               	leaq	-0xc0(%rbp), %rdx
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rdi
               	shrq	$0xc, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rdi
               	shlq	$0x19, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rdi
               	shrq	$0x1b, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, <rip> # <addr>
               	imulq	%rsi, %rcx
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	-0xa0(%rbp), %rdx
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rdi
               	shrq	$0xc, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rdi
               	shlq	$0x19, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rdi
               	shrq	$0x1b, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, <rip> # <addr>
               	imulq	%rsi, %rcx
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	-0x80(%rbp), %rax
               	leaq	-0xa0(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x10(%rax), %rdx
               	leaq	-0xc0(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0xa0(%rsp), %rdi
               	leaq	0x1(%rax), %rsi
               	leaq	0x3(%rcx), %rdx
               	callq	<addr>
               	leaq	0xa0(%rsp), %rax
               	leaq	(%rsp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	-0x60(%rbp), %rsi
               	leaq	-0xa0(%rbp), %rax
               	addq	$0x3, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x10(%rsi), %rax
               	leaq	-0xc0(%rbp), %rcx
               	incq	%rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	leaq	0xa0(%rsp), %rdi
               	leaq	-0xc0(%rbp), %rsi
               	leaq	-0xa0(%rbp), %rdx
               	callq	<addr>
               	leaq	0xa0(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0xa0(%rsp), %rdi
               	leaq	-0xc0(%rbp), %rsi
               	leaq	-0xa0(%rbp), %rdx
               	callq	<addr>
               	leaq	0xa0(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x20(%rsp), %rdi
               	leaq	-0x80(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x40(%rsp), %rdi
               	leaq	-0x80(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %rbx
               	leaq	-0x40(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x40(%rbp), %rax
               	leaq	0x21(%rax), %rdi
               	leaq	0x5(%rax), %rsi
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	-0x40(%rbp), %rax
               	leaq	0x5(%rax), %rdi
               	leaq	-0x60(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x40(%rbp), %rax
               	leaq	0x21(%rax), %rdi
               	leaq	-0x60(%rbp), %rax
               	leaq	0x10(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %rbx
               	leaq	-0x40(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x40(%rbp), %rsi
               	leaq	0x20(%rsi), %rdi
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	-0x40(%rbp), %rdi
               	leaq	-0x80(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x40(%rbp), %rax
               	leaq	0x20(%rax), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x10(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %rbx
               	leaq	-0x40(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x40(%rbp), %rsi
               	leaq	0x20(%rsi), %rdi
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	-0x40(%rbp), %rdi
               	leaq	-0x80(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x40(%rbp), %rax
               	leaq	0x20(%rax), %rdi
               	leaq	-0x80(%rbp), %rax
               	leaq	0x10(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %rbx
               	leaq	<rip>, %rax # <addr>
               	leaq	0x20(%rax), %rdi
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	<rip>, %rax # <addr>
               	movl	$0x20, %edx
               	leaq	0x20(%rax), %rdi
               	leaq	-0x60(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	leaq	0xa0(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x20(%rax), %rsi
               	callq	<addr>
               	leaq	0xa0(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0xa0(%rsp), %rdi
               	leaq	-0x80(%rbp), %rsi
               	callq	<addr>
               	leaq	0xa0(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x60(%rsp), %rdi
               	leaq	-0x60(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	-0x80(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %rbx
               	leaq	<rip>, %rdi # <addr>
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	<rip>, %rdi # <addr>
               	leaq	0x40(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	<rip>, %rdi # <addr>
               	leaq	-0x80(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	-0x80(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rbx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x20, %eax
               	leaq	-0xd0(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>

<check_tests>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x98, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x100, %rsp            # imm = 0x100
               	andq	$-0x20, %rsp
               	leaq	-0x40(%rbp), %rsi
               	movabsq	$0x2545f4914f6cdd1d, %rdx # imm = 0x2545F4914F6CDD1D
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rdi
               	shrq	$0xc, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rdi
               	shlq	$0x19, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rdi
               	shrq	$0x1b, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, <rip> # <addr>
               	imulq	%rdx, %rcx
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rcx
               	movabsq	$0x2545f4914f6cdd1d, %rdi # imm = 0x2545F4914F6CDD1D
               	xorl	%eax, %eax
               	movq	<rip>, %rdx # <addr>
               	movq	%rdx, %r8
               	shrq	$0xc, %r8
               	xorq	%r8, %rdx
               	movq	%rdx, <rip> # <addr>
               	movq	%rdx, %r8
               	shlq	$0x19, %r8
               	xorq	%r8, %rdx
               	movq	%rdx, <rip> # <addr>
               	movq	%rdx, %r8
               	shrq	$0x1b, %r8
               	xorq	%r8, %rdx
               	movq	%rdx, <rip> # <addr>
               	imulq	%rdi, %rdx
               	shrq	$0x18, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movabsq	$0x2545f4914f6cdd1d, %rdi # imm = 0x2545F4914F6CDD1D
               	movq	<rip>, %rdx # <addr>
               	movq	%rdx, %r8
               	shrq	$0xc, %r8
               	xorq	%r8, %rdx
               	movq	%rdx, <rip> # <addr>
               	movq	%rdx, %r8
               	shlq	$0x19, %r8
               	xorq	%r8, %rdx
               	movq	%rdx, <rip> # <addr>
               	movq	%rdx, %r8
               	shrq	$0x1b, %r8
               	xorq	%r8, %rdx
               	movq	%rdx, <rip> # <addr>
               	imulq	%rdi, %rdx
               	shrq	$0x3e, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movzbq	(%rcx,%rax), %rdx
               	movzbq	(%rsi,%rax), %r8
               	xorq	$-0x1, %r8
               	andq	$0xff, %r8
               	andq	%r8, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	xorl	%r10d, %r10d
               	movq	%r10, -0x90(%rbp)
               	leaq	-0x50(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %rax
               	movq	%rax, -0x50(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movq	%rax, -0x48(%rbp)
               	movq	-0x90(%rbp), %r11
               	movq	%r11, -0x70(%rbp)
               	movq	-0x90(%rbp), %rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x50(%rbp), %rcx
               	movq	%rax, %rdx
               	andq	$0x1, %rdx
               	movq	(%rcx,%rdx,8), %r14
               	sarq	%rax
               	movq	(%rcx,%rax,8), %r15
               	movl	$0x1, %ebx
               	xorl	%eax, %eax
               	movq	%rbx, %r12
               	movzbq	(%r14,%rax), %rcx
               	movzbq	(%r15,%rax), %rdx
               	movq	%rcx, %rsi
               	andq	%rdx, %rsi
               	testl	%esi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %r12
               	xorq	$-0x1, %rcx
               	andq	%rdx, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rbx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	(%rsp), %r9
               	movups	(%r14), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%r14), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	0x20(%rsp), %rax
               	movups	(%r15), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%r15), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	cmpl	%r12d, %eax
               	movl	$0x1, %eax
               	jne	<addr>
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	cmpl	%ebx, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	xorl	%ecx, %ecx
               	testl	%r12d, %r12d
               	jne	<addr>
               	testl	%ebx, %ebx
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpl	%ecx, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	-0x70(%rbp), %r10
               	orq	%rcx, %r10
               	movq	%r10, -0x70(%rbp)
               	movl	$0x4, %r10d
               	movq	%r10, -0x58(%rbp)
               	movl	$0x10, %r13d
               	movl	$0x1, %ebx
               	movq	-0x58(%rbp), %rax
               	decq	%rax
               	movq	%rbx, %r12
               	cmpl	%r13d, %eax
               	jge	<addr>
               	movzbq	(%r14,%rax), %rcx
               	movzbq	(%r15,%rax), %rdx
               	movq	%rcx, %rsi
               	andq	%rdx, %rsi
               	andq	$0x80, %rsi
               	testl	%esi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %r12
               	xorq	$-0x1, %rcx
               	andq	%rdx, %rcx
               	andq	$0x80, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rbx
               	addq	-0x58(%rbp), %rax
               	cmpl	%r13d, %eax
               	jl	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	cmpl	$0x10, %r13d
               	jne	<addr>
               	leaq	0xc0(%rsp), %rax
               	movups	(%r14), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xd0(%rsp), %rax
               	movups	(%r15), %xmm14
               	movups	%xmm14, (%rax)
               	movl	0xc0(%rsp), %eax
               	movl	0xc4(%rsp), %ecx
               	movl	0xc8(%rsp), %edx
               	movl	0xcc(%rsp), %esi
               	movl	0xd0(%rsp), %edi
               	movl	0xd4(%rsp), %r8d
               	movl	0xd8(%rsp), %r9d
               	movl	0xdc(%rsp), %r10d
               	movq	%r10, -0x60(%rbp)
               	movslq	%eax, %rax
               	movslq	%edi, %rdi
               	andq	%rdi, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movslq	%ecx, %rcx
               	movslq	%r8d, %rdi
               	andq	%rdi, %rcx
               	testq	%rcx, %rcx
               	setge	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movslq	%edx, %rcx
               	movslq	%r9d, %rdx
               	andq	%rdx, %rcx
               	testq	%rcx, %rcx
               	setge	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movslq	%esi, %rcx
               	movq	-0x60(%rbp), %rdx
               	movslq	%edx, %rdx
               	andq	%rdx, %rcx
               	testq	%rcx, %rcx
               	setge	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %r10
               	andq	%rcx, %r10
               	movq	%r10, -0x68(%rbp)
               	movl	0xc0(%rsp), %eax
               	movl	0xc4(%rsp), %ecx
               	movl	0xc8(%rsp), %edx
               	movl	0xcc(%rsp), %esi
               	movl	0xd0(%rsp), %edi
               	movl	0xd4(%rsp), %r8d
               	movl	0xd8(%rsp), %r9d
               	movl	0xdc(%rsp), %r10d
               	movq	%r10, -0x60(%rbp)
               	movslq	%eax, %rax
               	xorq	$-0x1, %rax
               	movslq	%edi, %rdi
               	andq	%rdi, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movslq	%ecx, %rcx
               	xorq	$-0x1, %rcx
               	movslq	%r8d, %rdi
               	andq	%rdi, %rcx
               	testq	%rcx, %rcx
               	setge	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movslq	%edx, %rcx
               	xorq	$-0x1, %rcx
               	movslq	%r9d, %rdx
               	andq	%rdx, %rcx
               	testq	%rcx, %rcx
               	setge	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movslq	%esi, %rcx
               	xorq	$-0x1, %rcx
               	movq	-0x60(%rbp), %rdx
               	movslq	%edx, %rdx
               	andq	%rdx, %rcx
               	testq	%rcx, %rcx
               	setge	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %r10
               	andq	%rcx, %r10
               	movq	%r10, -0x60(%rbp)
               	movl	0xc0(%rsp), %eax
               	movl	0xc4(%rsp), %esi
               	movl	0xc8(%rsp), %r8d
               	movl	0xcc(%rsp), %r10d
               	movq	%r10, -0x78(%rbp)
               	movl	0xd0(%rsp), %edx
               	movl	0xd4(%rsp), %edi
               	movl	0xd8(%rsp), %r9d
               	movl	0xdc(%rsp), %r10d
               	movq	%r10, -0x80(%rbp)
               	movslq	%eax, %rcx
               	movslq	%edx, %rdx
               	movq	%rcx, %rax
               	andq	%rdx, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movslq	%esi, %rsi
               	movslq	%edi, %rdi
               	movq	%rsi, %r10
               	andq	%rdi, %r10
               	movq	%r10, -0x88(%rbp)
               	movq	-0x88(%rbp), %r10
               	testq	%r10, %r10
               	setge	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x88(%rbp)
               	andq	-0x88(%rbp), %rax
               	movslq	%r8d, %r8
               	movslq	%r9d, %r9
               	movq	%r8, %r10
               	andq	%r9, %r10
               	movq	%r10, -0x88(%rbp)
               	movq	-0x88(%rbp), %r10
               	testq	%r10, %r10
               	setge	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x88(%rbp)
               	andq	-0x88(%rbp), %rax
               	movq	-0x78(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x78(%rbp)
               	movq	-0x80(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x80(%rbp)
               	movq	-0x78(%rbp), %r10
               	andq	-0x80(%rbp), %r10
               	movq	%r10, -0x88(%rbp)
               	movq	-0x88(%rbp), %r10
               	testq	%r10, %r10
               	setge	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x88(%rbp)
               	movq	%rax, %r10
               	andq	-0x88(%rbp), %r10
               	movq	%r10, -0x88(%rbp)
               	xorl	%eax, %eax
               	movq	-0x88(%rbp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	xorq	$-0x1, %rcx
               	andq	%rdx, %rcx
               	testq	%rcx, %rcx
               	setge	%al
               	movzbq	%al, %rax
               	xorq	$-0x1, %rsi
               	andq	%rdi, %rsi
               	testq	%rsi, %rsi
               	setge	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	xorq	$-0x1, %r8
               	andq	%r9, %r8
               	testq	%r8, %r8
               	setge	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movq	-0x78(%rbp), %rcx
               	xorq	$-0x1, %rcx
               	andq	-0x80(%rbp), %rcx
               	testq	%rcx, %rcx
               	setge	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	-0x68(%rbp), %rdx
               	cmpl	%r12d, %edx
               	movl	$0x1, %ecx
               	jne	<addr>
               	movq	-0x60(%rbp), %rcx
               	cmpl	%ebx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %edx
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorl	%ecx, %ecx
               	testl	%r12d, %r12d
               	jne	<addr>
               	testl	%ebx, %ebx
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpl	%ecx, %eax
               	setne	%dl
               	movzbq	%dl, %rdx
               	jmp	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	leaq	0x40(%rsp), %rax
               	movups	(%r14), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%r14), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x60(%rsp), %rax
               	movups	(%r15), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%r15), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	movq	%rax, -0x68(%rbp)
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	movq	%rax, -0x60(%rbp)
               	leaq	0x40(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	jmp	<addr>
               	cmpl	$0x10, %r13d
               	jne	<addr>
               	leaq	0xe0(%rsp), %rax
               	movups	(%r14), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xf0(%rsp), %rax
               	movups	(%r15), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0xe0(%rsp), %rax
               	movq	0xe8(%rsp), %rcx
               	movq	0xf0(%rsp), %rdx
               	movq	0xf8(%rsp), %rsi
               	andq	%rdx, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	andq	%rsi, %rcx
               	testq	%rcx, %rcx
               	setge	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %r10
               	andq	%rcx, %r10
               	movq	%r10, -0x68(%rbp)
               	movq	0xe0(%rsp), %rax
               	movq	0xe8(%rsp), %rcx
               	movq	0xf0(%rsp), %rdx
               	movq	0xf8(%rsp), %rsi
               	xorq	$-0x1, %rax
               	andq	%rdx, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	xorq	$-0x1, %rcx
               	andq	%rsi, %rcx
               	testq	%rcx, %rcx
               	setge	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %r10
               	andq	%rcx, %r10
               	movq	%r10, -0x60(%rbp)
               	movq	0xe0(%rsp), %rcx
               	movq	0xe8(%rsp), %rdx
               	movq	0xf0(%rsp), %rsi
               	movq	0xf8(%rsp), %rdi
               	movq	%rcx, %rax
               	andq	%rsi, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movq	%rdx, %r8
               	andq	%rdi, %r8
               	testq	%r8, %r8
               	setge	%r8b
               	movzbq	%r8b, %r8
               	andq	%rax, %r8
               	xorl	%eax, %eax
               	testl	%r8d, %r8d
               	jne	<addr>
               	xorq	$-0x1, %rcx
               	andq	%rsi, %rcx
               	testq	%rcx, %rcx
               	setge	%al
               	movzbq	%al, %rax
               	xorq	$-0x1, %rdx
               	andq	%rdi, %rdx
               	testq	%rdx, %rdx
               	setge	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	(%r14), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%r14), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0xa0(%rsp), %rax
               	movups	(%r15), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%r15), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x80(%rsp), %r9
               	leaq	0xa0(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	movq	%rax, -0x68(%rbp)
               	leaq	0x80(%rsp), %r9
               	leaq	0xa0(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	movq	%rax, -0x60(%rbp)
               	leaq	0x80(%rsp), %r9
               	leaq	0xa0(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	jmp	<addr>
               	movq	-0x70(%rbp), %r10
               	orq	%rdx, %r10
               	movq	%r10, -0x70(%rbp)
               	addq	$0x10, %r13
               	cmpl	$0x20, %r13d
               	jle	<addr>
               	movq	-0x58(%rbp), %r10
               	addq	$0x4, %r10
               	movq	%r10, -0x58(%rbp)
               	movq	-0x58(%rbp), %rax
               	cmpl	$0x8, %eax
               	jle	<addr>
               	movq	-0x90(%rbp), %r10
               	incq	%r10
               	movq	%r10, -0x90(%rbp)
               	movq	-0x90(%rbp), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	-0x70(%rbp), %r10
               	testq	%r10, %r10
               	je	<addr>
               	movl	$0x40, %eax
               	leaq	-0xc0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>

<check_permutes_and_halves>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1d8, %rsp            # imm = 0x1D8
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x180, %rsp            # imm = 0x180
               	andq	$-0x20, %rsp
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movl	%eax, -0xa8(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %rbx # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %rbx
               	movl	%ebx, -0x88(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movl	%eax, -0xa4(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r12 # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %r12
               	movl	%r12d, -0x84(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movl	%eax, -0xa0(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r13 # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %r13
               	movl	%r13d, -0x80(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movl	%eax, -0x9c(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r14 # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %r14
               	movl	%r14d, -0x7c(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movl	%eax, -0x98(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r15 # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %r15
               	movl	%r15d, -0x78(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movl	%eax, -0x94(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r10 # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %r10
               	movq	%r10, -0x1b8(%rbp)
               	movq	-0x1b8(%rbp), %r10
               	movl	%r10d, -0x74(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movl	%eax, -0x90(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r10 # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %r10
               	movq	%r10, -0x1c0(%rbp)
               	movq	-0x1c0(%rbp), %r10
               	movl	%r10d, -0x70(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movl	%eax, -0x8c(%rbp)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shrq	$0xc, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shlq	$0x19, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rax, %rcx
               	shrq	$0x1b, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r10 # imm = 0x2545F4914F6CDD1D
               	imulq	%rax, %r10
               	movq	%r10, -0x1c8(%rbp)
               	movq	-0x1c8(%rbp), %r10
               	movl	%r10d, -0x6c(%rbp)
               	leaq	(%rsp), %rax
               	leaq	-0xa8(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x20(%rsp), %rax
               	leaq	-0x88(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0xa8(%rbp), %rax
               	movq	%rbx, %rcx
               	andq	$0x3, %rcx
               	movl	(%rax,%rcx,4), %eax
               	movl	%eax, -0x1a8(%rbp)
               	leaq	-0xa8(%rbp), %rax
               	movq	%r12, %rcx
               	andq	$0x3, %rcx
               	movl	(%rax,%rcx,4), %eax
               	movl	%eax, -0x1a4(%rbp)
               	leaq	-0xa8(%rbp), %rax
               	movq	%r13, %rcx
               	andq	$0x3, %rcx
               	movl	(%rax,%rcx,4), %eax
               	movl	%eax, -0x1a0(%rbp)
               	leaq	-0xa8(%rbp), %rax
               	movq	%r14, %rcx
               	andq	$0x3, %rcx
               	movl	(%rax,%rcx,4), %eax
               	movl	%eax, -0x19c(%rbp)
               	leaq	-0xa8(%rbp), %rax
               	movq	%r15, %rcx
               	andq	$0x3, %rcx
               	orq	$0x4, %rcx
               	movl	(%rax,%rcx,4), %eax
               	movl	%eax, -0x198(%rbp)
               	leaq	-0xa8(%rbp), %rax
               	movq	-0x1b8(%rbp), %rcx
               	andq	$0x3, %rcx
               	orq	$0x4, %rcx
               	movl	(%rax,%rcx,4), %eax
               	movl	%eax, -0x194(%rbp)
               	leaq	-0xa8(%rbp), %rax
               	movq	-0x1c0(%rbp), %rcx
               	andq	$0x3, %rcx
               	orq	$0x4, %rcx
               	movl	(%rax,%rcx,4), %eax
               	movl	%eax, -0x190(%rbp)
               	leaq	-0xa8(%rbp), %rax
               	movq	-0x1c8(%rbp), %rcx
               	andq	$0x3, %rcx
               	orq	$0x4, %rcx
               	movl	(%rax,%rcx,4), %eax
               	movl	%eax, -0x18c(%rbp)
               	leaq	0x140(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x140(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	-0x188(%rbp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x188(%rbp), %rdi
               	leaq	-0x1a8(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x1d0(%rbp)
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x120(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x140(%rsp), %rax
               	leaq	0x120(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movl	0x80(%rsp), %eax
               	movl	0x84(%rsp), %ecx
               	movl	0x88(%rsp), %edx
               	movl	0x8c(%rsp), %esi
               	leaq	0x140(%rsp), %rdi
               	leaq	0x80(%rsp), %r8
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x80(%rsp), %rdi
               	andq	$0x3, %rax
               	movl	(%rdi,%rax,4), %eax
               	movl	%eax, 0x140(%rsp)
               	leaq	0x80(%rsp), %rax
               	andq	$0x3, %rcx
               	movl	(%rax,%rcx,4), %eax
               	movl	%eax, 0x144(%rsp)
               	leaq	0x80(%rsp), %rax
               	andq	$0x3, %rdx
               	movl	(%rax,%rdx,4), %eax
               	movl	%eax, 0x148(%rsp)
               	leaq	0x80(%rsp), %rax
               	andq	$0x3, %rsi
               	movl	(%rax,%rsi,4), %eax
               	movl	%eax, 0x14c(%rsp)
               	movups	0x140(%rsp), %xmm0
               	movups	%xmm0, 0x160(%rsp)
               	leaq	0x160(%rsp), %rdi
               	leaq	-0x1a8(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	-0x1d0(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x1d0(%rbp)
               	leaq	-0x68(%rbp), %rax
               	leaq	-0xa8(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x48(%rbp), %rax
               	leaq	-0x88(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x68(%rbp), %rax
               	movq	-0x48(%rbp), %rcx
               	shrq	%rcx
               	andq	$0x1, %rcx
               	movq	(%rax,%rcx,8), %rax
               	movq	%rax, -0x168(%rbp)
               	leaq	-0x68(%rbp), %rax
               	movq	-0x40(%rbp), %rcx
               	shrq	%rcx
               	andq	$0x1, %rcx
               	movq	(%rax,%rcx,8), %rax
               	movq	%rax, -0x160(%rbp)
               	leaq	-0x68(%rbp), %rax
               	movq	-0x38(%rbp), %rcx
               	shrq	%rcx
               	andq	$0x1, %rcx
               	orq	$0x2, %rcx
               	movq	(%rax,%rcx,8), %rax
               	movq	%rax, -0x158(%rbp)
               	leaq	-0x68(%rbp), %rax
               	movq	-0x30(%rbp), %rcx
               	shrq	%rcx
               	andq	$0x1, %rcx
               	orq	$0x2, %rcx
               	movq	(%rax,%rcx,8), %rax
               	movq	%rax, -0x150(%rbp)
               	leaq	0x140(%rsp), %rdi
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x140(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	leaq	0x80(%rsp), %rdi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	-0x148(%rbp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x148(%rbp), %rdi
               	leaq	-0x168(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	-0x1d0(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x1d0(%rbp)
               	leaq	0x140(%rsp), %rdi
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x140(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x120(%rsp)
               	leaq	0x20(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movups	%xmm0, 0x80(%rsp)
               	leaq	0x140(%rsp), %rax
               	leaq	0x120(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x80(%rsp), %rax
               	movq	0x88(%rsp), %rcx
               	leaq	0x140(%rsp), %rdx
               	leaq	0x80(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x80(%rsp), %rdx
               	sarq	%rax
               	andq	$0x1, %rax
               	movq	(%rdx,%rax,8), %rax
               	movq	%rax, 0x140(%rsp)
               	leaq	0x80(%rsp), %rax
               	sarq	%rcx
               	andq	$0x1, %rcx
               	movq	(%rax,%rcx,8), %rax
               	movq	%rax, 0x148(%rsp)
               	movups	0x140(%rsp), %xmm0
               	movups	%xmm0, 0x170(%rsp)
               	leaq	0x170(%rsp), %rdi
               	leaq	-0x168(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	-0x1d0(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x1d0(%rbp)
               	movq	-0x68(%rbp), %rax
               	movq	%rax, -0x168(%rbp)
               	movq	-0x50(%rbp), %rax
               	movq	%rax, -0x160(%rbp)
               	movq	-0x60(%rbp), %rax
               	movq	%rax, -0x158(%rbp)
               	movq	-0x58(%rbp), %rax
               	movq	%rax, -0x150(%rbp)
               	leaq	0x140(%rsp), %rdi
               	leaq	(%rsp), %r9
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x140(%rsp), %r9
               	movl	$0x9c, %esi
               	leaq	0x80(%rsp), %rdi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x60(%rsp), %rdi
               	leaq	-0x168(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	-0x1d0(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x1d0(%rbp)
               	leaq	-0xa8(%rbp), %rax
               	andq	$0x7, %rbx
               	movl	(%rax,%rbx,4), %eax
               	movl	%eax, -0x1a8(%rbp)
               	leaq	-0xa8(%rbp), %rax
               	andq	$0x7, %r12
               	movl	(%rax,%r12,4), %eax
               	movl	%eax, -0x1a4(%rbp)
               	leaq	-0xa8(%rbp), %rax
               	andq	$0x7, %r13
               	movl	(%rax,%r13,4), %eax
               	movl	%eax, -0x1a0(%rbp)
               	leaq	-0xa8(%rbp), %rax
               	andq	$0x7, %r14
               	movl	(%rax,%r14,4), %eax
               	movl	%eax, -0x19c(%rbp)
               	leaq	-0xa8(%rbp), %rax
               	andq	$0x7, %r15
               	movl	(%rax,%r15,4), %eax
               	movl	%eax, -0x198(%rbp)
               	leaq	-0xa8(%rbp), %rax
               	movq	-0x1b8(%rbp), %rcx
               	andq	$0x7, %rcx
               	movl	(%rax,%rcx,4), %ecx
               	movl	%ecx, -0x194(%rbp)
               	movq	-0x1c0(%rbp), %rcx
               	andq	$0x7, %rcx
               	movl	(%rax,%rcx,4), %ecx
               	movl	%ecx, -0x190(%rbp)
               	movq	-0x1c8(%rbp), %rcx
               	andq	$0x7, %rcx
               	movl	(%rax,%rcx,4), %eax
               	movl	%eax, -0x18c(%rbp)
               	leaq	0x140(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x140(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x40(%rsp), %rdi
               	leaq	-0x1a8(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	-0x1d0(%rbp), %rbx
               	orq	%rax, %rbx
               	leaq	-0x48(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x128(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	-0x108(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	-0xe8(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x80(%rsp), %r9
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	0x140(%rsp), %rdi
               	movl	$0x8, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x140(%rsp), %rax
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x140(%rsp), %rdi
               	leaq	0x80(%rsp), %r9
               	movl	$0x1, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x140(%rsp), %rax
               	leaq	0xc0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x140(%rsp), %rdi
               	leaq	0x80(%rsp), %r9
               	movl	$0x2, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x140(%rsp), %rax
               	leaq	0xe0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0xa0(%rsp), %rdi
               	leaq	-0x128(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0xc0(%rsp), %rdi
               	leaq	-0x108(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	0xe0(%rsp), %rdi
               	leaq	-0xe8(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	leaq	-0x48(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0xc8(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	-0xa8(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x80(%rsp), %r9
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	0x140(%rsp), %rdi
               	movl	$0x3, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x140(%rsp), %rax
               	leaq	0x100(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x140(%rsp), %rdi
               	leaq	0x80(%rsp), %r9
               	movl	$0x2, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x140(%rsp), %rax
               	leaq	0x120(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x140(%rsp), %rdi
               	leaq	0x80(%rsp), %r9
               	movl	$0x1, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x140(%rsp), %rax
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	-0x88(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x100(%rsp), %rdi
               	leaq	-0xc8(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x120(%rsp), %rdi
               	leaq	-0xa8(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	(%rsp), %rdi
               	leaq	-0x88(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	leaq	-0x68(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x48(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x20(%rsp), %r9
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	0x80(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x140(%rsp), %rdi
               	movl	$0xb5, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x140(%rsp), %rax
               	leaq	0x80(%rsp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	-0x48(%rbp), %rsi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rbx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x80, %eax
               	leaq	-0x200(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	xorl	%eax, %eax
               	movabsq	$0x2545f4914f6cdd1d, %rdx # imm = 0x2545F4914F6CDD1D
               	leaq	<rip>, %rsi # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rdi
               	shrq	$0xc, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rdi
               	shlq	$0x19, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rdi
               	shrq	$0x1b, %rdi
               	xorq	%rdi, %rcx
               	movq	%rcx, <rip> # <addr>
               	imulq	%rdx, %rcx
               	shrq	$0x20, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x400, %eax            # imm = 0x400
               	jl	<addr>
               	xorl	%ebx, %ebx
               	movq	%rbx, %r12
               	xorl	%edi, %edi
               	callq	<addr>
               	orq	%rax, %r12
               	movl	$0x1, %edi
               	callq	<addr>
               	orq	%rax, %r12
               	callq	<addr>
               	orq	%rax, %r12
               	callq	<addr>
               	orq	%rax, %r12
               	callq	<addr>
               	orq	%rax, %r12
               	callq	<addr>
               	orq	%rax, %r12
               	callq	<addr>
               	orq	%rax, %r12
               	incq	%rbx
               	cmpl	$0xc8, %ebx
               	jl	<addr>
               	movq	%r12, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
