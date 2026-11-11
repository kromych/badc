
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

<_mm_i32gather_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%rbx
               	movslq	%esi, %rsi
               	leaq	-0x50(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0xffffffff, -0x50(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, -0x4c(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, -0x48(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, -0x44(%rbp) # imm = 0xFFFFFFFF
               	leaq	-0x40(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x30(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x40(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x20(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x50(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x30(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %r8
               	movups	%xmm0, -0x40(%rbp)
               	xorl	%eax, %eax
               	movl	(%rcx,%rax,4), %r9d
               	movl	%r9d, -0x8(%rbp)
               	movl	(%rdx,%rax,4), %r9d
               	testl	%r9d, %r9d
               	jge	<addr>
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r8,%rax,4), %rbx
               	imulq	%rsi, %rbx
               	addq	%rdi, %rbx
               	movl	(%rbx), %r10d
               	movl	%r10d, (%r9)
               	leaq	-0x30(%rbp), %r9
               	movl	-0x8(%rbp), %ebx
               	movl	%ebx, (%r9,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	-0x30(%rbp), %xmm0
               	popq	%rbx
               	leave
               	retq

<_mm256_i32gather_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%rbx
               	subq	$0xc0, %rsp
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
               	movslq	%edx, %rdx
               	leaq	0x20(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movl	$0xffffffff, 0x20(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x24(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x28(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x2c(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x30(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x34(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x38(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x3c(%rsp) # imm = 0xFFFFFFFF
               	movq	-0x40(%rbp), %rbx
               	leaq	0x40(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	(%rsp), %rdi
               	leaq	0x60(%rsp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x80(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x40(%rsp), %r9
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	0xa0(%rsp), %rdi
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%r8), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x20(%rsp), %r8
               	movups	(%r9), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%r9), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x60(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	xorl	%ecx, %ecx
               	movl	(%rdi,%rcx,4), %r9d
               	movl	%r9d, -0x8(%rbp)
               	movl	(%r8,%rcx,4), %r9d
               	testl	%r9d, %r9d
               	jge	<addr>
               	leaq	-0x8(%rbp), %r9
               	leaq	0x40(%rsp), %rax
               	movslq	(%rax,%rcx,4), %rax
               	imulq	%rdx, %rax
               	addq	%rsi, %rax
               	movl	(%rax), %r10d
               	movl	%r10d, (%r9)
               	leaq	0x60(%rsp), %r9
               	movl	-0x8(%rbp), %eax
               	movl	%eax, (%r9,%rcx,4)
               	incq	%rcx
               	cmpl	$0x8, %ecx
               	jl	<addr>
               	movq	0x60(%rsp), %rax
               	movq	0x68(%rsp), %rcx
               	movq	0x70(%rsp), %rdx
               	movq	0x78(%rsp), %rsi
               	movq	%rax, (%rbx)
               	movq	%rcx, 0x8(%rbx)
               	movq	%rdx, 0x10(%rbx)
               	movq	%rsi, 0x18(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm_i32gather_epi64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%rbx
               	movslq	%esi, %rsi
               	leaq	-0x50(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	$-0x1, -0x50(%rbp)
               	movq	$-0x1, -0x48(%rbp)
               	leaq	-0x40(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x30(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x40(%rbp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	-0x20(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x50(%rbp), %rdx
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x30(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %r8
               	movups	%xmm0, -0x40(%rbp)
               	xorl	%eax, %eax
               	movq	(%rcx,%rax,8), %r9
               	movq	%r9, -0x8(%rbp)
               	movq	(%rdx,%rax,8), %r9
               	testq	%r9, %r9
               	jge	<addr>
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r8,%rax,4), %rbx
               	imulq	%rsi, %rbx
               	addq	%rdi, %rbx
               	movq	(%rbx), %r10
               	movq	%r10, (%r9)
               	leaq	-0x30(%rbp), %r9
               	movq	-0x8(%rbp), %rbx
               	movq	%rbx, (%r9,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	-0x30(%rbp), %xmm0
               	popq	%rbx
               	leave
               	retq

<_mm256_i32gather_epi64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movslq	%edx, %rdx
               	leaq	(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movq	$-0x1, (%rsp)
               	movq	$-0x1, 0x8(%rsp)
               	movq	$-0x1, 0x10(%rsp)
               	movq	$-0x1, 0x18(%rsp)
               	movq	-0x50(%rbp), %rbx
               	leaq	0x20(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x40(%rsp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x20(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	(%rsp), %rdi
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%r8), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x40(%rsp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x20(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm0, 0x60(%rsp)
               	xorl	%ecx, %ecx
               	movq	(%rdi,%rcx,8), %r9
               	movq	%r9, -0x8(%rbp)
               	movq	(%r8,%rcx,8), %r9
               	testq	%r9, %r9
               	jge	<addr>
               	leaq	-0x8(%rbp), %r9
               	leaq	0x60(%rsp), %rax
               	movslq	(%rax,%rcx,4), %rax
               	imulq	%rdx, %rax
               	addq	%rsi, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%r9)
               	leaq	0x20(%rsp), %r9
               	movq	-0x8(%rbp), %rax
               	movq	%rax, (%r9,%rcx,8)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	movq	0x20(%rsp), %rax
               	movq	0x28(%rsp), %rcx
               	movq	0x30(%rsp), %rdx
               	movq	0x38(%rsp), %rsi
               	movq	%rax, (%rbx)
               	movq	%rcx, 0x8(%rbx)
               	movq	%rdx, 0x10(%rbx)
               	movq	%rsi, 0x18(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm_i64gather_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%rbx
               	movslq	%esi, %rsi
               	leaq	-0x50(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0xffffffff, -0x50(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, -0x4c(%rbp) # imm = 0xFFFFFFFF
               	leaq	-0x40(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x30(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x40(%rbp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	-0x20(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x50(%rbp), %rdx
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x30(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %r8
               	movups	%xmm0, -0x40(%rbp)
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
               	leaq	-0x30(%rbp), %r9
               	movl	-0x8(%rbp), %ebx
               	movl	%ebx, (%r9,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	-0x30(%rbp), %xmm0
               	popq	%rbx
               	leave
               	retq

<_mm256_i64gather_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0xa0, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movslq	%esi, %rsi
               	leaq	0x60(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0xffffffff, 0x60(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x64(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x68(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x6c(%rsp) # imm = 0xFFFFFFFF
               	leaq	0x20(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	(%rsp), %r8
               	leaq	0x70(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x40(%rsp), %rax
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%r8), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x20(%rsp), %r8
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x80(%rsp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x60(%rsp), %rdx
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x70(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
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
               	leaq	0x70(%rsp), %r9
               	movl	-0x8(%rbp), %ebx
               	movl	%ebx, (%r9,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	0x70(%rsp), %xmm0
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm_i64gather_epi64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%rbx
               	movslq	%esi, %rsi
               	leaq	-0x50(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	$-0x1, -0x50(%rbp)
               	movq	$-0x1, -0x48(%rbp)
               	leaq	-0x40(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x30(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x40(%rbp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	-0x20(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x50(%rbp), %rdx
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x30(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %r8
               	movups	%xmm0, -0x40(%rbp)
               	xorl	%eax, %eax
               	movq	(%rcx,%rax,8), %r9
               	movq	%r9, -0x8(%rbp)
               	movq	(%rdx,%rax,8), %r9
               	testq	%r9, %r9
               	jge	<addr>
               	leaq	-0x8(%rbp), %r9
               	movq	(%r8,%rax,8), %rbx
               	imulq	%rsi, %rbx
               	addq	%rdi, %rbx
               	movq	(%rbx), %r10
               	movq	%r10, (%r9)
               	leaq	-0x30(%rbp), %r9
               	movq	-0x8(%rbp), %rbx
               	movq	%rbx, (%r9,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	-0x30(%rbp), %xmm0
               	popq	%rbx
               	leave
               	retq

<_mm256_i64gather_epi64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%rbx
               	subq	$0xc0, %rsp
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
               	movslq	%edx, %rdx
               	leaq	0x20(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movq	$-0x1, 0x20(%rsp)
               	movq	$-0x1, 0x28(%rsp)
               	movq	$-0x1, 0x30(%rsp)
               	movq	$-0x1, 0x38(%rsp)
               	movq	-0x40(%rbp), %rbx
               	leaq	0x40(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	(%rsp), %rdi
               	leaq	0x60(%rsp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x80(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x40(%rsp), %r9
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	0xa0(%rsp), %rdi
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%r8), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x20(%rsp), %r8
               	movups	(%r9), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%r9), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x60(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	xorl	%ecx, %ecx
               	movq	(%rdi,%rcx,8), %r9
               	movq	%r9, -0x8(%rbp)
               	movq	(%r8,%rcx,8), %r9
               	testq	%r9, %r9
               	jge	<addr>
               	leaq	-0x8(%rbp), %r9
               	leaq	0x40(%rsp), %rax
               	movq	(%rax,%rcx,8), %rax
               	imulq	%rdx, %rax
               	addq	%rsi, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%r9)
               	leaq	0x60(%rsp), %r9
               	movq	-0x8(%rbp), %rax
               	movq	%rax, (%r9,%rcx,8)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	movq	0x60(%rsp), %rax
               	movq	0x68(%rsp), %rcx
               	movq	0x70(%rsp), %rdx
               	movq	0x78(%rsp), %rsi
               	movq	%rax, (%rbx)
               	movq	%rcx, 0x8(%rbx)
               	movq	%rdx, 0x10(%rbx)
               	movq	%rsi, 0x18(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm_i32gather_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%rbx
               	movslq	%esi, %rsi
               	leaq	-0x50(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0xffffffff, -0x50(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, -0x4c(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, -0x48(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, -0x44(%rbp) # imm = 0xFFFFFFFF
               	leaq	-0x40(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x30(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x40(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x20(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x50(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x30(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %r8
               	movups	%xmm0, -0x40(%rbp)
               	xorl	%eax, %eax
               	movl	(%rcx,%rax,4), %r9d
               	movl	%r9d, -0x8(%rbp)
               	movl	(%rdx,%rax,4), %r9d
               	testl	%r9d, %r9d
               	jge	<addr>
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r8,%rax,4), %rbx
               	imulq	%rsi, %rbx
               	addq	%rdi, %rbx
               	movl	(%rbx), %r10d
               	movl	%r10d, (%r9)
               	leaq	-0x30(%rbp), %r9
               	movl	-0x8(%rbp), %ebx
               	movl	%ebx, (%r9,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	-0x30(%rbp), %xmm0
               	popq	%rbx
               	leave
               	retq

<_mm256_i32gather_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%rbx
               	subq	$0xc0, %rsp
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
               	movslq	%edx, %rdx
               	leaq	0x20(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movl	$0xffffffff, 0x20(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x24(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x28(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x2c(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x30(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x34(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x38(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x3c(%rsp) # imm = 0xFFFFFFFF
               	movq	-0x40(%rbp), %rbx
               	leaq	0x40(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	(%rsp), %rdi
               	leaq	0x60(%rsp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x80(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x40(%rsp), %r9
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	0xa0(%rsp), %rdi
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%r8), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x20(%rsp), %r8
               	movups	(%r9), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%r9), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x60(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	xorl	%ecx, %ecx
               	movl	(%rdi,%rcx,4), %r9d
               	movl	%r9d, -0x8(%rbp)
               	movl	(%r8,%rcx,4), %r9d
               	testl	%r9d, %r9d
               	jge	<addr>
               	leaq	-0x8(%rbp), %r9
               	leaq	0x40(%rsp), %rax
               	movslq	(%rax,%rcx,4), %rax
               	imulq	%rdx, %rax
               	addq	%rsi, %rax
               	movl	(%rax), %r10d
               	movl	%r10d, (%r9)
               	leaq	0x60(%rsp), %r9
               	movl	-0x8(%rbp), %eax
               	movl	%eax, (%r9,%rcx,4)
               	incq	%rcx
               	cmpl	$0x8, %ecx
               	jl	<addr>
               	movq	0x60(%rsp), %rax
               	movq	0x68(%rsp), %rcx
               	movq	0x70(%rsp), %rdx
               	movq	0x78(%rsp), %rsi
               	movq	%rax, (%rbx)
               	movq	%rcx, 0x8(%rbx)
               	movq	%rdx, 0x10(%rbx)
               	movq	%rsi, 0x18(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm_i32gather_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%rbx
               	movslq	%esi, %rsi
               	leaq	-0x50(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	$-0x1, -0x50(%rbp)
               	movq	$-0x1, -0x48(%rbp)
               	leaq	-0x40(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x30(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x40(%rbp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	-0x20(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x50(%rbp), %rdx
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x30(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %r8
               	movups	%xmm0, -0x40(%rbp)
               	xorl	%eax, %eax
               	movq	(%rcx,%rax,8), %r9
               	movq	%r9, -0x8(%rbp)
               	movq	(%rdx,%rax,8), %r9
               	testq	%r9, %r9
               	jge	<addr>
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r8,%rax,4), %rbx
               	imulq	%rsi, %rbx
               	addq	%rdi, %rbx
               	movq	(%rbx), %r10
               	movq	%r10, (%r9)
               	leaq	-0x30(%rbp), %r9
               	movq	-0x8(%rbp), %rbx
               	movq	%rbx, (%r9,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	-0x30(%rbp), %xmm0
               	popq	%rbx
               	leave
               	retq

<_mm256_i32gather_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movslq	%edx, %rdx
               	leaq	(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movq	$-0x1, (%rsp)
               	movq	$-0x1, 0x8(%rsp)
               	movq	$-0x1, 0x10(%rsp)
               	movq	$-0x1, 0x18(%rsp)
               	movq	-0x50(%rbp), %rbx
               	leaq	0x20(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x40(%rsp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x20(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	(%rsp), %rdi
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%r8), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x40(%rsp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x20(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm0, 0x60(%rsp)
               	xorl	%ecx, %ecx
               	movq	(%rdi,%rcx,8), %r9
               	movq	%r9, -0x8(%rbp)
               	movq	(%r8,%rcx,8), %r9
               	testq	%r9, %r9
               	jge	<addr>
               	leaq	-0x8(%rbp), %r9
               	leaq	0x60(%rsp), %rax
               	movslq	(%rax,%rcx,4), %rax
               	imulq	%rdx, %rax
               	addq	%rsi, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%r9)
               	leaq	0x20(%rsp), %r9
               	movq	-0x8(%rbp), %rax
               	movq	%rax, (%r9,%rcx,8)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	movq	0x20(%rsp), %rax
               	movq	0x28(%rsp), %rcx
               	movq	0x30(%rsp), %rdx
               	movq	0x38(%rsp), %rsi
               	movq	%rax, (%rbx)
               	movq	%rcx, 0x8(%rbx)
               	movq	%rdx, 0x10(%rbx)
               	movq	%rsi, 0x18(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm_mask_i64gather_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%rbx
               	movslq	%esi, %rsi
               	leaq	-0x50(%rbp), %rcx
               	movups	%xmm0, -0x50(%rbp)
               	leaq	-0x40(%rbp), %rdx
               	movups	%xmm2, -0x40(%rbp)
               	leaq	-0x30(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x20(%rbp), %r8
               	movups	%xmm1, -0x20(%rbp)
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
               	leaq	-0x30(%rbp), %r9
               	movl	-0x8(%rbp), %ebx
               	movl	%ebx, (%r9,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	-0x30(%rbp), %xmm0
               	popq	%rbx
               	leave
               	retq

<_mm_i64gather_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%rbx
               	movslq	%esi, %rsi
               	leaq	-0x50(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0xffffffff, -0x50(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, -0x4c(%rbp) # imm = 0xFFFFFFFF
               	leaq	-0x40(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x30(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x40(%rbp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	-0x20(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x50(%rbp), %rdx
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x30(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %r8
               	movups	%xmm0, -0x40(%rbp)
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
               	leaq	-0x30(%rbp), %r9
               	movl	-0x8(%rbp), %ebx
               	movl	%ebx, (%r9,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	-0x30(%rbp), %xmm0
               	popq	%rbx
               	leave
               	retq

<_mm256_mask_i64gather_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
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
               	movslq	%esi, %rsi
               	leaq	0x40(%rsp), %rdx
               	movups	%xmm0, 0x40(%rsp)
               	leaq	0x50(%rsp), %r8
               	movups	%xmm1, 0x50(%rsp)
               	leaq	0x60(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	xorl	%eax, %eax
               	movl	(%rdx,%rax,4), %r9d
               	movl	%r9d, -0x8(%rbp)
               	movl	(%r8,%rax,4), %r9d
               	testl	%r9d, %r9d
               	jge	<addr>
               	leaq	-0x8(%rbp), %r9
               	movq	(%rcx,%rax,8), %rbx
               	imulq	%rsi, %rbx
               	addq	%rdi, %rbx
               	movl	(%rbx), %r10d
               	movl	%r10d, (%r9)
               	leaq	0x60(%rsp), %r9
               	movl	-0x8(%rbp), %ebx
               	movl	%ebx, (%r9,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	0x60(%rsp), %xmm0
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_i64gather_ps>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0xa0, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movslq	%esi, %rsi
               	leaq	0x60(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0xffffffff, 0x60(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x64(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x68(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x6c(%rsp) # imm = 0xFFFFFFFF
               	leaq	0x20(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	(%rsp), %r8
               	leaq	0x70(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x40(%rsp), %rax
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%r8), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x20(%rsp), %r8
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x80(%rsp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x60(%rsp), %rdx
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x70(%rsp), %r8
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r8)
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
               	leaq	0x70(%rsp), %r9
               	movl	-0x8(%rbp), %ebx
               	movl	%ebx, (%r9,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	0x70(%rsp), %xmm0
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm_mask_i64gather_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%rbx
               	movslq	%esi, %rsi
               	leaq	-0x50(%rbp), %rcx
               	movups	%xmm0, -0x50(%rbp)
               	leaq	-0x40(%rbp), %rdx
               	movups	%xmm2, -0x40(%rbp)
               	leaq	-0x30(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x20(%rbp), %r8
               	movups	%xmm1, -0x20(%rbp)
               	xorl	%eax, %eax
               	movq	(%rcx,%rax,8), %r9
               	movq	%r9, -0x8(%rbp)
               	movq	(%rdx,%rax,8), %r9
               	testq	%r9, %r9
               	jge	<addr>
               	leaq	-0x8(%rbp), %r9
               	movq	(%r8,%rax,8), %rbx
               	imulq	%rsi, %rbx
               	addq	%rdi, %rbx
               	movq	(%rbx), %r10
               	movq	%r10, (%r9)
               	leaq	-0x30(%rbp), %r9
               	movq	-0x8(%rbp), %rbx
               	movq	%rbx, (%r9,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	-0x30(%rbp), %xmm0
               	popq	%rbx
               	leave
               	retq

<_mm_i64gather_pd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%rbx
               	movslq	%esi, %rsi
               	leaq	-0x50(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	$-0x1, -0x50(%rbp)
               	movq	$-0x1, -0x48(%rbp)
               	leaq	-0x40(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x30(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x40(%rbp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	-0x20(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x50(%rbp), %rdx
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x30(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %r8
               	movups	%xmm0, -0x40(%rbp)
               	xorl	%eax, %eax
               	movq	(%rcx,%rax,8), %r9
               	movq	%r9, -0x8(%rbp)
               	movq	(%rdx,%rax,8), %r9
               	testq	%r9, %r9
               	jge	<addr>
               	leaq	-0x8(%rbp), %r9
               	movq	(%r8,%rax,8), %rbx
               	imulq	%rsi, %rbx
               	addq	%rdi, %rbx
               	movq	(%rbx), %r10
               	movq	%r10, (%r9)
               	leaq	-0x30(%rbp), %r9
               	movq	-0x8(%rbp), %rbx
               	movq	%rbx, (%r9,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	-0x30(%rbp), %xmm0
               	popq	%rbx
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
               	subq	$0x48, %rsp
               	pushq	%rbx
               	subq	$0xc0, %rsp
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
               	movslq	%edx, %rdx
               	leaq	0x20(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movq	$-0x1, 0x20(%rsp)
               	movq	$-0x1, 0x28(%rsp)
               	movq	$-0x1, 0x30(%rsp)
               	movq	$-0x1, 0x38(%rsp)
               	movq	-0x40(%rbp), %rbx
               	leaq	0x40(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	(%rsp), %rdi
               	leaq	0x60(%rsp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x80(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x40(%rsp), %r9
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	0xa0(%rsp), %rdi
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%r8), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x20(%rsp), %r8
               	movups	(%r9), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%r9), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x60(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	xorl	%ecx, %ecx
               	movq	(%rdi,%rcx,8), %r9
               	movq	%r9, -0x8(%rbp)
               	movq	(%r8,%rcx,8), %r9
               	testq	%r9, %r9
               	jge	<addr>
               	leaq	-0x8(%rbp), %r9
               	leaq	0x40(%rsp), %rax
               	movq	(%rax,%rcx,8), %rax
               	imulq	%rdx, %rax
               	addq	%rsi, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%r9)
               	leaq	0x60(%rsp), %r9
               	movq	-0x8(%rbp), %rax
               	movq	%rax, (%r9,%rcx,8)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	movq	0x60(%rsp), %rax
               	movq	0x68(%rsp), %rcx
               	movq	0x70(%rsp), %rdx
               	movq	0x78(%rsp), %rsi
               	movq	%rax, (%rbx)
               	movq	%rcx, 0x8(%rbx)
               	movq	%rdx, 0x10(%rbx)
               	movq	%rsi, 0x18(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	leave
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
               	subq	$0x108, %rsp            # imm = 0x108
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0xaa0, %rsp            # imm = 0xAA0
               	andq	$-0x20, %rsp
               	movslq	%edi, %rbx
               	movl	$0x4, %esi
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x1, %r8d
               	movq	%rsi, %rdx
               	movq	%rbx, %r9
               	movq	%rsi, %rcx
               	callq	<addr>
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x6c0(%rsp), %rsi
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
               	leaq	0x6d0(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x6a0(%rsp), %rdi
               	leaq	0x700(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x710(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x720(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x700(%rsp), %rcx
               	leaq	0x730(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x740(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x750(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x760(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0x730(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0xe0(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xe0(%rbp), %rsi
               	leaq	0x760(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0x750(%rsp), %rsi
               	movl	-0xe0(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x140(%rsp), %rax
               	movups	0x750(%rsp), %xmm0
               	movups	%xmm0, 0x140(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x6d0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x60(%rsp), %rdi
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x140(%rsp), %r8
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x200, %rcx            # imm = 0x200
               	leaq	(%rsp), %rdx
               	leaq	0x20(%rsp), %rsi
               	leaq	0x2e0(%rsp), %r9
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	0x300(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x320(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x2e0(%rsp), %rdx
               	leaq	0x340(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x360(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x380(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x300(%rsp), %rax
               	leaq	0x3a0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	xorl	%eax, %eax
               	leaq	0x340(%rsp), %rdx
               	movl	(%rdx,%rax,4), %edx
               	movl	%edx, -0xd8(%rbp)
               	leaq	0x360(%rsp), %rdx
               	movl	(%rdx,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0xd8(%rbp), %rdx
               	leaq	0x3a0(%rsp), %rsi
               	movslq	(%rsi,%rax,4), %rsi
               	addq	%rcx, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	leaq	0x380(%rsp), %rdx
               	movl	-0xd8(%rbp), %esi
               	movl	%esi, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x380(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x140(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x6c0(%rsp), %rsi
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
               	leaq	0x6d0(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x6a0(%rsp), %rdi
               	leaq	0x7a0(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x7b0(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x7c0(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x7a0(%rsp), %rcx
               	leaq	0x7d0(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x7e0(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x7f0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x800(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0x7d0(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	%rsi, -0xd0(%rbp)
               	movq	(%rcx,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xd0(%rbp), %rsi
               	leaq	0x800(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	addq	%rdx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0x7f0(%rsp), %rsi
               	movq	-0xd0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x140(%rsp), %rax
               	movups	0x7f0(%rsp), %xmm0
               	movups	%xmm0, 0x140(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x6d0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x60(%rsp), %rdi
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x140(%rsp), %r8
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x200, %rcx            # imm = 0x200
               	leaq	0x6a0(%rsp), %rdx
               	leaq	0x20(%rsp), %rsi
               	leaq	0x3e0(%rsp), %r9
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	0x840(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x400(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x3e0(%rsp), %rdx
               	leaq	0x420(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x440(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x460(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x840(%rsp), %rax
               	leaq	0x850(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	leaq	0x420(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	movq	%rdx, -0xc8(%rbp)
               	leaq	0x440(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0xc8(%rbp), %rdx
               	leaq	0x850(%rsp), %rsi
               	movslq	(%rsi,%rax,4), %rsi
               	addq	%rcx, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	leaq	0x460(%rsp), %rdx
               	movq	-0xc8(%rbp), %rsi
               	movq	%rsi, (%rdx,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x460(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x140(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x6e0(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	movups	0x6c0(%rsp), %xmm0
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x6a0(%rsp), %rdx
               	movups	0x6b0(%rsp), %xmm1
               	leaq	0x870(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x880(%rsp), %rdx
               	movups	%xmm0, 0x880(%rsp)
               	movups	%xmm1, 0x890(%rsp)
               	leaq	0x8a0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x8b0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movl	(%rdx,%rax,4), %esi
               	movl	%esi, -0xc0(%rbp)
               	leaq	0x890(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xc0(%rbp), %rsi
               	leaq	0x8b0(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	addq	%rcx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0x8a0(%rsp), %rsi
               	movl	-0xc0(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x140(%rsp), %rax
               	movups	0x8a0(%rsp), %xmm0
               	movups	%xmm0, 0x140(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x6e0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x80(%rsp), %rdi
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x140(%rsp), %r8
               	movq	0x40(%rsp), %rax
               	movq	0x48(%rsp), %rdx
               	movq	0x50(%rsp), %rsi
               	movq	0x58(%rsp), %r9
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x200, %rcx            # imm = 0x200
               	leaq	(%rsp), %r13
               	movq	0x20(%rsp), %r14
               	movq	0x28(%rsp), %r15
               	movq	0x30(%rsp), %r10
               	movq	%r10, -0xe8(%rbp)
               	movq	0x38(%rsp), %r10
               	movq	%r10, -0xf0(%rbp)
               	movq	%rax, 0x480(%rsp)
               	movq	%rdx, 0x488(%rsp)
               	movq	%rsi, 0x490(%rsp)
               	movq	%r9, 0x498(%rsp)
               	leaq	0x4a0(%rsp), %rax
               	movups	(%r13), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%r13), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movq	%r14, 0x4c0(%rsp)
               	movq	%r15, 0x4c8(%rsp)
               	movq	-0xe8(%rbp), %r10
               	movq	%r10, 0x4d0(%rsp)
               	movq	-0xf0(%rbp), %r10
               	movq	%r10, 0x4d8(%rsp)
               	leaq	0x480(%rsp), %rax
               	leaq	0x4e0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x500(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x520(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x4a0(%rsp), %rax
               	leaq	0x540(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	xorl	%eax, %eax
               	leaq	0x4e0(%rsp), %rdx
               	movl	(%rdx,%rax,4), %edx
               	movl	%edx, -0xb8(%rbp)
               	leaq	0x500(%rsp), %rdx
               	movl	(%rdx,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0xb8(%rbp), %rdx
               	leaq	0x540(%rsp), %rsi
               	movslq	(%rsi,%rax,4), %rsi
               	addq	%rcx, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	leaq	0x520(%rsp), %rdx
               	movl	-0xb8(%rbp), %esi
               	movl	%esi, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x520(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x140(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x6f0(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	movups	0x6c0(%rsp), %xmm0
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x6a0(%rsp), %rdx
               	movups	0x6b0(%rsp), %xmm1
               	leaq	0x8d0(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x8e0(%rsp), %rdx
               	movups	%xmm0, 0x8e0(%rsp)
               	movups	%xmm1, 0x8f0(%rsp)
               	leaq	0x900(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x910(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movq	(%rdx,%rax,8), %rsi
               	movq	%rsi, -0xb0(%rbp)
               	leaq	0x8f0(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xb0(%rbp), %rsi
               	leaq	0x910(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	addq	%rcx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0x900(%rsp), %rsi
               	movq	-0xb0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x140(%rsp), %rax
               	movups	0x900(%rsp), %xmm0
               	movups	%xmm0, 0x140(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x6f0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0xa0(%rsp), %rdi
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x140(%rsp), %r8
               	leaq	0x560(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movq	0x560(%rsp), %rax
               	movq	0x568(%rsp), %rdx
               	movq	0x570(%rsp), %rsi
               	movq	0x578(%rsp), %r9
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x200, %rcx            # imm = 0x200
               	leaq	0x6a0(%rsp), %r13
               	leaq	0x20(%rsp), %r14
               	leaq	0x560(%rsp), %r15
               	movups	(%r14), %xmm14
               	movups	%xmm14, (%r15)
               	movups	0x10(%r14), %xmm14
               	movups	%xmm14, 0x10(%r15)
               	movq	0x560(%rsp), %r14
               	movq	0x568(%rsp), %r15
               	movq	0x570(%rsp), %r10
               	movq	%r10, -0xe8(%rbp)
               	movq	0x578(%rsp), %r10
               	movq	%r10, -0xf0(%rbp)
               	movq	%rax, 0x580(%rsp)
               	movq	%rdx, 0x588(%rsp)
               	movq	%rsi, 0x590(%rsp)
               	movq	%r9, 0x598(%rsp)
               	leaq	0x930(%rsp), %rax
               	movups	(%r13), %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r14, 0x5a0(%rsp)
               	movq	%r15, 0x5a8(%rsp)
               	movq	-0xe8(%rbp), %r10
               	movq	%r10, 0x5b0(%rsp)
               	movq	-0xf0(%rbp), %r10
               	movq	%r10, 0x5b8(%rsp)
               	leaq	0x580(%rsp), %rax
               	leaq	0x5c0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x5a0(%rsp), %rax
               	leaq	0x5e0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x600(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x930(%rsp), %rax
               	leaq	0x940(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	leaq	0x5c0(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	movq	%rdx, -0xa8(%rbp)
               	leaq	0x5e0(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0xa8(%rbp), %rdx
               	leaq	0x940(%rsp), %rsi
               	movslq	(%rsi,%rax,4), %rsi
               	addq	%rcx, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	leaq	0x600(%rsp), %rdx
               	movq	-0xa8(%rbp), %rsi
               	movq	%rsi, (%rdx,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x600(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x140(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x6c0(%rsp), %rsi
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
               	leaq	0x6d0(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x6a0(%rsp), %rdi
               	leaq	0x960(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x970(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x980(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x960(%rsp), %rcx
               	leaq	0x990(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x9a0(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x9b0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x9c0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0x990(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0xa0(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xa0(%rbp), %rsi
               	leaq	0x9c0(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0x9b0(%rsp), %rsi
               	movl	-0xa0(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x140(%rsp), %rax
               	movups	0x9b0(%rsp), %xmm0
               	movups	%xmm0, 0x140(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x6d0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x6c0(%rsp), %rsi
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
               	leaq	0x6d0(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	(%rsp), %rdi
               	leaq	0x9d0(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x2c0(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x9e0(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x9d0(%rsp), %rcx
               	leaq	0x9f0(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xa00(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xa10(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x260(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	xorl	%eax, %eax
               	leaq	0x9f0(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0x98(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x98(%rbp), %rsi
               	leaq	0x260(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0xa10(%rsp), %rsi
               	movl	-0x98(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x140(%rsp), %rax
               	movups	0xa10(%rsp), %xmm0
               	movups	%xmm0, 0x140(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x6d0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x6c0(%rsp), %rsi
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
               	leaq	0x6d0(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x6a0(%rsp), %rdi
               	leaq	0xa20(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xa30(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xa40(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xa20(%rsp), %rcx
               	leaq	0xa50(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xa60(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xa70(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xa80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0xa50(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	%rsi, -0x90(%rbp)
               	movq	(%rcx,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0x90(%rbp), %rsi
               	leaq	0xa80(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	addq	%rdx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0xa70(%rsp), %rsi
               	movq	-0x90(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x140(%rsp), %rax
               	movups	0xa70(%rsp), %xmm0
               	movups	%xmm0, 0x140(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x6d0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x60(%rsp), %rdi
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x180(%rsp), %r8
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x200, %rcx            # imm = 0x200
               	leaq	(%rsp), %rdx
               	leaq	0x20(%rsp), %rsi
               	leaq	0x620(%rsp), %r9
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	0x640(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x660(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x620(%rsp), %rdx
               	leaq	0x680(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x280(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x140(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x640(%rsp), %rax
               	leaq	0x160(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	xorl	%eax, %eax
               	leaq	0x680(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	leaq	0x280(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	leaq	0x160(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	addq	%rcx, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	leaq	0x140(%rsp), %rdx
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, (%rdx,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x140(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x180(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x180(%rsp), %r9
               	movups	0x6c0(%rsp), %xmm0
               	movups	%xmm0, 0x180(%rsp)
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x6a0(%rsp), %rax
               	movups	0x6b0(%rsp), %xmm0
               	movups	%xmm0, 0x1a0(%rsp)
               	leaq	0x1a0(%rsp), %rcx
               	movl	$0x1, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	callq	<addr>
               	movups	%xmm0, 0x180(%rsp)
               	leaq	0x180(%rsp), %rax
               	leaq	0x6e0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x6e0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x180(%rsp), %r9
               	movups	0x6c0(%rsp), %xmm0
               	movups	%xmm0, 0x180(%rsp)
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %rax
               	movups	0x6b0(%rsp), %xmm0
               	movups	%xmm0, 0x1a0(%rsp)
               	leaq	0x1a0(%rsp), %rcx
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
               	movups	%xmm0, 0x180(%rsp)
               	leaq	0x180(%rsp), %rax
               	leaq	0x6e0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x6e0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x180(%rsp), %r9
               	movups	0x6c0(%rsp), %xmm0
               	movups	%xmm0, 0x180(%rsp)
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x6a0(%rsp), %rax
               	movups	0x6b0(%rsp), %xmm0
               	movups	%xmm0, 0x1a0(%rsp)
               	leaq	0x1a0(%rsp), %rcx
               	movl	$0x1, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	callq	<addr>
               	movups	%xmm0, 0x180(%rsp)
               	leaq	0x180(%rsp), %rax
               	leaq	0x6f0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x6f0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x1c0(%rsp), %rdi
               	leaq	0x180(%rsp), %rdx
               	leaq	0x560(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x180(%rsp), %r9
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	(%rsp), %rax
               	leaq	0x1a0(%rsp), %rcx
               	leaq	0x20(%rsp), %rdx
               	leaq	0x560(%rsp), %r8
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x560(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x1a0(%rsp), %rcx
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
               	movl	$0x4, %esi
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x2, %r8d
               	movq	%rsi, %rdx
               	movq	%rbx, %r9
               	movq	%rsi, %rcx
               	callq	<addr>
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x6c0(%rsp), %rsi
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
               	leaq	0x6d0(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x6a0(%rsp), %rdi
               	leaq	0x700(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x710(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x720(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x700(%rsp), %rcx
               	leaq	0x730(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x740(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x750(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x760(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0x730(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0xe0(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xe0(%rbp), %rsi
               	leaq	0x760(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	%rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0x750(%rsp), %rsi
               	movl	-0xe0(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x180(%rsp), %rax
               	movups	0x750(%rsp), %xmm0
               	movups	%xmm0, 0x180(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x6d0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x60(%rsp), %rdi
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x1e0(%rsp), %r8
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x200, %rcx            # imm = 0x200
               	leaq	(%rsp), %rdx
               	leaq	0x20(%rsp), %rsi
               	leaq	0x2e0(%rsp), %r9
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	0x300(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x320(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x2e0(%rsp), %rdx
               	leaq	0x340(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x360(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x380(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x300(%rsp), %rax
               	leaq	0x3a0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	xorl	%eax, %eax
               	leaq	0x340(%rsp), %rdx
               	movl	(%rdx,%rax,4), %edx
               	movl	%edx, -0xd8(%rbp)
               	leaq	0x360(%rsp), %rdx
               	movl	(%rdx,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0xd8(%rbp), %rdx
               	leaq	0x3a0(%rsp), %rsi
               	movslq	(%rsi,%rax,4), %rsi
               	shlq	%rsi
               	addq	%rcx, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	leaq	0x380(%rsp), %rdx
               	movl	-0xd8(%rbp), %esi
               	movl	%esi, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x380(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x1e0(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x6c0(%rsp), %rsi
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
               	leaq	0x6d0(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x6a0(%rsp), %rdi
               	leaq	0x7a0(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x7b0(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x7c0(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x7a0(%rsp), %rcx
               	leaq	0x7d0(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x7e0(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x7f0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x800(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0x7d0(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	%rsi, -0xd0(%rbp)
               	movq	(%rcx,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xd0(%rbp), %rsi
               	leaq	0x800(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	%rdi
               	addq	%rdx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0x7f0(%rsp), %rsi
               	movq	-0xd0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x2a0(%rsp), %rax
               	movups	0x7f0(%rsp), %xmm0
               	movups	%xmm0, 0x2a0(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x6d0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x60(%rsp), %rdi
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x200(%rsp), %r8
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x200, %rcx            # imm = 0x200
               	leaq	0x6a0(%rsp), %rdx
               	leaq	0x20(%rsp), %rsi
               	leaq	0x3e0(%rsp), %r9
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	0x840(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x400(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x3e0(%rsp), %rdx
               	leaq	0x420(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x440(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x460(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x840(%rsp), %rax
               	leaq	0x850(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	leaq	0x420(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	movq	%rdx, -0xc8(%rbp)
               	leaq	0x440(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0xc8(%rbp), %rdx
               	leaq	0x850(%rsp), %rsi
               	movslq	(%rsi,%rax,4), %rsi
               	shlq	%rsi
               	addq	%rcx, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	leaq	0x460(%rsp), %rdx
               	movq	-0xc8(%rbp), %rsi
               	movq	%rsi, (%rdx,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x460(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x200(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x1e0(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	movups	0x6c0(%rsp), %xmm0
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x6a0(%rsp), %rdx
               	movups	0x6b0(%rsp), %xmm1
               	leaq	0x870(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x880(%rsp), %rdx
               	movups	%xmm0, 0x880(%rsp)
               	movups	%xmm1, 0x890(%rsp)
               	leaq	0x8a0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x8b0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movl	(%rdx,%rax,4), %esi
               	movl	%esi, -0xc0(%rbp)
               	leaq	0x890(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xc0(%rbp), %rsi
               	leaq	0x8b0(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	%rdi
               	addq	%rcx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0x8a0(%rsp), %rsi
               	movl	-0xc0(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0xc0(%rsp), %rax
               	movups	0x8a0(%rsp), %xmm0
               	movups	%xmm0, 0xc0(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x1e0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0xc0(%rsp), %rdi
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x120(%rsp), %r8
               	movq	0x40(%rsp), %rax
               	movq	0x48(%rsp), %rdx
               	movq	0x50(%rsp), %rsi
               	movq	0x58(%rsp), %r9
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x200, %rcx            # imm = 0x200
               	leaq	(%rsp), %r13
               	movq	0x20(%rsp), %r14
               	movq	0x28(%rsp), %r15
               	movq	0x30(%rsp), %r10
               	movq	%r10, -0xe8(%rbp)
               	movq	0x38(%rsp), %r10
               	movq	%r10, -0xf0(%rbp)
               	movq	%rax, 0x480(%rsp)
               	movq	%rdx, 0x488(%rsp)
               	movq	%rsi, 0x490(%rsp)
               	movq	%r9, 0x498(%rsp)
               	leaq	0x4a0(%rsp), %rax
               	movups	(%r13), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%r13), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movq	%r14, 0x4c0(%rsp)
               	movq	%r15, 0x4c8(%rsp)
               	movq	-0xe8(%rbp), %r10
               	movq	%r10, 0x4d0(%rsp)
               	movq	-0xf0(%rbp), %r10
               	movq	%r10, 0x4d8(%rsp)
               	leaq	0x480(%rsp), %rax
               	leaq	0x4e0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x500(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x520(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x4a0(%rsp), %rax
               	leaq	0x540(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	xorl	%eax, %eax
               	leaq	0x4e0(%rsp), %rdx
               	movl	(%rdx,%rax,4), %edx
               	movl	%edx, -0xb8(%rbp)
               	leaq	0x500(%rsp), %rdx
               	movl	(%rdx,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0xb8(%rbp), %rdx
               	leaq	0x540(%rsp), %rsi
               	movslq	(%rsi,%rax,4), %rsi
               	shlq	%rsi
               	addq	%rcx, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	leaq	0x520(%rsp), %rdx
               	movl	-0xb8(%rbp), %esi
               	movl	%esi, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x520(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x120(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0xc0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x100(%rsp), %r8
               	testq	%rbx, %rbx
               	je	<addr>
               	movups	0x6c0(%rsp), %xmm0
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x6a0(%rsp), %rdx
               	movups	0x6b0(%rsp), %xmm1
               	leaq	0x8d0(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x8e0(%rsp), %rdx
               	movups	%xmm0, 0x8e0(%rsp)
               	movups	%xmm1, 0x8f0(%rsp)
               	leaq	0x900(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x910(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movq	(%rdx,%rax,8), %rsi
               	movq	%rsi, -0xb0(%rbp)
               	leaq	0x8f0(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xb0(%rbp), %rsi
               	leaq	0x910(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	%rdi
               	addq	%rcx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0x900(%rsp), %rsi
               	movq	-0xb0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0xe0(%rsp), %rax
               	movups	0x900(%rsp), %xmm0
               	movups	%xmm0, 0xe0(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	0x100(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0xe0(%rsp), %rdi
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x220(%rsp), %r8
               	leaq	0x560(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movq	0x560(%rsp), %rax
               	movq	0x568(%rsp), %rdx
               	movq	0x570(%rsp), %rsi
               	movq	0x578(%rsp), %r9
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x200, %rcx            # imm = 0x200
               	leaq	0x6a0(%rsp), %r13
               	leaq	0x20(%rsp), %r14
               	leaq	0x560(%rsp), %r15
               	movups	(%r14), %xmm14
               	movups	%xmm14, (%r15)
               	movups	0x10(%r14), %xmm14
               	movups	%xmm14, 0x10(%r15)
               	movq	0x560(%rsp), %r14
               	movq	0x568(%rsp), %r15
               	movq	0x570(%rsp), %r10
               	movq	%r10, -0xe8(%rbp)
               	movq	0x578(%rsp), %r10
               	movq	%r10, -0xf0(%rbp)
               	movq	%rax, 0x580(%rsp)
               	movq	%rdx, 0x588(%rsp)
               	movq	%rsi, 0x590(%rsp)
               	movq	%r9, 0x598(%rsp)
               	leaq	0x930(%rsp), %rax
               	movups	(%r13), %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r14, 0x5a0(%rsp)
               	movq	%r15, 0x5a8(%rsp)
               	movq	-0xe8(%rbp), %r10
               	movq	%r10, 0x5b0(%rsp)
               	movq	-0xf0(%rbp), %r10
               	movq	%r10, 0x5b8(%rsp)
               	leaq	0x580(%rsp), %rax
               	leaq	0x5c0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x5a0(%rsp), %rax
               	leaq	0x5e0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x600(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x930(%rsp), %rax
               	leaq	0x940(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	leaq	0x5c0(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	movq	%rdx, -0xa8(%rbp)
               	leaq	0x5e0(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0xa8(%rbp), %rdx
               	leaq	0x940(%rsp), %rsi
               	movslq	(%rsi,%rax,4), %rsi
               	shlq	%rsi
               	addq	%rcx, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	leaq	0x600(%rsp), %rdx
               	movq	-0xa8(%rbp), %rsi
               	movq	%rsi, (%rdx,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x600(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x220(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0xe0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x6c0(%rsp), %rsi
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
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x6a0(%rsp), %rdi
               	leaq	0x960(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x970(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x980(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x960(%rsp), %rcx
               	leaq	0x990(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x9a0(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x9b0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x9c0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0x990(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0xa0(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xa0(%rbp), %rsi
               	leaq	0x9c0(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	shlq	%rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0x9b0(%rsp), %rsi
               	movl	-0xa0(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x240(%rsp), %rax
               	movups	0x9b0(%rsp), %xmm0
               	movups	%xmm0, 0x240(%rsp)
               	leaq	0x6d0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x6d0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x6c0(%rsp), %rsi
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
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	(%rsp), %rdi
               	leaq	0x9d0(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x2c0(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x9e0(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x9d0(%rsp), %rcx
               	leaq	0x9f0(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xa00(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xa10(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x260(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	xorl	%eax, %eax
               	leaq	0x9f0(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0x98(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x98(%rbp), %rsi
               	leaq	0x260(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	shlq	%rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0xa10(%rsp), %rsi
               	movl	-0x98(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x240(%rsp), %rax
               	movups	0xa10(%rsp), %xmm0
               	movups	%xmm0, 0x240(%rsp)
               	leaq	0x6d0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x6d0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x6c0(%rsp), %rsi
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
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x6a0(%rsp), %rdi
               	leaq	0xa20(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xa30(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xa40(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xa20(%rsp), %rcx
               	leaq	0xa50(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xa60(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xa70(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xa80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0xa50(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	%rsi, -0x90(%rbp)
               	movq	(%rcx,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0x90(%rbp), %rsi
               	leaq	0xa80(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	shlq	%rdi
               	addq	%rdx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0xa70(%rsp), %rsi
               	movq	-0x90(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x240(%rsp), %rax
               	movups	0xa70(%rsp), %xmm0
               	movups	%xmm0, 0x240(%rsp)
               	leaq	0x6d0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x6d0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x240(%rsp), %rdi
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x200, %rcx            # imm = 0x200
               	leaq	(%rsp), %rdx
               	leaq	0x20(%rsp), %rsi
               	leaq	0x620(%rsp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x640(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x660(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x620(%rsp), %rdx
               	leaq	0x680(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x280(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x140(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x640(%rsp), %rax
               	leaq	0x160(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	xorl	%eax, %eax
               	leaq	0x680(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	leaq	0x280(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	leaq	0x160(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	shlq	%rsi
               	addq	%rcx, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	leaq	0x140(%rsp), %rdx
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, (%rdx,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x140(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x240(%rsp), %rax
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x240(%rsp), %r9
               	movups	0x6c0(%rsp), %xmm0
               	movups	%xmm0, 0x240(%rsp)
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x6a0(%rsp), %rax
               	movups	0x6b0(%rsp), %xmm0
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x220(%rsp), %rcx
               	movl	$0x2, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	callq	<addr>
               	movups	%xmm0, 0x240(%rsp)
               	leaq	0x240(%rsp), %rax
               	leaq	0x1e0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x1e0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x240(%rsp), %r9
               	movups	0x6c0(%rsp), %xmm0
               	movups	%xmm0, 0x240(%rsp)
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %rax
               	movups	0x6b0(%rsp), %xmm0
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x220(%rsp), %rcx
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
               	movups	%xmm0, 0x240(%rsp)
               	leaq	0x240(%rsp), %rax
               	leaq	0x1e0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x1e0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x240(%rsp), %r9
               	movups	0x6c0(%rsp), %xmm0
               	movups	%xmm0, 0x240(%rsp)
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x6a0(%rsp), %rax
               	movups	0x6b0(%rsp), %xmm0
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x220(%rsp), %rcx
               	movl	$0x2, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	callq	<addr>
               	movups	%xmm0, 0x240(%rsp)
               	leaq	0x240(%rsp), %rax
               	leaq	0x100(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x100(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x120(%rsp), %rdi
               	leaq	0x240(%rsp), %rdx
               	leaq	0x560(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x240(%rsp), %r9
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	(%rsp), %rax
               	leaq	0x220(%rsp), %rcx
               	leaq	0x20(%rsp), %rdx
               	leaq	0x560(%rsp), %r8
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x560(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x220(%rsp), %rcx
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
               	leaq	0x120(%rsp), %rax
               	leaq	0xe0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0xe0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x6c0(%rsp), %rsi
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
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x6a0(%rsp), %rdi
               	leaq	0x700(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x710(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x720(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x700(%rsp), %rcx
               	leaq	0x730(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x740(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x750(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x760(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0x730(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0xe0(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xe0(%rbp), %rsi
               	leaq	0x760(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	$0x2, %rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0x750(%rsp), %rsi
               	movl	-0xe0(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x240(%rsp), %rax
               	movups	0x750(%rsp), %xmm0
               	movups	%xmm0, 0x240(%rsp)
               	leaq	0x6d0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x6d0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x240(%rsp), %rdi
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x200, %rcx            # imm = 0x200
               	leaq	(%rsp), %rdx
               	leaq	0x20(%rsp), %rsi
               	leaq	0x2e0(%rsp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x300(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x320(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x2e0(%rsp), %rdx
               	leaq	0x340(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x360(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x380(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x300(%rsp), %rax
               	leaq	0x3a0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	xorl	%eax, %eax
               	leaq	0x340(%rsp), %rdx
               	movl	(%rdx,%rax,4), %edx
               	movl	%edx, -0xd8(%rbp)
               	leaq	0x360(%rsp), %rdx
               	movl	(%rdx,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0xd8(%rbp), %rdx
               	leaq	0x3a0(%rsp), %rsi
               	movslq	(%rsi,%rax,4), %rsi
               	shlq	$0x2, %rsi
               	addq	%rcx, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	leaq	0x380(%rsp), %rdx
               	movl	-0xd8(%rbp), %esi
               	movl	%esi, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x380(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x240(%rsp), %rax
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x6c0(%rsp), %rsi
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
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x6a0(%rsp), %rdi
               	leaq	0x7a0(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x7b0(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x7c0(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x7a0(%rsp), %rcx
               	leaq	0x7d0(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x7e0(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x7f0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x800(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0x7d0(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	%rsi, -0xd0(%rbp)
               	movq	(%rcx,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xd0(%rbp), %rsi
               	leaq	0x800(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	$0x2, %rdi
               	addq	%rdx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0x7f0(%rsp), %rsi
               	movq	-0xd0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x240(%rsp), %rax
               	movups	0x7f0(%rsp), %xmm0
               	movups	%xmm0, 0x240(%rsp)
               	leaq	0x6d0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x6d0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x240(%rsp), %rdi
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x200, %rcx            # imm = 0x200
               	leaq	0x6a0(%rsp), %rdx
               	leaq	0x20(%rsp), %rsi
               	leaq	0x3e0(%rsp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x840(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x400(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x3e0(%rsp), %rdx
               	leaq	0x420(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x440(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x460(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x840(%rsp), %rax
               	leaq	0x850(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	leaq	0x420(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	movq	%rdx, -0xc8(%rbp)
               	leaq	0x440(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0xc8(%rbp), %rdx
               	leaq	0x850(%rsp), %rsi
               	movslq	(%rsi,%rax,4), %rsi
               	shlq	$0x2, %rsi
               	addq	%rcx, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	leaq	0x460(%rsp), %rdx
               	movq	-0xc8(%rbp), %rsi
               	movq	%rsi, (%rdx,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x460(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x240(%rsp), %rax
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	movups	0x6c0(%rsp), %xmm0
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x6a0(%rsp), %rdx
               	movups	0x6b0(%rsp), %xmm1
               	leaq	0x870(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x880(%rsp), %rdx
               	movups	%xmm0, 0x880(%rsp)
               	movups	%xmm1, 0x890(%rsp)
               	leaq	0x8a0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x8b0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movl	(%rdx,%rax,4), %esi
               	movl	%esi, -0xc0(%rbp)
               	leaq	0x890(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xc0(%rbp), %rsi
               	leaq	0x8b0(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	$0x2, %rdi
               	addq	%rcx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0x8a0(%rsp), %rsi
               	movl	-0xc0(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x240(%rsp), %rax
               	movups	0x8a0(%rsp), %xmm0
               	movups	%xmm0, 0x240(%rsp)
               	leaq	0xc0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xc0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x240(%rsp), %rdi
               	movq	0x40(%rsp), %rax
               	movq	0x48(%rsp), %rdx
               	movq	0x50(%rsp), %rsi
               	movq	0x58(%rsp), %r8
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x200, %rcx            # imm = 0x200
               	leaq	(%rsp), %r9
               	movq	0x20(%rsp), %r13
               	movq	0x28(%rsp), %r14
               	movq	0x30(%rsp), %r15
               	movq	0x38(%rsp), %r10
               	movq	%r10, -0xe8(%rbp)
               	movq	%rax, 0x480(%rsp)
               	movq	%rdx, 0x488(%rsp)
               	movq	%rsi, 0x490(%rsp)
               	movq	%r8, 0x498(%rsp)
               	leaq	0x4a0(%rsp), %rax
               	movups	(%r9), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%r9), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movq	%r13, 0x4c0(%rsp)
               	movq	%r14, 0x4c8(%rsp)
               	movq	%r15, 0x4d0(%rsp)
               	movq	-0xe8(%rbp), %r10
               	movq	%r10, 0x4d8(%rsp)
               	leaq	0x480(%rsp), %rax
               	leaq	0x4e0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x500(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x520(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x4a0(%rsp), %rax
               	leaq	0x540(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	xorl	%eax, %eax
               	leaq	0x4e0(%rsp), %rdx
               	movl	(%rdx,%rax,4), %edx
               	movl	%edx, -0xb8(%rbp)
               	leaq	0x500(%rsp), %rdx
               	movl	(%rdx,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0xb8(%rbp), %rdx
               	leaq	0x540(%rsp), %rsi
               	movslq	(%rsi,%rax,4), %rsi
               	shlq	$0x2, %rsi
               	addq	%rcx, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	leaq	0x520(%rsp), %rdx
               	movl	-0xb8(%rbp), %esi
               	movl	%esi, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x520(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x240(%rsp), %rax
               	leaq	0x100(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x100(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	movups	0x6c0(%rsp), %xmm0
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x6a0(%rsp), %rdx
               	movups	0x6b0(%rsp), %xmm1
               	leaq	0x8d0(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x8e0(%rsp), %rdx
               	movups	%xmm0, 0x8e0(%rsp)
               	movups	%xmm1, 0x8f0(%rsp)
               	leaq	0x900(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x910(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movq	(%rdx,%rax,8), %rsi
               	movq	%rsi, -0xb0(%rbp)
               	leaq	0x8f0(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xb0(%rbp), %rsi
               	leaq	0x910(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	$0x2, %rdi
               	addq	%rcx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0x900(%rsp), %rsi
               	movq	-0xb0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x240(%rsp), %rax
               	movups	0x900(%rsp), %xmm0
               	movups	%xmm0, 0x240(%rsp)
               	leaq	0x200(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x200(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x240(%rsp), %rdi
               	leaq	0x560(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movq	0x560(%rsp), %rax
               	movq	0x568(%rsp), %rdx
               	movq	0x570(%rsp), %rsi
               	movq	0x578(%rsp), %r8
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x200, %rcx            # imm = 0x200
               	leaq	0x6a0(%rsp), %r9
               	leaq	0x20(%rsp), %r13
               	leaq	0x560(%rsp), %r14
               	movups	(%r13), %xmm14
               	movups	%xmm14, (%r14)
               	movups	0x10(%r13), %xmm14
               	movups	%xmm14, 0x10(%r14)
               	movq	0x560(%rsp), %r13
               	movq	0x568(%rsp), %r14
               	movq	0x570(%rsp), %r15
               	movq	0x578(%rsp), %r10
               	movq	%r10, -0xe8(%rbp)
               	movq	%rax, 0x580(%rsp)
               	movq	%rdx, 0x588(%rsp)
               	movq	%rsi, 0x590(%rsp)
               	movq	%r8, 0x598(%rsp)
               	leaq	0x930(%rsp), %rax
               	movups	(%r9), %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r13, 0x5a0(%rsp)
               	movq	%r14, 0x5a8(%rsp)
               	movq	%r15, 0x5b0(%rsp)
               	movq	-0xe8(%rbp), %r10
               	movq	%r10, 0x5b8(%rsp)
               	leaq	0x580(%rsp), %rax
               	leaq	0x5c0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x5a0(%rsp), %rax
               	leaq	0x5e0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x600(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x930(%rsp), %rax
               	leaq	0x940(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	leaq	0x5c0(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	movq	%rdx, -0xa8(%rbp)
               	leaq	0x5e0(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0xa8(%rbp), %rdx
               	leaq	0x940(%rsp), %rsi
               	movslq	(%rsi,%rax,4), %rsi
               	shlq	$0x2, %rsi
               	addq	%rcx, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	leaq	0x600(%rsp), %rdx
               	movq	-0xa8(%rbp), %rsi
               	movq	%rsi, (%rdx,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x600(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x240(%rsp), %rax
               	leaq	0xe0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0xe0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x6c0(%rsp), %rsi
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
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x6a0(%rsp), %rdi
               	leaq	0x960(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x970(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x980(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x960(%rsp), %rcx
               	leaq	0x990(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x9a0(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x9b0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x9c0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0x990(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0xa0(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xa0(%rbp), %rsi
               	leaq	0x9c0(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	shlq	$0x2, %rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0x9b0(%rsp), %rsi
               	movl	-0xa0(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x240(%rsp), %rax
               	movups	0x9b0(%rsp), %xmm0
               	movups	%xmm0, 0x240(%rsp)
               	leaq	0x6d0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x6d0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x6c0(%rsp), %rsi
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
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	(%rsp), %rdi
               	leaq	0x9d0(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x2c0(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x9e0(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x9d0(%rsp), %rcx
               	leaq	0x9f0(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xa00(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xa10(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x260(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	xorl	%eax, %eax
               	leaq	0x9f0(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0x98(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x98(%rbp), %rsi
               	leaq	0x260(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	shlq	$0x2, %rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0xa10(%rsp), %rsi
               	movl	-0x98(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x240(%rsp), %rax
               	movups	0xa10(%rsp), %xmm0
               	movups	%xmm0, 0x240(%rsp)
               	leaq	0x6d0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x6d0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x6c0(%rsp), %rsi
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
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x6a0(%rsp), %rdi
               	leaq	0xa20(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xa30(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xa40(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xa20(%rsp), %rcx
               	leaq	0xa50(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xa60(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xa70(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xa80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0xa50(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	%rsi, -0x90(%rbp)
               	movq	(%rcx,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0x90(%rbp), %rsi
               	leaq	0xa80(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	shlq	$0x2, %rdi
               	addq	%rdx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0xa70(%rsp), %rsi
               	movq	-0x90(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x240(%rsp), %rax
               	movups	0xa70(%rsp), %xmm0
               	movups	%xmm0, 0x240(%rsp)
               	leaq	0x6d0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x6d0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x240(%rsp), %rdi
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x200, %rcx            # imm = 0x200
               	leaq	(%rsp), %rdx
               	leaq	0x20(%rsp), %rsi
               	leaq	0x620(%rsp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x640(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x660(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x620(%rsp), %rdx
               	leaq	0x680(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x280(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x140(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x640(%rsp), %rax
               	leaq	0x160(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	xorl	%eax, %eax
               	leaq	0x680(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	leaq	0x280(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	leaq	0x160(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	shlq	$0x2, %rsi
               	addq	%rcx, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	leaq	0x140(%rsp), %rdx
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, (%rdx,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x140(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x240(%rsp), %rax
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x240(%rsp), %r9
               	movups	0x6c0(%rsp), %xmm0
               	movups	%xmm0, 0x240(%rsp)
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x6a0(%rsp), %rax
               	movups	0x6b0(%rsp), %xmm0
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x220(%rsp), %rcx
               	movl	$0x4, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	callq	<addr>
               	movups	%xmm0, 0x240(%rsp)
               	leaq	0x240(%rsp), %rax
               	leaq	0xc0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xc0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x240(%rsp), %r9
               	movups	0x6c0(%rsp), %xmm0
               	movups	%xmm0, 0x240(%rsp)
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %rax
               	movups	0x6b0(%rsp), %xmm0
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x220(%rsp), %rcx
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
               	movups	%xmm0, 0x240(%rsp)
               	leaq	0x240(%rsp), %rax
               	leaq	0xc0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xc0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x240(%rsp), %r9
               	movups	0x6c0(%rsp), %xmm0
               	movups	%xmm0, 0x240(%rsp)
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x6a0(%rsp), %rax
               	movups	0x6b0(%rsp), %xmm0
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x220(%rsp), %rcx
               	movl	$0x4, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	callq	<addr>
               	movups	%xmm0, 0x240(%rsp)
               	leaq	0x240(%rsp), %rax
               	leaq	0x200(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x200(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x120(%rsp), %rdi
               	leaq	0x240(%rsp), %rdx
               	leaq	0x560(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x240(%rsp), %r9
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	(%rsp), %rax
               	leaq	0x220(%rsp), %rcx
               	leaq	0x20(%rsp), %rdx
               	leaq	0x560(%rsp), %r8
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x560(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x220(%rsp), %rcx
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
               	leaq	0x120(%rsp), %rax
               	leaq	0xe0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0xe0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x6c0(%rsp), %rsi
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
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x6a0(%rsp), %rdi
               	leaq	0x700(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x710(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x720(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x700(%rsp), %rcx
               	leaq	0x730(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x740(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x750(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x760(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0x730(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0xe0(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xe0(%rbp), %rsi
               	leaq	0x760(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	$0x3, %rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0x750(%rsp), %rsi
               	movl	-0xe0(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x240(%rsp), %rax
               	movups	0x750(%rsp), %xmm0
               	movups	%xmm0, 0x240(%rsp)
               	leaq	0x6d0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x6d0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x240(%rsp), %rdi
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x200, %rcx            # imm = 0x200
               	leaq	(%rsp), %rdx
               	leaq	0x20(%rsp), %rsi
               	leaq	0x2e0(%rsp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x300(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x320(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x2e0(%rsp), %rdx
               	leaq	0x340(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x360(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x380(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x300(%rsp), %rax
               	leaq	0x3a0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	xorl	%eax, %eax
               	leaq	0x340(%rsp), %rdx
               	movl	(%rdx,%rax,4), %edx
               	movl	%edx, -0xd8(%rbp)
               	leaq	0x360(%rsp), %rdx
               	movl	(%rdx,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0xd8(%rbp), %rdx
               	leaq	0x3a0(%rsp), %rsi
               	movslq	(%rsi,%rax,4), %rsi
               	shlq	$0x3, %rsi
               	addq	%rcx, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	leaq	0x380(%rsp), %rdx
               	movl	-0xd8(%rbp), %esi
               	movl	%esi, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x380(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x240(%rsp), %rax
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x6c0(%rsp), %rsi
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
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x6a0(%rsp), %rdi
               	leaq	0x7a0(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x7b0(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x7c0(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x7a0(%rsp), %rcx
               	leaq	0x7d0(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x7e0(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x7f0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x800(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0x7d0(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	%rsi, -0xd0(%rbp)
               	movq	(%rcx,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xd0(%rbp), %rsi
               	leaq	0x800(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	$0x3, %rdi
               	addq	%rdx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0x7f0(%rsp), %rsi
               	movq	-0xd0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x240(%rsp), %rax
               	movups	0x7f0(%rsp), %xmm0
               	movups	%xmm0, 0x240(%rsp)
               	leaq	0x6d0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x6d0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x240(%rsp), %rdi
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x200, %rcx            # imm = 0x200
               	leaq	0x6a0(%rsp), %rdx
               	leaq	0x20(%rsp), %rsi
               	leaq	0x3e0(%rsp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x840(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x400(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x3e0(%rsp), %rdx
               	leaq	0x420(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x440(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x460(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x840(%rsp), %rax
               	leaq	0x850(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	leaq	0x420(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	movq	%rdx, -0xc8(%rbp)
               	leaq	0x440(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0xc8(%rbp), %rdx
               	leaq	0x850(%rsp), %rsi
               	movslq	(%rsi,%rax,4), %rsi
               	shlq	$0x3, %rsi
               	addq	%rcx, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	leaq	0x460(%rsp), %rdx
               	movq	-0xc8(%rbp), %rsi
               	movq	%rsi, (%rdx,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x460(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x240(%rsp), %rax
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	movups	0x6c0(%rsp), %xmm0
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x6a0(%rsp), %rdx
               	movups	0x6b0(%rsp), %xmm1
               	leaq	0x870(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x880(%rsp), %rdx
               	movups	%xmm0, 0x880(%rsp)
               	movups	%xmm1, 0x890(%rsp)
               	leaq	0x8a0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x8b0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movl	(%rdx,%rax,4), %esi
               	movl	%esi, -0xc0(%rbp)
               	leaq	0x890(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xc0(%rbp), %rsi
               	leaq	0x8b0(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	$0x3, %rdi
               	addq	%rcx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0x8a0(%rsp), %rsi
               	movl	-0xc0(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x240(%rsp), %rax
               	movups	0x8a0(%rsp), %xmm0
               	movups	%xmm0, 0x240(%rsp)
               	leaq	0x200(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x200(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x240(%rsp), %rdi
               	movq	0x40(%rsp), %rax
               	movq	0x48(%rsp), %rdx
               	movq	0x50(%rsp), %rsi
               	movq	0x58(%rsp), %r8
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x200, %rcx            # imm = 0x200
               	leaq	(%rsp), %r9
               	movq	0x20(%rsp), %r13
               	movq	0x28(%rsp), %r14
               	movq	0x30(%rsp), %r15
               	movq	0x38(%rsp), %r10
               	movq	%r10, -0xe8(%rbp)
               	movq	%rax, 0x480(%rsp)
               	movq	%rdx, 0x488(%rsp)
               	movq	%rsi, 0x490(%rsp)
               	movq	%r8, 0x498(%rsp)
               	leaq	0x4a0(%rsp), %rax
               	movups	(%r9), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%r9), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movq	%r13, 0x4c0(%rsp)
               	movq	%r14, 0x4c8(%rsp)
               	movq	%r15, 0x4d0(%rsp)
               	movq	-0xe8(%rbp), %r10
               	movq	%r10, 0x4d8(%rsp)
               	leaq	0x480(%rsp), %rax
               	leaq	0x4e0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x4c0(%rsp), %rax
               	leaq	0x500(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x520(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x4a0(%rsp), %rax
               	leaq	0x540(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	xorl	%eax, %eax
               	leaq	0x4e0(%rsp), %rdx
               	movl	(%rdx,%rax,4), %edx
               	movl	%edx, -0xb8(%rbp)
               	leaq	0x500(%rsp), %rdx
               	movl	(%rdx,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0xb8(%rbp), %rdx
               	leaq	0x540(%rsp), %rsi
               	movslq	(%rsi,%rax,4), %rsi
               	shlq	$0x3, %rsi
               	addq	%rcx, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	leaq	0x520(%rsp), %rdx
               	movl	-0xb8(%rbp), %esi
               	movl	%esi, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x520(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x240(%rsp), %rax
               	leaq	0xe0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0xe0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	movups	0x6c0(%rsp), %xmm0
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x6a0(%rsp), %rdx
               	movups	0x6b0(%rsp), %xmm1
               	leaq	0x8d0(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x8e0(%rsp), %rdx
               	movups	%xmm0, 0x8e0(%rsp)
               	movups	%xmm1, 0x8f0(%rsp)
               	leaq	0x900(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x910(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movq	(%rdx,%rax,8), %rsi
               	movq	%rsi, -0xb0(%rbp)
               	leaq	0x8f0(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xb0(%rbp), %rsi
               	leaq	0x910(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	$0x3, %rdi
               	addq	%rcx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0x900(%rsp), %rsi
               	movq	-0xb0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x240(%rsp), %rax
               	movups	0x900(%rsp), %xmm0
               	movups	%xmm0, 0x240(%rsp)
               	leaq	0x100(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x100(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x240(%rsp), %rdi
               	leaq	0x560(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movq	0x560(%rsp), %rax
               	movq	0x568(%rsp), %rdx
               	movq	0x570(%rsp), %rsi
               	movq	0x578(%rsp), %r8
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x200, %rcx            # imm = 0x200
               	leaq	0x6a0(%rsp), %r9
               	leaq	0x20(%rsp), %r13
               	leaq	0x560(%rsp), %r14
               	movups	(%r13), %xmm14
               	movups	%xmm14, (%r14)
               	movups	0x10(%r13), %xmm14
               	movups	%xmm14, 0x10(%r14)
               	movq	0x560(%rsp), %r13
               	movq	0x568(%rsp), %r14
               	movq	0x570(%rsp), %r15
               	movq	0x578(%rsp), %r10
               	movq	%r10, -0xe8(%rbp)
               	movq	%rax, 0x580(%rsp)
               	movq	%rdx, 0x588(%rsp)
               	movq	%rsi, 0x590(%rsp)
               	movq	%r8, 0x598(%rsp)
               	leaq	0x930(%rsp), %rax
               	movups	(%r9), %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r13, 0x5a0(%rsp)
               	movq	%r14, 0x5a8(%rsp)
               	movq	%r15, 0x5b0(%rsp)
               	movq	-0xe8(%rbp), %r10
               	movq	%r10, 0x5b8(%rsp)
               	leaq	0x580(%rsp), %rax
               	leaq	0x5c0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x5a0(%rsp), %rax
               	leaq	0x5e0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x600(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x930(%rsp), %rax
               	leaq	0x940(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	leaq	0x5c0(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	movq	%rdx, -0xa8(%rbp)
               	leaq	0x5e0(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0xa8(%rbp), %rdx
               	leaq	0x940(%rsp), %rsi
               	movslq	(%rsi,%rax,4), %rsi
               	shlq	$0x3, %rsi
               	addq	%rcx, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	leaq	0x600(%rsp), %rdx
               	movq	-0xa8(%rbp), %rsi
               	movq	%rsi, (%rdx,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x600(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x240(%rsp), %rax
               	leaq	0x120(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x120(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x6c0(%rsp), %rsi
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
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x6a0(%rsp), %rdi
               	leaq	0x960(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x970(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x980(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x960(%rsp), %rcx
               	leaq	0x990(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x9a0(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x9b0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x9c0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0x990(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0xa0(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xa0(%rbp), %rsi
               	leaq	0x9c0(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	shlq	$0x3, %rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0x9b0(%rsp), %rsi
               	movl	-0xa0(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x240(%rsp), %rax
               	movups	0x9b0(%rsp), %xmm0
               	movups	%xmm0, 0x240(%rsp)
               	leaq	0x6d0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x6d0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x6c0(%rsp), %rsi
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
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	(%rsp), %rdi
               	leaq	0x9d0(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x2c0(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x9e0(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x9d0(%rsp), %rcx
               	leaq	0x9f0(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xa00(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xa10(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x260(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	xorl	%eax, %eax
               	leaq	0x9f0(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0x98(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x98(%rbp), %rsi
               	leaq	0x260(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	shlq	$0x3, %rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0xa10(%rsp), %rsi
               	movl	-0x98(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x2c0(%rsp), %rax
               	movups	0xa10(%rsp), %xmm0
               	movups	%xmm0, 0x2c0(%rsp)
               	leaq	0x6d0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x6d0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rcx
               	leaq	0x20(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x6c0(%rsp), %rsi
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
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x6a0(%rsp), %rdi
               	leaq	0xa20(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xa30(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xa40(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xa20(%rsp), %rcx
               	leaq	0xa50(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xa60(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xa70(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xa80(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0xa50(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	%rsi, -0x90(%rbp)
               	movq	(%rcx,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0x90(%rbp), %rsi
               	leaq	0xa80(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	shlq	$0x3, %rdi
               	addq	%rdx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0xa70(%rsp), %rsi
               	movq	-0x90(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x2c0(%rsp), %rax
               	movups	0xa70(%rsp), %xmm0
               	movups	%xmm0, 0x2c0(%rsp)
               	leaq	0x6d0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x6d0(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x260(%rsp), %rdi
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x200, %rcx            # imm = 0x200
               	leaq	(%rsp), %rdx
               	leaq	0x20(%rsp), %rsi
               	leaq	0x620(%rsp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x640(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x660(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x620(%rsp), %rdx
               	leaq	0x680(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x280(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x140(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x640(%rsp), %rax
               	leaq	0x160(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	xorl	%eax, %eax
               	leaq	0x680(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	leaq	0x280(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	leaq	0x160(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	shlq	$0x3, %rsi
               	addq	%rcx, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	leaq	0x140(%rsp), %rdx
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, (%rdx,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x140(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x260(%rsp), %rax
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x140(%rsp), %r9
               	movups	0x6c0(%rsp), %xmm0
               	movups	%xmm0, 0x140(%rsp)
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x6a0(%rsp), %rax
               	movups	0x6b0(%rsp), %xmm0
               	movups	%xmm0, 0x160(%rsp)
               	leaq	0x160(%rsp), %rcx
               	movl	$0x8, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	callq	<addr>
               	movups	%xmm0, 0x140(%rsp)
               	leaq	0x140(%rsp), %rax
               	leaq	0x200(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x200(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x140(%rsp), %r9
               	movups	0x6c0(%rsp), %xmm0
               	movups	%xmm0, 0x140(%rsp)
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	(%rsp), %rax
               	movups	0x6b0(%rsp), %xmm0
               	movups	%xmm0, 0x160(%rsp)
               	leaq	0x160(%rsp), %rcx
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
               	movups	%xmm0, 0x140(%rsp)
               	leaq	0x140(%rsp), %rax
               	leaq	0x200(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x200(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x140(%rsp), %r9
               	movups	0x6c0(%rsp), %xmm0
               	movups	%xmm0, 0x140(%rsp)
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x6a0(%rsp), %rax
               	movups	0x6b0(%rsp), %xmm0
               	movups	%xmm0, 0x160(%rsp)
               	leaq	0x160(%rsp), %rcx
               	movl	$0x8, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	callq	<addr>
               	movups	%xmm0, 0x140(%rsp)
               	leaq	0x140(%rsp), %rax
               	leaq	0x100(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x100(%rsp), %rdi
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
               	leaq	0x6a0(%rsp), %rcx
               	leaq	-0x80(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x6b0(%rsp), %rdx
               	leaq	0x20(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x6c0(%rsp), %rcx
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
               	leaq	0x280(%rsp), %rdi
               	leaq	0x140(%rsp), %rdx
               	leaq	0x560(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x140(%rsp), %r9
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	(%rsp), %rax
               	leaq	0x160(%rsp), %rcx
               	leaq	0x20(%rsp), %rdx
               	leaq	0x560(%rsp), %r8
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x560(%rsp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x160(%rsp), %rcx
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
               	leaq	0x280(%rsp), %rax
               	leaq	0x120(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x120(%rsp), %rdi
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
               	leaq	-0x130(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	0x160(%rsp), %rdi
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
               	leaq	0x160(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x6a0(%rsp), %r9
               	movl	$0x8, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, 0x160(%rsp)
               	leaq	0x160(%rsp), %rax
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
               	movups	%xmm0, 0x160(%rsp)
               	leaq	0x160(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x6a0(%rsp), %r9
               	movl	$0x8, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, 0x160(%rsp)
               	leaq	0x160(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	0x160(%rsp), %rdi
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
               	leaq	0x160(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x6a0(%rsp), %r9
               	movl	$0x8, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, 0x260(%rsp)
               	leaq	0x260(%rsp), %rax
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
               	movups	%xmm0, 0x260(%rsp)
               	leaq	0x260(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x6a0(%rsp), %r9
               	movl	$0x8, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x220(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	0x220(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	0x6a0(%rsp), %r9
               	movl	$0x8, %edx
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	0x220(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x6a0(%rsp), %r9
               	movl	$0x8, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x220(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	0x220(%rsp), %rdi
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
               	leaq	0x220(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x6a0(%rsp), %r9
               	movl	$0x8, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x220(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	0x220(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	0x6a0(%rsp), %r9
               	movl	$0x8, %edx
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	0x220(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x6a0(%rsp), %r9
               	movl	$0x8, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x220(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	0x220(%rsp), %rdi
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
               	leaq	0x220(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x6a0(%rsp), %r9
               	movl	$0x8, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x220(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	0x220(%rsp), %rdi
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
               	leaq	0x220(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x6a0(%rsp), %r9
               	movl	$0x4, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x220(%rsp), %rax
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
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x220(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x6a0(%rsp), %r9
               	movl	$0x4, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x220(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	0x220(%rsp), %rdi
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
               	leaq	0x220(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x6a0(%rsp), %r9
               	movl	$0x4, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x220(%rsp), %rax
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
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x220(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x6a0(%rsp), %r9
               	movl	$0x4, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x220(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	0x220(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	0x6a0(%rsp), %r9
               	movl	$0x4, %edx
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	0x220(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x6a0(%rsp), %r9
               	movl	$0x4, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x220(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	0x220(%rsp), %rdi
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
               	leaq	0x220(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x6a0(%rsp), %r9
               	movl	$0x4, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x220(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	0x220(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rsi
               	leaq	0x6a0(%rsp), %r9
               	movl	$0x4, %edx
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	0x220(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x6a0(%rsp), %r9
               	movl	$0x4, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x220(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	0x220(%rsp), %rdi
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
               	leaq	0x220(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x6a0(%rsp), %r9
               	movl	$0x4, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x220(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	0x220(%rsp), %rdi
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
               	leaq	0x220(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x6a0(%rsp), %r9
               	movl	$0x2, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x220(%rsp), %rax
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
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x220(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x6a0(%rsp), %r9
               	movl	$0x2, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x220(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	0x220(%rsp), %rdi
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
               	leaq	0x220(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x6a0(%rsp), %r9
               	movl	$0x2, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x220(%rsp), %rax
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
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x220(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x6a0(%rsp), %r9
               	movl	$0x2, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x220(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x6a0(%rsp), %rax
               	leaq	0x950(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x240(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	$-0x1, 0x240(%rsp)
               	movq	$-0x1, 0x248(%rsp)
               	movq	$-0x1, 0x250(%rsp)
               	movq	$-0x1, 0x258(%rsp)
               	leaq	0x220(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x240(%rsp), %rsi
               	leaq	0x580(%rsp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x930(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x5a0(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x580(%rsp), %rdx
               	leaq	0x5c0(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x5e0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x600(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x930(%rsp), %rax
               	leaq	0x940(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	leaq	0x5c0(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	movq	%rdx, -0xa8(%rbp)
               	leaq	0x5e0(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0xa8(%rbp), %rdx
               	leaq	0x940(%rsp), %rsi
               	movslq	(%rsi,%rax,4), %rsi
               	shlq	%rsi
               	addq	%rcx, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	leaq	0x600(%rsp), %rdx
               	movq	-0xa8(%rbp), %rsi
               	movq	%rsi, (%rdx,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	0x600(%rsp), %rax
               	movq	0x608(%rsp), %rcx
               	movq	0x610(%rsp), %rdx
               	movq	0x618(%rsp), %rsi
               	movq	%rax, 0x120(%rsp)
               	movq	%rcx, 0x128(%rsp)
               	movq	%rdx, 0x130(%rsp)
               	movq	%rsi, 0x138(%rsp)
               	leaq	0x120(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x6a0(%rsp), %rdx
               	leaq	0x920(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%esi, %esi
               	movq	$-0x1, %rdx
               	vmovq	%rdx, %xmm0
               	vpinsrq	$0x1, %rdx, %xmm0, %xmm0
               	leaq	0x8d0(%rsp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x8e0(%rsp), %rdx
               	movq	%rsi, %xmm14
               	movups	%xmm14, 0x8e0(%rsp)
               	movups	%xmm0, 0x8f0(%rsp)
               	leaq	0x900(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x910(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movq	(%rdx,%rax,8), %rsi
               	movq	%rsi, -0xb0(%rbp)
               	leaq	0x8f0(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xb0(%rbp), %rsi
               	leaq	0x910(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	%rdi
               	addq	%rcx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0x900(%rsp), %rsi
               	movq	-0xb0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0x900(%rsp), %xmm0
               	leaq	0x120(%rsp), %rax
               	movups	%xmm0, 0x120(%rsp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	(%rsp), %rax
               	leaq	0x100(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0xe0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movl	$0xffffffff, 0xe0(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xe4(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xe8(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xec(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xf0(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xf4(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xf8(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xfc(%rsp) # imm = 0xFFFFFFFF
               	leaq	0x120(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0xe0(%rsp), %rsi
               	leaq	0x480(%rsp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x4a0(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x4c0(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x480(%rsp), %rdx
               	leaq	0x4e0(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x500(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x520(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x4a0(%rsp), %rax
               	leaq	0x540(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	xorl	%eax, %eax
               	leaq	0x4e0(%rsp), %rdx
               	movl	(%rdx,%rax,4), %edx
               	movl	%edx, -0xb8(%rbp)
               	leaq	0x500(%rsp), %rdx
               	movl	(%rdx,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0xb8(%rbp), %rdx
               	leaq	0x540(%rsp), %rsi
               	movslq	(%rsi,%rax,4), %rsi
               	shlq	%rsi
               	addq	%rcx, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	leaq	0x520(%rsp), %rdx
               	movl	-0xb8(%rbp), %esi
               	movl	%esi, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	0x520(%rsp), %rax
               	movq	0x528(%rsp), %rcx
               	movq	0x530(%rsp), %rdx
               	movq	0x538(%rsp), %rsi
               	movq	%rax, 0x200(%rsp)
               	movq	%rcx, 0x208(%rsp)
               	movq	%rdx, 0x210(%rsp)
               	movq	%rsi, 0x218(%rsp)
               	leaq	0x200(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x6a0(%rsp), %rax
               	leaq	0x8c0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%esi, %esi
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	vmovd	%eax, %xmm0
               	vpinsrd	$0x1, %eax, %xmm0, %xmm0
               	vpinsrd	$0x2, %eax, %xmm0, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	leaq	0x870(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x880(%rsp), %rdx
               	movq	%rsi, %xmm14
               	movups	%xmm14, 0x880(%rsp)
               	movups	%xmm0, 0x890(%rsp)
               	leaq	0x8a0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x8b0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movl	(%rdx,%rax,4), %esi
               	movl	%esi, -0xc0(%rbp)
               	leaq	0x890(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xc0(%rbp), %rsi
               	leaq	0x8b0(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	%rdi
               	addq	%rcx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0x8a0(%rsp), %rsi
               	movl	-0xc0(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	0x8a0(%rsp), %xmm0
               	leaq	0x200(%rsp), %rax
               	movups	%xmm0, 0x200(%rsp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x6a0(%rsp), %rax
               	leaq	0x860(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0xc0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	$-0x1, 0xc0(%rsp)
               	movq	$-0x1, 0xc8(%rsp)
               	movq	$-0x1, 0xd0(%rsp)
               	movq	$-0x1, 0xd8(%rsp)
               	leaq	0x200(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0xc0(%rsp), %rsi
               	leaq	0x3e0(%rsp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x840(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x400(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x3e0(%rsp), %rdx
               	leaq	0x420(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x440(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x460(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x840(%rsp), %rax
               	leaq	0x850(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	leaq	0x420(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	movq	%rdx, -0xc8(%rbp)
               	leaq	0x440(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0xc8(%rbp), %rdx
               	leaq	0x850(%rsp), %rsi
               	movslq	(%rsi,%rax,4), %rsi
               	shlq	%rsi
               	addq	%rcx, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	leaq	0x460(%rsp), %rdx
               	movq	-0xc8(%rbp), %rsi
               	movq	%rsi, (%rdx,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	0x460(%rsp), %rax
               	movq	0x468(%rsp), %rcx
               	movq	0x470(%rsp), %rdx
               	movq	0x478(%rsp), %rsi
               	movq	%rax, 0x1e0(%rsp)
               	movq	%rcx, 0x1e8(%rsp)
               	movq	%rdx, 0x1f0(%rsp)
               	movq	%rsi, 0x1f8(%rsp)
               	leaq	0x1e0(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x6a0(%rsp), %rcx
               	leaq	0x810(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x820(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	$-0x1, 0x820(%rsp)
               	movq	$-0x1, 0x828(%rsp)
               	leaq	0x830(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x7a0(%rsp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x7b0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x7c0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x7a0(%rsp), %rcx
               	leaq	0x7d0(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x7e0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x7f0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x800(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	leaq	0x7d0(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	%rsi, -0xd0(%rbp)
               	movq	(%rcx,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xd0(%rbp), %rsi
               	leaq	0x800(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	%rdi
               	addq	%rdx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0x7f0(%rsp), %rsi
               	movq	-0xd0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0x7f0(%rsp), %xmm0
               	leaq	0x1e0(%rsp), %rax
               	movups	%xmm0, 0x1e0(%rsp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	(%rsp), %rax
               	leaq	0x3c0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x2a0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movl	$0xffffffff, 0x2a0(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x2a4(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x2a8(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x2ac(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x2b0(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x2b4(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x2b8(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x2bc(%rsp) # imm = 0xFFFFFFFF
               	leaq	0x1e0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x2a0(%rsp), %rsi
               	leaq	0x2e0(%rsp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x300(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x320(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x2e0(%rsp), %rdx
               	leaq	0x340(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x360(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x380(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x300(%rsp), %rax
               	leaq	0x3a0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	xorl	%eax, %eax
               	leaq	0x340(%rsp), %rdx
               	movl	(%rdx,%rax,4), %edx
               	movl	%edx, -0xd8(%rbp)
               	leaq	0x360(%rsp), %rdx
               	movl	(%rdx,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0xd8(%rbp), %rdx
               	leaq	0x3a0(%rsp), %rsi
               	movslq	(%rsi,%rax,4), %rsi
               	shlq	%rsi
               	addq	%rcx, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	leaq	0x380(%rsp), %rdx
               	movl	-0xd8(%rbp), %esi
               	movl	%esi, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	0x380(%rsp), %rax
               	movq	0x388(%rsp), %rcx
               	movq	0x390(%rsp), %rdx
               	movq	0x398(%rsp), %rsi
               	movq	%rax, 0x1a0(%rsp)
               	movq	%rcx, 0x1a8(%rsp)
               	movq	%rdx, 0x1b0(%rsp)
               	movq	%rsi, 0x1b8(%rsp)
               	leaq	0x1a0(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x6a0(%rsp), %rax
               	leaq	0x770(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x780(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movl	$0xffffffff, 0x780(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x784(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x788(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x78c(%rsp) # imm = 0xFFFFFFFF
               	leaq	0x790(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x700(%rsp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x710(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x720(%rsp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x700(%rsp), %rcx
               	leaq	0x730(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x740(%rsp), %rcx
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x750(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x760(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0x730(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0xe0(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xe0(%rbp), %rsi
               	leaq	0x760(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	%rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0x750(%rsp), %rsi
               	movl	-0xe0(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	0x750(%rsp), %xmm0
               	leaq	0x1a0(%rsp), %rax
               	movups	%xmm0, 0x1a0(%rsp)
               	jmp	<addr>
               	movl	$0x2, %eax
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
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x6a0(%rsp), %r9
               	movl	$0x1, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, 0x1a0(%rsp)
               	leaq	0x1a0(%rsp), %rax
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
               	movups	%xmm0, 0x1a0(%rsp)
               	leaq	0x1a0(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdi
               	leaq	0x6a0(%rsp), %r9
               	movl	$0x1, %esi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	%xmm0, 0x1a0(%rsp)
               	leaq	0x1a0(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	(%rsp), %rax
               	leaq	0x280(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x140(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	$-0x1, 0x140(%rsp)
               	movq	$-0x1, 0x148(%rsp)
               	movq	$-0x1, 0x150(%rsp)
               	movq	$-0x1, 0x158(%rsp)
               	leaq	0x160(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x140(%rsp), %rsi
               	leaq	0x620(%rsp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x640(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x660(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x620(%rsp), %rdx
               	leaq	0x680(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x280(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x140(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x640(%rsp), %rax
               	leaq	0x160(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	xorl	%eax, %eax
               	leaq	0x680(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	movq	%rdx, -0x88(%rbp)
               	leaq	0x280(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x88(%rbp), %rdx
               	leaq	0x160(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	addq	%rcx, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	leaq	0x140(%rsp), %rdx
               	movq	-0x88(%rbp), %rsi
               	movq	%rsi, (%rdx,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	0x140(%rsp), %rax
               	movq	0x148(%rsp), %rcx
               	movq	0x150(%rsp), %rdx
               	movq	0x158(%rsp), %rsi
               	movq	%rax, 0x1a0(%rsp)
               	movq	%rcx, 0x1a8(%rsp)
               	movq	%rdx, 0x1b0(%rsp)
               	movq	%rsi, 0x1b8(%rsp)
               	leaq	0x1a0(%rsp), %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x6a0(%rsp), %rcx
               	leaq	0x280(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x140(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	$-0x1, 0x140(%rsp)
               	movq	$-0x1, 0x148(%rsp)
               	leaq	0x160(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xa20(%rsp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xa30(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xa40(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xa20(%rsp), %rcx
               	leaq	0xa50(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0xa60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xa70(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xa80(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	leaq	0xa50(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	%rsi, -0x90(%rbp)
               	movq	(%rcx,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0x90(%rbp), %rsi
               	leaq	0xa80(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	addq	%rdx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0xa70(%rsp), %rsi
               	movq	-0x90(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0xa70(%rsp), %xmm0
               	leaq	0x160(%rsp), %rax
               	movups	%xmm0, 0x160(%rsp)
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	(%rsp), %rax
               	leaq	0x160(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x280(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movl	$0xffffffff, 0x280(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x284(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x288(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x28c(%rsp) # imm = 0xFFFFFFFF
               	leaq	0x140(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9d0(%rsp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x2c0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x9e0(%rsp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x9d0(%rsp), %rcx
               	leaq	0x9f0(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0xa00(%rsp), %rcx
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0xa10(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x260(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	xorl	%eax, %eax
               	leaq	0x9f0(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0x98(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x98(%rbp), %rsi
               	leaq	0x260(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0xa10(%rsp), %rsi
               	movl	-0x98(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	0xa10(%rsp), %xmm0
               	leaq	0x160(%rsp), %rax
               	movups	%xmm0, 0x160(%rsp)
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x6a0(%rsp), %rcx
               	leaq	0x280(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x140(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0xffffffff, 0x140(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x144(%rsp) # imm = 0xFFFFFFFF
               	leaq	0x160(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x960(%rsp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x970(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x980(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x960(%rsp), %rcx
               	leaq	0x990(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x9a0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x9b0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x9c0(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	leaq	0x990(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0xa0(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xa0(%rbp), %rsi
               	leaq	0x9c0(%rsp), %rdi
               	movq	(%rdi,%rax,8), %rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0x9b0(%rsp), %rsi
               	movl	-0xa0(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0x9b0(%rsp), %xmm0
               	leaq	0x160(%rsp), %rax
               	movups	%xmm0, 0x160(%rsp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x6a0(%rsp), %rax
               	leaq	0x950(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x240(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	$-0x1, 0x240(%rsp)
               	movq	$-0x1, 0x248(%rsp)
               	movq	$-0x1, 0x250(%rsp)
               	movq	$-0x1, 0x258(%rsp)
               	leaq	0x220(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x240(%rsp), %rsi
               	leaq	0x580(%rsp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x930(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x5a0(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x580(%rsp), %rdx
               	leaq	0x5c0(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x5e0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x600(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x930(%rsp), %rax
               	leaq	0x940(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	leaq	0x5c0(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	movq	%rdx, -0xa8(%rbp)
               	leaq	0x5e0(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0xa8(%rbp), %rdx
               	leaq	0x940(%rsp), %rsi
               	movslq	(%rsi,%rax,4), %rsi
               	addq	%rcx, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	leaq	0x600(%rsp), %rdx
               	movq	-0xa8(%rbp), %rsi
               	movq	%rsi, (%rdx,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	0x600(%rsp), %rax
               	movq	0x608(%rsp), %rcx
               	movq	0x610(%rsp), %rdx
               	movq	0x618(%rsp), %rsi
               	movq	%rax, 0x160(%rsp)
               	movq	%rcx, 0x168(%rsp)
               	movq	%rdx, 0x170(%rsp)
               	movq	%rsi, 0x178(%rsp)
               	leaq	0x160(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x6a0(%rsp), %rdx
               	leaq	0x920(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%esi, %esi
               	movq	$-0x1, %rdx
               	vmovq	%rdx, %xmm0
               	vpinsrq	$0x1, %rdx, %xmm0, %xmm0
               	leaq	0x8d0(%rsp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x8e0(%rsp), %rdx
               	movq	%rsi, %xmm14
               	movups	%xmm14, 0x8e0(%rsp)
               	movups	%xmm0, 0x8f0(%rsp)
               	leaq	0x900(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x910(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movq	(%rdx,%rax,8), %rsi
               	movq	%rsi, -0xb0(%rbp)
               	leaq	0x8f0(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xb0(%rbp), %rsi
               	leaq	0x910(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	addq	%rcx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0x900(%rsp), %rsi
               	movq	-0xb0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0x900(%rsp), %xmm0
               	leaq	0x160(%rsp), %rax
               	movups	%xmm0, 0x160(%rsp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	(%rsp), %rax
               	leaq	0x100(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0xe0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movl	$0xffffffff, 0xe0(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xe4(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xe8(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xec(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xf0(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xf4(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xf8(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0xfc(%rsp) # imm = 0xFFFFFFFF
               	leaq	0x120(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0xe0(%rsp), %rsi
               	leaq	0x480(%rsp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x4a0(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x4c0(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x480(%rsp), %rdx
               	leaq	0x4e0(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x500(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x520(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x4a0(%rsp), %rax
               	leaq	0x540(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	xorl	%eax, %eax
               	leaq	0x4e0(%rsp), %rdx
               	movl	(%rdx,%rax,4), %edx
               	movl	%edx, -0xb8(%rbp)
               	leaq	0x500(%rsp), %rdx
               	movl	(%rdx,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0xb8(%rbp), %rdx
               	leaq	0x540(%rsp), %rsi
               	movslq	(%rsi,%rax,4), %rsi
               	addq	%rcx, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	leaq	0x520(%rsp), %rdx
               	movl	-0xb8(%rbp), %esi
               	movl	%esi, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	0x520(%rsp), %rax
               	movq	0x528(%rsp), %rcx
               	movq	0x530(%rsp), %rdx
               	movq	0x538(%rsp), %rsi
               	movq	%rax, 0x160(%rsp)
               	movq	%rcx, 0x168(%rsp)
               	movq	%rdx, 0x170(%rsp)
               	movq	%rsi, 0x178(%rsp)
               	leaq	0x160(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x6a0(%rsp), %rax
               	leaq	0x8c0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%esi, %esi
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	vmovd	%eax, %xmm0
               	vpinsrd	$0x1, %eax, %xmm0, %xmm0
               	vpinsrd	$0x2, %eax, %xmm0, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	leaq	0x870(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x880(%rsp), %rdx
               	movq	%rsi, %xmm14
               	movups	%xmm14, 0x880(%rsp)
               	movups	%xmm0, 0x890(%rsp)
               	leaq	0x8a0(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x8b0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movl	(%rdx,%rax,4), %esi
               	movl	%esi, -0xc0(%rbp)
               	leaq	0x890(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xc0(%rbp), %rsi
               	leaq	0x8b0(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	addq	%rcx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0x8a0(%rsp), %rsi
               	movl	-0xc0(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	0x8a0(%rsp), %xmm0
               	leaq	0x160(%rsp), %rax
               	movups	%xmm0, 0x160(%rsp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	0x6a0(%rsp), %rax
               	leaq	0x860(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0xc0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	$-0x1, 0xc0(%rsp)
               	movq	$-0x1, 0xc8(%rsp)
               	movq	$-0x1, 0xd0(%rsp)
               	movq	$-0x1, 0xd8(%rsp)
               	leaq	0x200(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0xc0(%rsp), %rsi
               	leaq	0x3e0(%rsp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x840(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x400(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x3e0(%rsp), %rdx
               	leaq	0x420(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x440(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x460(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x840(%rsp), %rax
               	leaq	0x850(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	leaq	0x420(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	movq	%rdx, -0xc8(%rbp)
               	leaq	0x440(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0xc8(%rbp), %rdx
               	leaq	0x850(%rsp), %rsi
               	movslq	(%rsi,%rax,4), %rsi
               	addq	%rcx, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	leaq	0x460(%rsp), %rdx
               	movq	-0xc8(%rbp), %rsi
               	movq	%rsi, (%rdx,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	0x460(%rsp), %rax
               	movq	0x468(%rsp), %rcx
               	movq	0x470(%rsp), %rdx
               	movq	0x478(%rsp), %rsi
               	movq	%rax, 0x160(%rsp)
               	movq	%rcx, 0x168(%rsp)
               	movq	%rdx, 0x170(%rsp)
               	movq	%rsi, 0x178(%rsp)
               	leaq	0x160(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x6a0(%rsp), %rcx
               	leaq	0x810(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x820(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	$-0x1, 0x820(%rsp)
               	movq	$-0x1, 0x828(%rsp)
               	leaq	0x830(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x7a0(%rsp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x7b0(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x7c0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x7a0(%rsp), %rcx
               	leaq	0x7d0(%rsp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x7e0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x7f0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x800(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	leaq	0x7d0(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	movq	%rsi, -0xd0(%rbp)
               	movq	(%rcx,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xd0(%rbp), %rsi
               	leaq	0x800(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	addq	%rdx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0x7f0(%rsp), %rsi
               	movq	-0xd0(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0x7f0(%rsp), %xmm0
               	leaq	0x160(%rsp), %rax
               	movups	%xmm0, 0x160(%rsp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rcx
               	leaq	(%rsp), %rax
               	leaq	0x3c0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x2a0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movl	$0xffffffff, 0x2a0(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x2a4(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x2a8(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x2ac(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x2b0(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x2b4(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x2b8(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x2bc(%rsp) # imm = 0xFFFFFFFF
               	leaq	0x1e0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x2a0(%rsp), %rsi
               	leaq	0x2e0(%rsp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x300(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x320(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x2e0(%rsp), %rdx
               	leaq	0x340(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x360(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x380(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x300(%rsp), %rax
               	leaq	0x3a0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	xorl	%eax, %eax
               	leaq	0x340(%rsp), %rdx
               	movl	(%rdx,%rax,4), %edx
               	movl	%edx, -0xd8(%rbp)
               	leaq	0x360(%rsp), %rdx
               	movl	(%rdx,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0xd8(%rbp), %rdx
               	leaq	0x3a0(%rsp), %rsi
               	movslq	(%rsi,%rax,4), %rsi
               	addq	%rcx, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	leaq	0x380(%rsp), %rdx
               	movl	-0xd8(%rbp), %esi
               	movl	%esi, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	0x380(%rsp), %rax
               	movq	0x388(%rsp), %rcx
               	movq	0x390(%rsp), %rdx
               	movq	0x398(%rsp), %rsi
               	movq	%rax, 0x160(%rsp)
               	movq	%rcx, 0x168(%rsp)
               	movq	%rdx, 0x170(%rsp)
               	movq	%rsi, 0x178(%rsp)
               	leaq	0x160(%rsp), %rax
               	jmp	<addr>
               	movl	$0x1, %r12d
               	jmp	<addr>
               	xorl	%r12d, %r12d
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x200(%rax), %rdx
               	leaq	0x6a0(%rsp), %rax
               	leaq	0x770(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x780(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movl	$0xffffffff, 0x780(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x784(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x788(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x78c(%rsp) # imm = 0xFFFFFFFF
               	leaq	0x790(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x700(%rsp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x710(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x720(%rsp), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x700(%rsp), %rcx
               	leaq	0x730(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x740(%rsp), %rcx
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x750(%rsp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x760(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	leaq	0x730(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	movl	%esi, -0xe0(%rbp)
               	movl	(%rcx,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0xe0(%rbp), %rsi
               	leaq	0x760(%rsp), %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0x750(%rsp), %rsi
               	movl	-0xe0(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	0x750(%rsp), %xmm0
               	leaq	0x160(%rsp), %rax
               	movups	%xmm0, 0x160(%rsp)
               	jmp	<addr>

<check_masked_moves>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x138, %rsp            # imm = 0x138
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x5e0, %rsp            # imm = 0x5E0
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
               	movq	$0x0, -0x128(%rbp)
               	leaq	-0x128(%rbp), %rdi
               	movslq	%eax, %rax
               	leaq	(%rcx,%rax), %rsi
               	movq	%rbx, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	-0x128(%rbp), %rdx
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
               	leaq	0x400(%rsp), %rax
               	leaq	-0x60(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x410(%rsp), %rsi
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	cmpl	$0x4, %ebx
               	jne	<addr>
               	cmpl	$0x10, %r14d
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rcx
               	leaq	0x430(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x440(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movl	$0x0, -0x120(%rbp)
               	leaq	0x440(%rsp), %rdx
               	movl	(%rdx,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x120(%rbp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	addq	%rcx, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	leaq	0x450(%rsp), %rdx
               	movl	-0x120(%rbp), %esi
               	movl	%esi, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	0x450(%rsp), %xmm0
               	movups	%xmm0, 0x420(%rsp)
               	leaq	-0xa0(%rbp), %rdx
               	leaq	0x400(%rsp), %rcx
               	leaq	0x460(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x470(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movl	%ecx, -0x118(%rbp)
               	leaq	0x470(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x118(%rbp), %rsi
               	movq	%rax, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0x480(%rsp), %rsi
               	movl	-0x118(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movups	0x480(%rsp), %xmm0
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x420(%rsp), %rdi
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
               	movq	$0x0, -0x128(%rbp)
               	leaq	-0x128(%rbp), %rdi
               	movslq	%ecx, %rcx
               	leaq	(%rax,%rcx), %rsi
               	movq	%rbx, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	-0x128(%rbp), %rdx
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
               	leaq	0x400(%rsp), %rcx
               	movups	0x410(%rsp), %xmm0
               	leaq	0x4f0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x500(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm0, 0x510(%rsp)
               	xorl	%ecx, %ecx
               	leaq	0x500(%rsp), %rsi
               	movl	(%rsi,%rcx,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	0x510(%rsp), %rdi
               	movq	%rcx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rdi
               	movl	(%rdi), %edi
               	movl	%edi, -0xe0(%rbp)
               	addq	%rdx, %rsi
               	leaq	-0xe0(%rbp), %rdi
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
               	leaq	0x400(%rsp), %rax
               	leaq	0x410(%rsp), %rcx
               	leaq	0x520(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x530(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x520(%rsp), %rcx
               	leaq	0x540(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x550(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%ecx, %ecx
               	leaq	0x540(%rsp), %rsi
               	movl	(%rsi,%rcx,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	0x550(%rsp), %rdi
               	movq	%rcx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rdi
               	movl	(%rdi), %edi
               	movl	%edi, -0xd8(%rbp)
               	addq	%rdx, %rsi
               	leaq	-0xd8(%rbp), %rdi
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
               	leaq	-0x20(%rbp), %rsi
               	leaq	(%rsp), %rax
               	movq	0x20(%rsp), %rcx
               	movq	0x28(%rsp), %rdx
               	movq	0x30(%rsp), %rdi
               	movq	0x38(%rsp), %r8
               	leaq	0x200(%rsp), %r9
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	movq	%rcx, 0x220(%rsp)
               	movq	%rdx, 0x228(%rsp)
               	movq	%rdi, 0x230(%rsp)
               	movq	%r8, 0x238(%rsp)
               	leaq	0x200(%rsp), %rax
               	leaq	0x240(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x220(%rsp), %rax
               	leaq	0x260(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	xorl	%ecx, %ecx
               	leaq	0x240(%rsp), %rdx
               	movl	(%rdx,%rcx,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	0x260(%rsp), %rdi
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rdi
               	movl	(%rdi), %edi
               	movl	%edi, -0xd0(%rbp)
               	addq	%rsi, %rdx
               	leaq	-0xd0(%rbp), %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rdx)
               	incq	%rcx
               	cmpl	$0x8, %ecx
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rsi
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	leaq	0x280(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x2a0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x280(%rsp), %rcx
               	leaq	0x2c0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x2e0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	xorl	%ecx, %ecx
               	leaq	0x2c0(%rsp), %rdx
               	movl	(%rdx,%rcx,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	0x2e0(%rsp), %rdi
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rdi
               	movl	(%rdi), %edi
               	movl	%edi, -0xc8(%rbp)
               	addq	%rsi, %rdx
               	leaq	-0xc8(%rbp), %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rdx)
               	incq	%rcx
               	cmpl	$0x8, %ecx
               	jge	<addr>
               	jmp	<addr>
               	cmpl	$0x10, %r14d
               	jne	<addr>
               	testq	%r12, %r12
               	je	<addr>
               	leaq	-0x20(%rbp), %rsi
               	leaq	0x400(%rsp), %rcx
               	movups	0x410(%rsp), %xmm0
               	leaq	0x560(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x570(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm0, 0x580(%rsp)
               	xorl	%ecx, %ecx
               	leaq	0x570(%rsp), %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	0x580(%rsp), %rdi
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	movq	%rdi, -0xc0(%rbp)
               	addq	%rsi, %rdx
               	leaq	-0xc0(%rbp), %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rdx)
               	incq	%rcx
               	cmpl	$0x2, %ecx
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rsi
               	leaq	0x400(%rsp), %rax
               	leaq	0x410(%rsp), %rcx
               	leaq	0x590(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x5a0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x590(%rsp), %rcx
               	leaq	0x5b0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x5c0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%ecx, %ecx
               	leaq	0x5b0(%rsp), %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	0x5c0(%rsp), %rdi
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	movq	%rdi, -0xb8(%rbp)
               	addq	%rsi, %rdx
               	leaq	-0xb8(%rbp), %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rdx)
               	incq	%rcx
               	cmpl	$0x2, %ecx
               	jge	<addr>
               	jmp	<addr>
               	testq	%r12, %r12
               	je	<addr>
               	leaq	-0x20(%rbp), %rsi
               	leaq	(%rsp), %rax
               	movq	0x20(%rsp), %rcx
               	movq	0x28(%rsp), %rdx
               	movq	0x30(%rsp), %rdi
               	movq	0x38(%rsp), %r8
               	leaq	0x300(%rsp), %r9
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	movq	%rcx, 0x320(%rsp)
               	movq	%rdx, 0x328(%rsp)
               	movq	%rdi, 0x330(%rsp)
               	movq	%r8, 0x338(%rsp)
               	leaq	0x300(%rsp), %rax
               	leaq	0x340(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x320(%rsp), %rax
               	leaq	0x360(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	xorl	%ecx, %ecx
               	leaq	0x340(%rsp), %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	0x360(%rsp), %rdi
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
               	cmpl	$0x4, %ecx
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rsi
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	leaq	0x380(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x3a0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x380(%rsp), %rcx
               	leaq	0x3c0(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x3e0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	xorl	%ecx, %ecx
               	leaq	0x3c0(%rsp), %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	0x3e0(%rsp), %rdi
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
               	cmpl	$0x4, %ecx
               	jge	<addr>
               	jmp	<addr>
               	orq	%rcx, %r15
               	incq	%r12
               	cmpl	$0x2, %r12d
               	jge	<addr>
               	jmp	<addr>
               	cmpl	$0x4, %ebx
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rcx
               	leaq	0x80(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0xa0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	xorl	%eax, %eax
               	movl	$0x0, -0x110(%rbp)
               	leaq	0xa0(%rsp), %rdx
               	movl	(%rdx,%rax,4), %edx
               	testl	%edx, %edx
               	jge	<addr>
               	leaq	-0x110(%rbp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	addq	%rcx, %rsi
               	movl	(%rsi), %r10d
               	movl	%r10d, (%rdx)
               	leaq	0xc0(%rsp), %rdx
               	movl	-0x110(%rbp), %esi
               	movl	%esi, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	0xc0(%rsp), %rax
               	movq	0xc8(%rsp), %rcx
               	movq	0xd0(%rsp), %rdx
               	movq	0xd8(%rsp), %rsi
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%rdx, 0x50(%rsp)
               	movq	%rsi, 0x58(%rsp)
               	leaq	-0xa0(%rbp), %rdx
               	leaq	(%rsp), %rcx
               	leaq	0xe0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x100(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movl	%ecx, -0x108(%rbp)
               	leaq	0x100(%rsp), %rsi
               	movl	(%rsi,%rax,4), %esi
               	testl	%esi, %esi
               	jge	<addr>
               	leaq	-0x108(%rbp), %rsi
               	movq	%rax, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdx, %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rsi)
               	leaq	0x120(%rsp), %rsi
               	movl	-0x108(%rbp), %edi
               	movl	%edi, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	0x120(%rsp), %rax
               	movq	0x128(%rsp), %rcx
               	movq	0x130(%rsp), %rdx
               	movq	0x138(%rsp), %rsi
               	movq	%rax, 0x60(%rsp)
               	movq	%rcx, 0x68(%rsp)
               	movq	%rdx, 0x70(%rsp)
               	movq	%rsi, 0x78(%rsp)
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
               	leaq	0x400(%rsp), %rdx
               	leaq	0x490(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x4a0(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	movq	$0x0, -0x100(%rbp)
               	leaq	0x4a0(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0x100(%rbp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	addq	%rcx, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	leaq	0x4b0(%rsp), %rdx
               	movq	-0x100(%rbp), %rsi
               	movq	%rsi, (%rdx,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0x4b0(%rsp), %xmm0
               	movups	%xmm0, 0x420(%rsp)
               	leaq	-0xa0(%rbp), %rdx
               	leaq	0x400(%rsp), %rcx
               	leaq	0x4c0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x4d0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movq	%rcx, -0xf8(%rbp)
               	leaq	0x4d0(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xf8(%rbp), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0x4e0(%rsp), %rsi
               	movq	-0xf8(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	0x4e0(%rsp), %xmm0
               	movups	%xmm0, 0x60(%rsp)
               	leaq	0x420(%rsp), %rdi
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
               	leaq	-0xa0(%rbp), %rcx
               	leaq	(%rsp), %rdx
               	leaq	0x140(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x160(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	xorl	%eax, %eax
               	movq	$0x0, -0xf0(%rbp)
               	leaq	0x160(%rsp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	leaq	-0xf0(%rbp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	addq	%rcx, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	leaq	0x180(%rsp), %rdx
               	movq	-0xf0(%rbp), %rsi
               	movq	%rsi, (%rdx,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	0x180(%rsp), %rax
               	movq	0x188(%rsp), %rcx
               	movq	0x190(%rsp), %rdx
               	movq	0x198(%rsp), %rsi
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%rdx, 0x50(%rsp)
               	movq	%rsi, 0x58(%rsp)
               	leaq	-0xa0(%rbp), %rdx
               	leaq	(%rsp), %rcx
               	leaq	0x1a0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x1c0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movq	%rcx, -0xe8(%rbp)
               	leaq	0x1c0(%rsp), %rsi
               	movq	(%rsi,%rax,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	leaq	-0xe8(%rbp), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdx, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, (%rsi)
               	leaq	0x1e0(%rsp), %rsi
               	movq	-0xe8(%rbp), %rdi
               	movq	%rdi, (%rsi,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	0x1e0(%rsp), %rax
               	movq	0x1e8(%rsp), %rcx
               	movq	0x1f0(%rsp), %rdx
               	movq	0x1f8(%rsp), %rsi
               	movq	%rax, 0x60(%rsp)
               	movq	%rcx, 0x68(%rsp)
               	movq	%rdx, 0x70(%rsp)
               	movq	%rsi, 0x78(%rsp)
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
               	leaq	-0x160(%rbp), %rsp
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
               	leaq	0x80(%rsp), %rax
               	movswq	-0x42(%rbp), %rcx
               	movswq	-0x44(%rbp), %rdx
               	movswq	-0x46(%rbp), %rsi
               	movswq	-0x48(%rbp), %rdi
               	movswq	-0x4a(%rbp), %r8
               	movswq	-0x4c(%rbp), %r9
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
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	-0x98(%rbp), %r10
               	movw	%r10w, 0x80(%rsp)
               	movq	-0x90(%rbp), %r10
               	movw	%r10w, 0x82(%rsp)
               	movq	-0x88(%rbp), %r10
               	movw	%r10w, 0x84(%rsp)
               	movq	-0x80(%rbp), %r10
               	movw	%r10w, 0x86(%rsp)
               	movq	-0x78(%rbp), %r10
               	movw	%r10w, 0x88(%rsp)
               	movw	%r15w, 0x8a(%rsp)
               	movw	%r14w, 0x8c(%rsp)
               	movw	%r13w, 0x8e(%rsp)
               	movw	%r12w, 0x90(%rsp)
               	movw	%bx, 0x92(%rsp)
               	movw	%r9w, 0x94(%rsp)
               	movw	%r8w, 0x96(%rsp)
               	movw	%di, 0x98(%rsp)
               	movw	%si, 0x9a(%rsp)
               	movw	%dx, 0x9c(%rsp)
               	movw	%cx, 0x9e(%rsp)
               	leaq	0x80(%rsp), %rax
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x80(%rsp), %rax
               	movswq	-0x60(%rbp), %rcx
               	movswq	-0x5e(%rbp), %rdx
               	movswq	-0x5c(%rbp), %rsi
               	movswq	-0x5a(%rbp), %rdi
               	movswq	-0x58(%rbp), %r8
               	movswq	-0x56(%rbp), %r9
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
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movw	%cx, 0x80(%rsp)
               	movw	%dx, 0x82(%rsp)
               	movw	%si, 0x84(%rsp)
               	movw	%di, 0x86(%rsp)
               	movw	%r8w, 0x88(%rsp)
               	movw	%r9w, 0x8a(%rsp)
               	movw	%bx, 0x8c(%rsp)
               	movw	%r12w, 0x8e(%rsp)
               	movw	%r13w, 0x90(%rsp)
               	movw	%r14w, 0x92(%rsp)
               	movw	%r15w, 0x94(%rsp)
               	movq	-0x78(%rbp), %r10
               	movw	%r10w, 0x96(%rsp)
               	movq	-0x80(%rbp), %r10
               	movw	%r10w, 0x98(%rsp)
               	movq	-0x88(%rbp), %r10
               	movw	%r10w, 0x9a(%rsp)
               	movq	-0x90(%rbp), %r10
               	movw	%r10w, 0x9c(%rsp)
               	movq	-0x98(%rbp), %r10
               	movw	%r10w, 0x9e(%rsp)
               	leaq	0x80(%rsp), %rax
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
               	leaq	-0x40(%rbp), %rsi
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rcx
               	movq	-0x30(%rbp), %rdx
               	movq	-0x28(%rbp), %r8
               	leaq	0x40(%rsp), %rdi
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%rdx, 0x50(%rsp)
               	movq	%r8, 0x58(%rsp)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	leaq	-0x40(%rbp), %rsi
               	movq	-0x40(%rbp), %rcx
               	movq	-0x38(%rbp), %rdx
               	leaq	0x10(%rsi), %rax
               	movq	(%rax), %r8
               	movq	0x8(%rax), %rax
               	leaq	0x60(%rsp), %rdi
               	movq	%rcx, 0x60(%rsp)
               	movq	%rdx, 0x68(%rsp)
               	movq	%r8, 0x70(%rsp)
               	movq	%rax, 0x78(%rsp)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	movzwq	(%rsp), %rax
               	movswq	-0x60(%rbp), %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	cmpl	%ecx, %eax
               	movl	$0x1, %eax
               	jne	<addr>
               	movzwq	0x12(%rsp), %rcx
               	movswq	-0x4e(%rbp), %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	cmpl	%edx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzwq	0x1e(%rsp), %rax
               	movswq	-0x42(%rbp), %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	cmpl	%ecx, %eax
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x60(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movq	-0x40(%rbp), %rax
               	movw	%ax, -0x6(%rbp)
               	leaq	(%rsp), %rdx
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x80(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movw	%ax, 0x9a(%rsp)
               	movq	0x80(%rsp), %rax
               	movq	0x88(%rsp), %rcx
               	movq	0x90(%rsp), %rdx
               	movq	0x98(%rsp), %r8
               	leaq	0x80(%rsp), %rdi
               	movq	%rax, 0x80(%rsp)
               	movq	%rcx, 0x88(%rsp)
               	movq	%rdx, 0x90(%rsp)
               	movq	%r8, 0x98(%rsp)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rbx, %rax
               	leaq	-0x68(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movl	0x40(%rsp), %ecx
               	movl	-0x68(%rbp), %edx
               	cmpl	%edx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %rax
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
               	movq	%rax, %rcx
               	jmp	<addr>

<check_transfers>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa8, %rsp
               	pushq	%rbx
               	subq	$0xe0, %rsp
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
               	leaq	-0x20(%rbp), %rdx
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
               	leaq	-0x80(%rbp), %rcx
               	leaq	-0x20(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x10(%rcx), %rdx
               	leaq	-0xa0(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x3(%rax), %xmm0
               	movups	0x1(%rcx), %xmm1
               	vmovq	%xmm0, %rdx
               	vpextrq	$0x1, %xmm0, %rsi
               	vmovq	%xmm1, %r8
               	vpextrq	$0x1, %xmm1, %r9
               	leaq	(%rsp), %rdi
               	movq	%rdx, (%rsp)
               	movq	%rsi, 0x8(%rsp)
               	movq	%r8, 0x10(%rsp)
               	movq	%r9, 0x18(%rsp)
               	leaq	-0x60(%rbp), %rsi
               	addq	$0x3, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x10(%rsi), %rax
               	incq	%rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	movups	-0x20(%rbp), %xmm0
               	movups	-0xa0(%rbp), %xmm1
               	vmovdqa	%xmm0, %xmm0
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	leaq	0x20(%rsp), %rdi
               	vmovups	%ymm0, 0x20(%rsp)
               	movups	-0x20(%rbp), %xmm0
               	movups	-0xa0(%rbp), %xmm1
               	vmovdqa	%xmm0, %xmm0
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	leaq	-0x80(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x40(%rsp), %rdi
               	leaq	-0x80(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
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
               	vzeroupper
               	callq	<addr>
               	leaq	-0x40(%rbp), %rax
               	movq	(%rsp), %rcx
               	movq	0x8(%rsp), %rdx
               	movq	0x10(%rsp), %rsi
               	movq	0x18(%rsp), %rdi
               	xorl	%r8d, %r8d
               	vmovq	%rcx, %xmm0
               	vpinsrq	$0x1, %rdx, %xmm0, %xmm0
               	movups	%xmm0, 0x5(%rax)
               	xorl	%ecx, %ecx
               	vmovq	%rsi, %xmm0
               	vpinsrq	$0x1, %rdi, %xmm0, %xmm0
               	movups	%xmm0, 0x21(%rax)
               	leaq	-0x40(%rbp), %rax
               	leaq	0x5(%rax), %rdi
               	leaq	-0x60(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	vzeroupper
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
               	vzeroupper
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
               	vzeroupper
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	vmovups	0x20(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm1
               	movups	%xmm1, -0x40(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm0
               	movups	%xmm0, -0x20(%rbp)
               	leaq	-0x80(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	vzeroupper
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
               	vzeroupper
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
               	vzeroupper
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	vmovups	0x40(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm1
               	movups	%xmm1, -0x40(%rbp)
               	vextracti128	$0x1, %ymm0, %xmm0
               	movups	%xmm0, -0x20(%rbp)
               	leaq	-0x80(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	vzeroupper
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
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %rbx
               	leaq	<rip>, %rax # <addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	%ymm0, 0x20(%rax)
               	movl	$0x20, %edx
               	leaq	0x20(%rax), %rdi
               	leaq	-0x60(%rbp), %rsi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rbx
               	leaq	<rip>, %rax # <addr>
               	vmovups	0x20(%rax), %ymm0
               	leaq	0x60(%rsp), %rdi
               	vmovups	%ymm0, 0x60(%rsp)
               	leaq	-0x80(%rbp), %rax
               	vmovups	(%rax), %ymm0
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	-0x60(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	-0x80(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %rbx
               	leaq	<rip>, %rdi # <addr>
               	leaq	0x20(%rsp), %rcx
               	leaq	0xa0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0xc0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	<rip>, %rdx # <addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	0xa0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0xc0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	-0x80(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	-0x80(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rbx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x20, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>

<check_tests>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd8, %rsp
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
               	movq	%r10, -0xc0(%rbp)
               	leaq	-0x50(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %rax
               	movq	%rax, -0x50(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movq	%rax, -0x48(%rbp)
               	movq	-0xc0(%rbp), %r14
               	movq	-0xc0(%rbp), %rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	leaq	-0x50(%rbp), %rcx
               	movq	%rax, %rdx
               	andq	$0x1, %rdx
               	movq	(%rcx,%rdx,8), %r9
               	sarq	%rax
               	movq	(%rcx,%rax,8), %rbx
               	movl	$0x1, %ecx
               	xorl	%eax, %eax
               	movq	%rcx, %rdx
               	movzbq	(%r9,%rax), %rsi
               	movzbq	(%rbx,%rax), %rdi
               	movq	%rsi, %r8
               	andq	%rdi, %r8
               	testl	%r8d, %r8d
               	sete	%r8b
               	movzbq	%r8b, %r8
               	andq	%r8, %rdx
               	xorq	$-0x1, %rsi
               	andq	%rdi, %rsi
               	testl	%esi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	(%rsp), %rax
               	movups	(%r9), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%r9), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x20(%rsp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rbx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vpand	%ymm1, %ymm0, %ymm0
               	vmovq	%xmm0, %rax
               	vpextrq	$0x1, %xmm0, %rsi
               	orq	%rsi, %rax
               	vextracti128	$0x1, %ymm0, %xmm1
               	vmovq	%xmm1, %rsi
               	orq	%rsi, %rax
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrq	$0x1, %xmm0, %rsi
               	orq	%rsi, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	%edx, %eax
               	movl	$0x1, %eax
               	jne	<addr>
               	movq	(%rsp), %rax
               	xorq	$-0x1, %rax
               	xorl	%esi, %esi
               	xorl	%edi, %edi
               	vmovq	%rax, %xmm0
               	movq	0x8(%rsp), %rax
               	xorq	$-0x1, %rax
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vmovdqa	%xmm0, %xmm0
               	movq	0x10(%rsp), %rax
               	xorq	$-0x1, %rax
               	xorl	%esi, %esi
               	vmovq	%rax, %xmm1
               	movq	0x18(%rsp), %rax
               	xorq	$-0x1, %rax
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vpand	%ymm1, %ymm0, %ymm0
               	vmovq	%xmm0, %rax
               	vpextrq	$0x1, %xmm0, %rsi
               	orq	%rsi, %rax
               	vextracti128	$0x1, %ymm0, %xmm1
               	vmovq	%xmm1, %rsi
               	orq	%rsi, %rax
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrq	$0x1, %xmm0, %rsi
               	orq	%rsi, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	%ecx, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %esi
               	testq	%rax, %rax
               	jne	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm2
               	vpand	%ymm2, %ymm0, %ymm1
               	vmovq	%xmm1, %rax
               	vpextrq	$0x1, %xmm1, %rsi
               	orq	%rsi, %rax
               	vextracti128	$0x1, %ymm1, %xmm3
               	vmovq	%xmm3, %rsi
               	orq	%rsi, %rax
               	vextracti128	$0x1, %ymm1, %xmm1
               	vpextrq	$0x1, %xmm1, %rsi
               	orq	%rsi, %rax
               	xorl	%esi, %esi
               	testq	%rax, %rax
               	je	<addr>
               	vmovq	%xmm0, %rax
               	xorq	$-0x1, %rax
               	xorl	%esi, %esi
               	xorl	%edi, %edi
               	vmovq	%rax, %xmm1
               	vpextrq	$0x1, %xmm0, %rax
               	xorq	$-0x1, %rax
               	vpinsrq	$0x1, %rax, %xmm1, %xmm1
               	vmovdqa	%xmm1, %xmm1
               	vextracti128	$0x1, %ymm0, %xmm3
               	vmovq	%xmm3, %rax
               	xorq	$-0x1, %rax
               	xorl	%esi, %esi
               	vmovq	%rax, %xmm3
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrq	$0x1, %xmm0, %rax
               	xorq	$-0x1, %rax
               	movapd	%xmm3, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vpand	%ymm2, %ymm0, %ymm0
               	vmovq	%xmm0, %rax
               	vpextrq	$0x1, %xmm0, %rsi
               	orq	%rsi, %rax
               	vextracti128	$0x1, %ymm0, %xmm1
               	vmovq	%xmm1, %rsi
               	orq	%rsi, %rax
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrq	$0x1, %xmm0, %rsi
               	orq	%rsi, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	testl	%edx, %edx
               	jne	<addr>
               	testl	%ecx, %ecx
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	%eax, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	orq	%rsi, %r14
               	movl	$0x4, %r12d
               	movl	$0x10, %r8d
               	movl	$0x1, %ecx
               	leaq	-0x1(%r12), %rax
               	movq	%rcx, %rdx
               	cmpl	%r8d, %eax
               	jge	<addr>
               	movzbq	(%r9,%rax), %rsi
               	movzbq	(%rbx,%rax), %rdi
               	movq	%rsi, %r13
               	andq	%rdi, %r13
               	andq	$0x80, %r13
               	testl	%r13d, %r13d
               	sete	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rdx
               	xorq	$-0x1, %rsi
               	andq	%rdi, %rsi
               	andq	$0x80, %rsi
               	testl	%esi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rcx
               	addq	%r12, %rax
               	cmpl	%r8d, %eax
               	jl	<addr>
               	cmpl	$0x4, %r12d
               	jne	<addr>
               	cmpl	$0x10, %r8d
               	jne	<addr>
               	leaq	0xc0(%rsp), %rax
               	movups	(%r9), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xd0(%rsp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	movl	0xc0(%rsp), %eax
               	movl	0xc4(%rsp), %esi
               	movl	0xc8(%rsp), %edi
               	movl	0xcc(%rsp), %r13d
               	movl	0xd0(%rsp), %r15d
               	movl	0xd4(%rsp), %r10d
               	movq	%r10, -0x58(%rbp)
               	movl	0xd8(%rsp), %r10d
               	movq	%r10, -0x60(%rbp)
               	movl	0xdc(%rsp), %r10d
               	movq	%r10, -0x68(%rbp)
               	movslq	%eax, %rax
               	movslq	%r15d, %r15
               	andq	%r15, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movslq	%esi, %rsi
               	movq	-0x58(%rbp), %r15
               	movslq	%r15d, %r15
               	andq	%r15, %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	movslq	%edi, %rsi
               	movq	-0x60(%rbp), %rdi
               	movslq	%edi, %rdi
               	andq	%rdi, %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	movslq	%r13d, %rsi
               	movq	-0x68(%rbp), %rdi
               	movslq	%edi, %rdi
               	andq	%rdi, %rsi
               	testq	%rsi, %rsi
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rax, %rdi
               	movl	0xc0(%rsp), %eax
               	movl	0xc4(%rsp), %esi
               	movl	0xc8(%rsp), %r13d
               	movl	0xcc(%rsp), %r15d
               	movl	0xd0(%rsp), %r10d
               	movq	%r10, -0x58(%rbp)
               	movl	0xd4(%rsp), %r10d
               	movq	%r10, -0x60(%rbp)
               	movl	0xd8(%rsp), %r10d
               	movq	%r10, -0x68(%rbp)
               	movl	0xdc(%rsp), %r10d
               	movq	%r10, -0x70(%rbp)
               	movslq	%eax, %rax
               	xorq	$-0x1, %rax
               	movq	-0x58(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x58(%rbp)
               	andq	-0x58(%rbp), %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movslq	%esi, %rsi
               	xorq	$-0x1, %rsi
               	movq	-0x60(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x58(%rbp)
               	andq	-0x58(%rbp), %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	movslq	%r13d, %rsi
               	xorq	$-0x1, %rsi
               	movq	-0x68(%rbp), %r13
               	movslq	%r13d, %r13
               	andq	%r13, %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	movslq	%r15d, %rsi
               	xorq	$-0x1, %rsi
               	movq	-0x70(%rbp), %r13
               	movslq	%r13d, %r13
               	andq	%r13, %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rax, %rsi
               	movl	0xc0(%rsp), %eax
               	movl	0xc4(%rsp), %r10d
               	movq	%r10, -0x58(%rbp)
               	movl	0xc8(%rsp), %r10d
               	movq	%r10, -0x68(%rbp)
               	movl	0xcc(%rsp), %r10d
               	movq	%r10, -0x78(%rbp)
               	movl	0xd0(%rsp), %r15d
               	movl	0xd4(%rsp), %r10d
               	movq	%r10, -0x60(%rbp)
               	movl	0xd8(%rsp), %r10d
               	movq	%r10, -0x70(%rbp)
               	movl	0xdc(%rsp), %r10d
               	movq	%r10, -0x80(%rbp)
               	movslq	%eax, %r13
               	movslq	%r15d, %r15
               	movq	%r13, %rax
               	andq	%r15, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movq	-0x58(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x58(%rbp)
               	movq	-0x60(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x60(%rbp)
               	movq	-0x58(%rbp), %r10
               	andq	-0x60(%rbp), %r10
               	movq	%r10, -0x88(%rbp)
               	movq	-0x88(%rbp), %r10
               	testq	%r10, %r10
               	setge	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x88(%rbp)
               	andq	-0x88(%rbp), %rax
               	movq	-0x68(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x68(%rbp)
               	movq	-0x70(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x70(%rbp)
               	movq	-0x68(%rbp), %r10
               	andq	-0x70(%rbp), %r10
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
               	xorq	$-0x1, %r13
               	andq	%r15, %r13
               	testq	%r13, %r13
               	setge	%al
               	movzbq	%al, %rax
               	movq	-0x58(%rbp), %r13
               	xorq	$-0x1, %r13
               	andq	-0x60(%rbp), %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	movq	-0x68(%rbp), %r13
               	xorq	$-0x1, %r13
               	andq	-0x70(%rbp), %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	movq	-0x78(%rbp), %r13
               	xorq	$-0x1, %r13
               	andq	-0x80(%rbp), %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	%edx, %edi
               	movl	$0x1, %edi
               	jne	<addr>
               	cmpl	%ecx, %esi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movl	$0x1, %esi
               	testq	%rdi, %rdi
               	jne	<addr>
               	xorl	%esi, %esi
               	testl	%edx, %edx
               	jne	<addr>
               	testl	%ecx, %ecx
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpl	%esi, %eax
               	setne	%sil
               	movzbq	%sil, %rsi
               	jmp	<addr>
               	cmpl	$0x4, %r12d
               	jne	<addr>
               	leaq	0x40(%rsp), %rax
               	movups	(%r9), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%r9), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x60(%rsp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rbx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movl	0x40(%rsp), %eax
               	movl	0x44(%rsp), %esi
               	movl	0x48(%rsp), %edi
               	movl	0x4c(%rsp), %r13d
               	movl	0x50(%rsp), %r15d
               	movl	0x54(%rsp), %r10d
               	movq	%r10, -0x58(%rbp)
               	movl	0x58(%rsp), %r10d
               	movq	%r10, -0x60(%rbp)
               	movl	0x5c(%rsp), %r10d
               	movq	%r10, -0x68(%rbp)
               	movl	0x60(%rsp), %r10d
               	movq	%r10, -0x70(%rbp)
               	movl	0x64(%rsp), %r10d
               	movq	%r10, -0x78(%rbp)
               	movl	0x68(%rsp), %r10d
               	movq	%r10, -0x80(%rbp)
               	movl	0x6c(%rsp), %r10d
               	movq	%r10, -0x88(%rbp)
               	movl	0x70(%rsp), %r10d
               	movq	%r10, -0x90(%rbp)
               	movl	0x74(%rsp), %r10d
               	movq	%r10, -0x98(%rbp)
               	movl	0x78(%rsp), %r10d
               	movq	%r10, -0xa0(%rbp)
               	movl	0x7c(%rsp), %r10d
               	movq	%r10, -0xa8(%rbp)
               	movslq	%eax, %rax
               	movq	-0x70(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x70(%rbp)
               	andq	-0x70(%rbp), %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movslq	%esi, %rsi
               	movq	-0x78(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x70(%rbp)
               	andq	-0x70(%rbp), %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	movslq	%edi, %rsi
               	movq	-0x80(%rbp), %rdi
               	movslq	%edi, %rdi
               	andq	%rdi, %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	movslq	%r13d, %rsi
               	movq	-0x88(%rbp), %rdi
               	movslq	%edi, %rdi
               	andq	%rdi, %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	movslq	%r15d, %rsi
               	movq	-0x90(%rbp), %rdi
               	movslq	%edi, %rdi
               	andq	%rdi, %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	movq	-0x58(%rbp), %rsi
               	movslq	%esi, %rsi
               	movq	-0x98(%rbp), %rdi
               	movslq	%edi, %rdi
               	andq	%rdi, %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	movq	-0x60(%rbp), %rsi
               	movslq	%esi, %rsi
               	movq	-0xa0(%rbp), %rdi
               	movslq	%edi, %rdi
               	andq	%rdi, %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	movq	-0x68(%rbp), %rsi
               	movslq	%esi, %rsi
               	movq	-0xa8(%rbp), %rdi
               	movslq	%edi, %rdi
               	andq	%rdi, %rsi
               	testq	%rsi, %rsi
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rax, %rdi
               	movl	0x40(%rsp), %eax
               	movl	0x44(%rsp), %esi
               	movl	0x48(%rsp), %r13d
               	movl	0x4c(%rsp), %r15d
               	movl	0x50(%rsp), %r10d
               	movq	%r10, -0x58(%rbp)
               	movl	0x54(%rsp), %r10d
               	movq	%r10, -0x60(%rbp)
               	movl	0x58(%rsp), %r10d
               	movq	%r10, -0x68(%rbp)
               	movl	0x5c(%rsp), %r10d
               	movq	%r10, -0x70(%rbp)
               	movl	0x60(%rsp), %r10d
               	movq	%r10, -0x78(%rbp)
               	movl	0x64(%rsp), %r10d
               	movq	%r10, -0x80(%rbp)
               	movl	0x68(%rsp), %r10d
               	movq	%r10, -0x88(%rbp)
               	movl	0x6c(%rsp), %r10d
               	movq	%r10, -0x90(%rbp)
               	movl	0x70(%rsp), %r10d
               	movq	%r10, -0x98(%rbp)
               	movl	0x74(%rsp), %r10d
               	movq	%r10, -0xa0(%rbp)
               	movl	0x78(%rsp), %r10d
               	movq	%r10, -0xa8(%rbp)
               	movl	0x7c(%rsp), %r10d
               	movq	%r10, -0xb0(%rbp)
               	movslq	%eax, %rax
               	xorq	$-0x1, %rax
               	movq	-0x78(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x78(%rbp)
               	andq	-0x78(%rbp), %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movslq	%esi, %rsi
               	xorq	$-0x1, %rsi
               	movq	-0x80(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x78(%rbp)
               	andq	-0x78(%rbp), %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	movslq	%r13d, %rsi
               	xorq	$-0x1, %rsi
               	movq	-0x88(%rbp), %r13
               	movslq	%r13d, %r13
               	andq	%r13, %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	movslq	%r15d, %rsi
               	xorq	$-0x1, %rsi
               	movq	-0x90(%rbp), %r13
               	movslq	%r13d, %r13
               	andq	%r13, %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	movq	-0x58(%rbp), %rsi
               	movslq	%esi, %rsi
               	xorq	$-0x1, %rsi
               	movq	-0x98(%rbp), %r13
               	movslq	%r13d, %r13
               	andq	%r13, %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	movq	-0x60(%rbp), %rsi
               	movslq	%esi, %rsi
               	xorq	$-0x1, %rsi
               	movq	-0xa0(%rbp), %r13
               	movslq	%r13d, %r13
               	andq	%r13, %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	movq	-0x68(%rbp), %rsi
               	movslq	%esi, %rsi
               	xorq	$-0x1, %rsi
               	movq	-0xa8(%rbp), %r13
               	movslq	%r13d, %r13
               	andq	%r13, %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	movq	-0x70(%rbp), %rsi
               	movslq	%esi, %rsi
               	xorq	$-0x1, %rsi
               	movq	-0xb0(%rbp), %r13
               	movslq	%r13d, %r13
               	andq	%r13, %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rax, %rsi
               	movl	0x40(%rsp), %eax
               	movl	0x44(%rsp), %r13d
               	movl	0x48(%rsp), %r15d
               	movl	0x4c(%rsp), %r10d
               	movq	%r10, -0x58(%rbp)
               	movl	0x50(%rsp), %r10d
               	movq	%r10, -0x60(%rbp)
               	movl	0x54(%rsp), %r10d
               	movq	%r10, -0x68(%rbp)
               	movl	0x58(%rsp), %r10d
               	movq	%r10, -0x70(%rbp)
               	movl	0x5c(%rsp), %r10d
               	movq	%r10, -0x78(%rbp)
               	movl	0x60(%rsp), %r10d
               	movq	%r10, -0x80(%rbp)
               	movl	0x64(%rsp), %r10d
               	movq	%r10, -0x88(%rbp)
               	movl	0x68(%rsp), %r10d
               	movq	%r10, -0x90(%rbp)
               	movl	0x6c(%rsp), %r10d
               	movq	%r10, -0x98(%rbp)
               	movl	0x70(%rsp), %r10d
               	movq	%r10, -0xa0(%rbp)
               	movl	0x74(%rsp), %r10d
               	movq	%r10, -0xa8(%rbp)
               	movl	0x78(%rsp), %r10d
               	movq	%r10, -0xb0(%rbp)
               	movl	0x7c(%rsp), %r10d
               	movq	%r10, -0xb8(%rbp)
               	movslq	%eax, %rax
               	movq	-0x80(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x80(%rbp)
               	andq	-0x80(%rbp), %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movslq	%r13d, %r13
               	movq	-0x88(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x80(%rbp)
               	andq	-0x80(%rbp), %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	movslq	%r15d, %r13
               	movq	-0x90(%rbp), %r15
               	movslq	%r15d, %r15
               	andq	%r15, %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	movq	-0x58(%rbp), %r13
               	movslq	%r13d, %r13
               	movq	-0x98(%rbp), %r15
               	movslq	%r15d, %r15
               	andq	%r15, %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	movq	-0x60(%rbp), %r13
               	movslq	%r13d, %r13
               	movq	-0xa0(%rbp), %r15
               	movslq	%r15d, %r15
               	andq	%r15, %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	movq	-0x68(%rbp), %r13
               	movslq	%r13d, %r13
               	movq	-0xa8(%rbp), %r15
               	movslq	%r15d, %r15
               	andq	%r15, %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	movq	-0x70(%rbp), %r13
               	movslq	%r13d, %r13
               	movq	-0xb0(%rbp), %r15
               	movslq	%r15d, %r15
               	andq	%r15, %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	movq	-0x78(%rbp), %r13
               	movslq	%r13d, %r13
               	movq	-0xb8(%rbp), %r15
               	movslq	%r15d, %r15
               	andq	%r15, %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%rax, %r13
               	xorl	%eax, %eax
               	testl	%r13d, %r13d
               	jne	<addr>
               	movl	0x40(%rsp), %eax
               	movl	0x44(%rsp), %r13d
               	movl	0x48(%rsp), %r15d
               	movl	0x4c(%rsp), %r10d
               	movq	%r10, -0x58(%rbp)
               	movl	0x50(%rsp), %r10d
               	movq	%r10, -0x60(%rbp)
               	movl	0x54(%rsp), %r10d
               	movq	%r10, -0x68(%rbp)
               	movl	0x58(%rsp), %r10d
               	movq	%r10, -0x70(%rbp)
               	movl	0x5c(%rsp), %r10d
               	movq	%r10, -0x78(%rbp)
               	movl	0x60(%rsp), %r10d
               	movq	%r10, -0x80(%rbp)
               	movl	0x64(%rsp), %r10d
               	movq	%r10, -0x88(%rbp)
               	movl	0x68(%rsp), %r10d
               	movq	%r10, -0x90(%rbp)
               	movl	0x6c(%rsp), %r10d
               	movq	%r10, -0x98(%rbp)
               	movl	0x70(%rsp), %r10d
               	movq	%r10, -0xa0(%rbp)
               	movl	0x74(%rsp), %r10d
               	movq	%r10, -0xa8(%rbp)
               	movl	0x78(%rsp), %r10d
               	movq	%r10, -0xb0(%rbp)
               	movl	0x7c(%rsp), %r10d
               	movq	%r10, -0xb8(%rbp)
               	movslq	%eax, %rax
               	xorq	$-0x1, %rax
               	movq	-0x80(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x80(%rbp)
               	andq	-0x80(%rbp), %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movslq	%r13d, %r13
               	xorq	$-0x1, %r13
               	movq	-0x88(%rbp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, -0x80(%rbp)
               	andq	-0x80(%rbp), %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	movslq	%r15d, %r13
               	xorq	$-0x1, %r13
               	movq	-0x90(%rbp), %r15
               	movslq	%r15d, %r15
               	andq	%r15, %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	movq	-0x58(%rbp), %r13
               	movslq	%r13d, %r13
               	xorq	$-0x1, %r13
               	movq	-0x98(%rbp), %r15
               	movslq	%r15d, %r15
               	andq	%r15, %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	movq	-0x60(%rbp), %r13
               	movslq	%r13d, %r13
               	xorq	$-0x1, %r13
               	movq	-0xa0(%rbp), %r15
               	movslq	%r15d, %r15
               	andq	%r15, %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	movq	-0x68(%rbp), %r13
               	movslq	%r13d, %r13
               	xorq	$-0x1, %r13
               	movq	-0xa8(%rbp), %r15
               	movslq	%r15d, %r15
               	andq	%r15, %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	movq	-0x70(%rbp), %r13
               	movslq	%r13d, %r13
               	xorq	$-0x1, %r13
               	movq	-0xb0(%rbp), %r15
               	movslq	%r15d, %r15
               	andq	%r15, %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	movq	-0x78(%rbp), %r13
               	movslq	%r13d, %r13
               	xorq	$-0x1, %r13
               	movq	-0xb8(%rbp), %r15
               	movslq	%r15d, %r15
               	andq	%r15, %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	jmp	<addr>
               	cmpl	$0x10, %r8d
               	jne	<addr>
               	leaq	0xe0(%rsp), %rax
               	movups	(%r9), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xf0(%rsp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0xe0(%rsp), %rax
               	movq	0xe8(%rsp), %rsi
               	movq	0xf0(%rsp), %rdi
               	movq	0xf8(%rsp), %r13
               	andq	%rdi, %rax
               	testq	%rax, %rax
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%r13, %rsi
               	testq	%rsi, %rsi
               	setge	%al
               	movzbq	%al, %rax
               	andq	%rax, %rdi
               	movq	0xe0(%rsp), %rax
               	movq	0xe8(%rsp), %rsi
               	movq	0xf0(%rsp), %r13
               	movq	0xf8(%rsp), %r15
               	xorq	$-0x1, %rax
               	andq	%r13, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	xorq	$-0x1, %rsi
               	andq	%r15, %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rax, %rsi
               	movq	0xe0(%rsp), %r13
               	movq	0xe8(%rsp), %r15
               	movq	0xf0(%rsp), %r10
               	movq	%r10, -0x58(%rbp)
               	movq	0xf8(%rsp), %r10
               	movq	%r10, -0x60(%rbp)
               	movq	%r13, %rax
               	andq	-0x58(%rbp), %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movq	%r15, %r10
               	andq	-0x60(%rbp), %r10
               	movq	%r10, -0x68(%rbp)
               	movq	-0x68(%rbp), %r10
               	testq	%r10, %r10
               	setge	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x68(%rbp)
               	movq	%rax, %r10
               	andq	-0x68(%rbp), %r10
               	movq	%r10, -0x68(%rbp)
               	xorl	%eax, %eax
               	movq	-0x68(%rbp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	xorq	$-0x1, %r13
               	andq	-0x58(%rbp), %r13
               	testq	%r13, %r13
               	setge	%al
               	movzbq	%al, %rax
               	xorq	$-0x1, %r15
               	andq	-0x60(%rbp), %r15
               	testq	%r15, %r15
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	jmp	<addr>
               	leaq	0x80(%rsp), %rax
               	movups	(%r9), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%r9), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0xa0(%rsp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rbx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movq	0x80(%rsp), %rax
               	movq	0x88(%rsp), %rsi
               	movq	0x90(%rsp), %rdi
               	movq	0x98(%rsp), %r13
               	movq	0xa0(%rsp), %r15
               	movq	0xa8(%rsp), %r10
               	movq	%r10, -0x58(%rbp)
               	movq	0xb0(%rsp), %r10
               	movq	%r10, -0x60(%rbp)
               	movq	0xb8(%rsp), %r10
               	movq	%r10, -0x68(%rbp)
               	andq	%r15, %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	andq	-0x58(%rbp), %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	andq	-0x60(%rbp), %rdi
               	testq	%rdi, %rdi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	andq	-0x68(%rbp), %r13
               	testq	%r13, %r13
               	setge	%dil
               	movzbq	%dil, %rdi
               	andq	%rax, %rdi
               	movq	0x80(%rsp), %rax
               	movq	0x88(%rsp), %rsi
               	movq	0x90(%rsp), %r13
               	movq	0x98(%rsp), %r15
               	movq	0xa0(%rsp), %r10
               	movq	%r10, -0x58(%rbp)
               	movq	0xa8(%rsp), %r10
               	movq	%r10, -0x60(%rbp)
               	movq	0xb0(%rsp), %r10
               	movq	%r10, -0x68(%rbp)
               	movq	0xb8(%rsp), %r10
               	movq	%r10, -0x70(%rbp)
               	xorq	$-0x1, %rax
               	andq	-0x58(%rbp), %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	xorq	$-0x1, %rsi
               	andq	-0x60(%rbp), %rsi
               	testq	%rsi, %rsi
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	xorq	$-0x1, %r13
               	andq	-0x68(%rbp), %r13
               	testq	%r13, %r13
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	xorq	$-0x1, %r15
               	andq	-0x70(%rbp), %r15
               	testq	%r15, %r15
               	setge	%sil
               	movzbq	%sil, %rsi
               	andq	%rax, %rsi
               	movq	0x80(%rsp), %r13
               	movq	0x88(%rsp), %r15
               	movq	0x90(%rsp), %r10
               	movq	%r10, -0x58(%rbp)
               	movq	0x98(%rsp), %r10
               	movq	%r10, -0x60(%rbp)
               	movq	0xa0(%rsp), %r10
               	movq	%r10, -0x68(%rbp)
               	movq	0xa8(%rsp), %r10
               	movq	%r10, -0x70(%rbp)
               	movq	0xb0(%rsp), %r10
               	movq	%r10, -0x78(%rbp)
               	movq	0xb8(%rsp), %r10
               	movq	%r10, -0x80(%rbp)
               	movq	%r13, %rax
               	andq	-0x68(%rbp), %rax
               	testq	%rax, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movq	%r15, %r10
               	andq	-0x70(%rbp), %r10
               	movq	%r10, -0x88(%rbp)
               	movq	-0x88(%rbp), %r10
               	testq	%r10, %r10
               	setge	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x88(%rbp)
               	andq	-0x88(%rbp), %rax
               	movq	-0x58(%rbp), %r10
               	andq	-0x78(%rbp), %r10
               	movq	%r10, -0x88(%rbp)
               	movq	-0x88(%rbp), %r10
               	testq	%r10, %r10
               	setge	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x88(%rbp)
               	andq	-0x88(%rbp), %rax
               	movq	-0x60(%rbp), %r10
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
               	xorq	$-0x1, %r13
               	andq	-0x68(%rbp), %r13
               	testq	%r13, %r13
               	setge	%al
               	movzbq	%al, %rax
               	xorq	$-0x1, %r15
               	andq	-0x70(%rbp), %r15
               	testq	%r15, %r15
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	movq	-0x58(%rbp), %r13
               	xorq	$-0x1, %r13
               	andq	-0x78(%rbp), %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	movq	-0x60(%rbp), %r13
               	xorq	$-0x1, %r13
               	andq	-0x80(%rbp), %r13
               	testq	%r13, %r13
               	setge	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	jmp	<addr>
               	orq	%rsi, %r14
               	addq	$0x10, %r8
               	cmpl	$0x20, %r8d
               	jle	<addr>
               	addq	$0x4, %r12
               	cmpl	$0x8, %r12d
               	jle	<addr>
               	movq	-0xc0(%rbp), %r10
               	incq	%r10
               	movq	%r10, -0xc0(%rbp)
               	movq	-0xc0(%rbp), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	testq	%r14, %r14
               	je	<addr>
               	movl	$0x40, %eax
               	leaq	-0x100(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>

<check_permutes_and_halves>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1e8, %rsp            # imm = 0x1E8
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x160, %rsp            # imm = 0x160
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
               	leaq	(%rsp), %rax
               	leaq	0x80(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x80(%rsp), %rax
               	leaq	0x120(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x120(%rsp), %rax
               	movq	%rbx, %rcx
               	andq	$0x3, %rcx
               	movl	(%rax,%rcx,4), %eax
               	movl	%eax, 0x80(%rsp)
               	leaq	0x120(%rsp), %rax
               	movq	%r12, %rcx
               	andq	$0x3, %rcx
               	movl	(%rax,%rcx,4), %eax
               	movl	%eax, 0x84(%rsp)
               	leaq	0x120(%rsp), %rax
               	movq	%r13, %rcx
               	andq	$0x3, %rcx
               	movl	(%rax,%rcx,4), %eax
               	movl	%eax, 0x88(%rsp)
               	leaq	0x120(%rsp), %rax
               	movq	%r14, %rcx
               	andq	$0x3, %rcx
               	movl	(%rax,%rcx,4), %eax
               	movl	%eax, 0x8c(%rsp)
               	leaq	0x120(%rsp), %rax
               	movq	%r15, %rcx
               	andq	$0x3, %rcx
               	orq	$0x4, %rcx
               	movl	(%rax,%rcx,4), %eax
               	movl	%eax, 0x90(%rsp)
               	leaq	0x120(%rsp), %rax
               	movq	-0x1b8(%rbp), %rcx
               	andq	$0x3, %rcx
               	orq	$0x4, %rcx
               	movl	(%rax,%rcx,4), %eax
               	movl	%eax, 0x94(%rsp)
               	leaq	0x120(%rsp), %rax
               	movq	-0x1c0(%rbp), %rcx
               	andq	$0x3, %rcx
               	orq	$0x4, %rcx
               	movl	(%rax,%rcx,4), %eax
               	movl	%eax, 0x98(%rsp)
               	leaq	0x120(%rsp), %rax
               	movq	-0x1c8(%rbp), %rcx
               	andq	$0x3, %rcx
               	orq	$0x4, %rcx
               	movl	(%rax,%rcx,4), %eax
               	movl	%eax, 0x9c(%rsp)
               	movq	0x80(%rsp), %rax
               	movq	0x88(%rsp), %rcx
               	movq	0x90(%rsp), %rdx
               	movq	0x98(%rsp), %rsi
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%rdx, 0x50(%rsp)
               	movq	%rsi, 0x58(%rsp)
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
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, -0x1d0(%rbp)
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm1
               	vmovups	0x20(%rsp), %ymm0
               	movups	%xmm1, 0x80(%rsp)
               	leaq	0x80(%rsp), %rax
               	vmovd	%xmm0, %ecx
               	movslq	%ecx, %rcx
               	andq	$0x3, %rcx
               	movslq	(%rax,%rcx,4), %rax
               	xorl	%ecx, %ecx
               	vmovd	%eax, %xmm1
               	leaq	0x80(%rsp), %rax
               	vpextrd	$0x1, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	andq	$0x3, %rcx
               	movslq	(%rax,%rcx,4), %rax
               	vpinsrd	$0x1, %eax, %xmm1, %xmm1
               	leaq	0x80(%rsp), %rax
               	vpextrd	$0x2, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	andq	$0x3, %rcx
               	movslq	(%rax,%rcx,4), %rax
               	vpinsrd	$0x2, %eax, %xmm1, %xmm1
               	leaq	0x80(%rsp), %rax
               	vpextrd	$0x3, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	andq	$0x3, %rcx
               	movslq	(%rax,%rcx,4), %rax
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	movups	%xmm0, 0x140(%rsp)
               	leaq	0x140(%rsp), %rdi
               	leaq	-0x1a8(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	vzeroupper
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
               	vmovups	(%rsp), %ymm0
               	movq	0x20(%rsp), %rax
               	movq	0x28(%rsp), %rcx
               	movq	0x30(%rsp), %rdx
               	movq	0x38(%rsp), %rsi
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	0x80(%rsp), %rdi
               	sarq	%rax
               	andq	$0x1, %rax
               	movq	(%rdi,%rax,8), %rax
               	leaq	0x80(%rsp), %rdi
               	sarq	%rcx
               	andq	$0x1, %rcx
               	movq	(%rdi,%rcx,8), %rcx
               	leaq	0x80(%rsp), %rdi
               	sarq	%rdx
               	andq	$0x1, %rdx
               	orq	$0x2, %rdx
               	movq	(%rdi,%rdx,8), %rdx
               	leaq	0x80(%rsp), %rdi
               	sarq	%rsi
               	andq	$0x1, %rsi
               	orq	$0x2, %rsi
               	movq	(%rdi,%rsi,8), %rsi
               	movq	%rax, 0x60(%rsp)
               	movq	%rcx, 0x68(%rsp)
               	movq	%rdx, 0x70(%rsp)
               	movq	%rsi, 0x78(%rsp)
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
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	-0x1d0(%rbp), %r10
               	orq	%rax, %r10
               	movq	%r10, -0x1d0(%rbp)
               	vmovups	(%rsp), %ymm0
               	vmovdqa	%xmm0, %xmm1
               	vmovups	0x20(%rsp), %ymm0
               	movups	%xmm1, 0x80(%rsp)
               	leaq	0x80(%rsp), %rax
               	vmovq	%xmm0, %rcx
               	sarq	%rcx
               	andq	$0x1, %rcx
               	movq	(%rax,%rcx,8), %rax
               	xorl	%ecx, %ecx
               	vmovq	%rax, %xmm1
               	leaq	0x80(%rsp), %rax
               	vpextrq	$0x1, %xmm0, %rcx
               	sarq	%rcx
               	andq	$0x1, %rcx
               	movq	(%rax,%rcx,8), %rax
               	movapd	%xmm1, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	movups	%xmm0, 0x150(%rsp)
               	leaq	0x150(%rsp), %rdi
               	leaq	-0x168(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	vzeroupper
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
               	vmovups	(%rsp), %ymm0
               	vpermq	$0x9c, %ymm0, %ymm0     # ymm0 = ymm0[0,3,1,2]
               	vmovups	%ymm0, 0x60(%rsp)
               	leaq	0x60(%rsp), %rdi
               	leaq	-0x168(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
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
               	leaq	0x40(%rsp), %rdi
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vpermd	%ymm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	leaq	-0x1a8(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
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
               	leaq	0x80(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	vmovups	0x80(%rsp), %ymm14
               	vmovups	%ymm14, -0x1d0(%rbp)
               	vmovups	-0x1d0(%rbp), %ymm14
               	movups	%xmm14, -0x1e0(%rbp)
               	movl	$0x8, %edi
               	movups	-0x1e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0,0,0]
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	-0x1e0(%rbp), %xmm14
               	vpinsrd	$0x0, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x1e0(%rbp)
               	movups	-0x1e0(%rbp), %xmm14
               	vpermilps	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0,0,0]
               	movl	$0x8, %edi
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	-0x1e0(%rbp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x1e0(%rbp)
               	movups	-0x1e0(%rbp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	movl	$0x8, %edi
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	-0x1e0(%rbp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x1e0(%rbp)
               	movups	-0x1e0(%rbp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	movl	$0x8, %edi
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	-0x1e0(%rbp), %xmm14
               	vpinsrd	$0x3, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x1e0(%rbp)
               	vmovups	-0x1d0(%rbp), %ymm14
               	vextracti128	$0x1, %ymm14, %xmm14
               	movups	%xmm14, -0x1c0(%rbp)
               	movl	$0x8, %edi
               	movups	-0x1c0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0,0,0]
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	-0x1c0(%rbp), %xmm14
               	vpinsrd	$0x0, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x1c0(%rbp)
               	movups	-0x1c0(%rbp), %xmm14
               	vpermilps	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0,0,0]
               	movl	$0x8, %edi
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	-0x1c0(%rbp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x1c0(%rbp)
               	movups	-0x1c0(%rbp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	movl	$0x8, %edi
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	-0x1c0(%rbp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x1c0(%rbp)
               	movups	-0x1c0(%rbp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	movl	$0x8, %edi
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	-0x1c0(%rbp), %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	movups	-0x1e0(%rbp), %xmm15
               	vmovdqa	%xmm15, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0xa0(%rsp)
               	vmovups	0x80(%rsp), %ymm14
               	vmovups	%ymm14, -0x1d0(%rbp)
               	vmovups	-0x1d0(%rbp), %ymm14
               	movups	%xmm14, -0x1e0(%rbp)
               	movl	$0x1, %edi
               	movups	-0x1e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0,0,0]
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	-0x1e0(%rbp), %xmm14
               	vpinsrd	$0x0, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x1e0(%rbp)
               	movups	-0x1e0(%rbp), %xmm14
               	vpermilps	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0,0,0]
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	-0x1e0(%rbp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x1e0(%rbp)
               	movups	-0x1e0(%rbp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	-0x1e0(%rbp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x1e0(%rbp)
               	movups	-0x1e0(%rbp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	-0x1e0(%rbp), %xmm14
               	vpinsrd	$0x3, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x1e0(%rbp)
               	vmovups	-0x1d0(%rbp), %ymm14
               	vextracti128	$0x1, %ymm14, %xmm14
               	movups	%xmm14, -0x1c0(%rbp)
               	movl	$0x1, %edi
               	movups	-0x1c0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0,0,0]
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	-0x1c0(%rbp), %xmm14
               	vpinsrd	$0x0, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x1c0(%rbp)
               	movups	-0x1c0(%rbp), %xmm14
               	vpermilps	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0,0,0]
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	-0x1c0(%rbp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x1c0(%rbp)
               	movups	-0x1c0(%rbp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	-0x1c0(%rbp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x1c0(%rbp)
               	movups	-0x1c0(%rbp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	-0x1c0(%rbp), %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	movups	-0x1e0(%rbp), %xmm15
               	vmovdqa	%xmm15, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0xc0(%rsp)
               	vmovups	0x80(%rsp), %ymm14
               	vmovups	%ymm14, -0x1d0(%rbp)
               	vmovups	-0x1d0(%rbp), %ymm14
               	movups	%xmm14, -0x1e0(%rbp)
               	movl	$0x2, %edi
               	movups	-0x1e0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0,0,0]
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	-0x1e0(%rbp), %xmm14
               	vpinsrd	$0x0, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x1e0(%rbp)
               	movups	-0x1e0(%rbp), %xmm14
               	vpermilps	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0,0,0]
               	movl	$0x2, %edi
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	-0x1e0(%rbp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x1e0(%rbp)
               	movups	-0x1e0(%rbp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	movl	$0x2, %edi
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	-0x1e0(%rbp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x1e0(%rbp)
               	movups	-0x1e0(%rbp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	movl	$0x2, %edi
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	-0x1e0(%rbp), %xmm14
               	vpinsrd	$0x3, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x1e0(%rbp)
               	vmovups	-0x1d0(%rbp), %ymm14
               	vextracti128	$0x1, %ymm14, %xmm14
               	movups	%xmm14, -0x1c0(%rbp)
               	movl	$0x2, %edi
               	movups	-0x1c0(%rbp), %xmm14
               	vpermilps	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0,0,0]
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	-0x1c0(%rbp), %xmm14
               	vpinsrd	$0x0, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x1c0(%rbp)
               	movups	-0x1c0(%rbp), %xmm14
               	vpermilps	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0,0,0]
               	movl	$0x2, %edi
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	-0x1c0(%rbp), %xmm14
               	vpinsrd	$0x1, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x1c0(%rbp)
               	movups	-0x1c0(%rbp), %xmm14
               	vpermilps	$0x2, %xmm14, %xmm0 # xmm0 = xmm14[2,0,0,0]
               	movl	$0x2, %edi
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	-0x1c0(%rbp), %xmm14
               	vpinsrd	$0x2, %r11d, %xmm14, %xmm14
               	movups	%xmm14, -0x1c0(%rbp)
               	movups	-0x1c0(%rbp), %xmm14
               	vpermilps	$0x3, %xmm14, %xmm0 # xmm0 = xmm14[3,0,0,0]
               	movl	$0x2, %edi
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %r11d
               	movups	-0x1c0(%rbp), %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	movups	-0x1e0(%rbp), %xmm15
               	vmovdqa	%xmm15, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0xe0(%rsp)
               	leaq	0xa0(%rsp), %rdi
               	leaq	-0x128(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0xc0(%rsp), %rdi
               	leaq	-0x108(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
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
               	vzeroupper
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
               	leaq	0x80(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	vmovups	0x80(%rsp), %ymm14
               	vmovups	%ymm14, -0x1d0(%rbp)
               	vmovups	-0x1d0(%rbp), %ymm14
               	movups	%xmm14, -0x1e0(%rbp)
               	movl	$0x3, %edi
               	movups	-0x1e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0]
               	vzeroupper
               	callq	<addr>
               	vmovq	%xmm0, %r11
               	movups	-0x1e0(%rbp), %xmm14
               	vpinsrq	$0x0, %r11, %xmm14, %xmm14
               	movups	%xmm14, -0x1e0(%rbp)
               	movups	-0x1e0(%rbp), %xmm14
               	vpermilpd	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0]
               	movl	$0x3, %edi
               	vzeroupper
               	callq	<addr>
               	vmovq	%xmm0, %r11
               	movups	-0x1e0(%rbp), %xmm14
               	vpinsrq	$0x1, %r11, %xmm14, %xmm14
               	movups	%xmm14, -0x1e0(%rbp)
               	vmovups	-0x1d0(%rbp), %ymm14
               	vextracti128	$0x1, %ymm14, %xmm14
               	movups	%xmm14, -0x1c0(%rbp)
               	movl	$0x3, %edi
               	movups	-0x1c0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0]
               	vzeroupper
               	callq	<addr>
               	vmovq	%xmm0, %r11
               	movups	-0x1c0(%rbp), %xmm14
               	vpinsrq	$0x0, %r11, %xmm14, %xmm14
               	movups	%xmm14, -0x1c0(%rbp)
               	movups	-0x1c0(%rbp), %xmm14
               	vpermilpd	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0]
               	movl	$0x3, %edi
               	vzeroupper
               	callq	<addr>
               	vmovq	%xmm0, %r11
               	movups	-0x1c0(%rbp), %xmm0
               	vpinsrq	$0x1, %r11, %xmm0, %xmm0
               	movups	-0x1e0(%rbp), %xmm15
               	vmovdqa	%xmm15, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x100(%rsp)
               	vmovups	0x80(%rsp), %ymm14
               	vmovups	%ymm14, -0x1d0(%rbp)
               	vmovups	-0x1d0(%rbp), %ymm14
               	movups	%xmm14, -0x1e0(%rbp)
               	movl	$0x2, %edi
               	movups	-0x1e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0]
               	vzeroupper
               	callq	<addr>
               	vmovq	%xmm0, %r11
               	movups	-0x1e0(%rbp), %xmm14
               	vpinsrq	$0x0, %r11, %xmm14, %xmm14
               	movups	%xmm14, -0x1e0(%rbp)
               	movups	-0x1e0(%rbp), %xmm14
               	vpermilpd	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0]
               	movl	$0x2, %edi
               	vzeroupper
               	callq	<addr>
               	vmovq	%xmm0, %r11
               	movups	-0x1e0(%rbp), %xmm14
               	vpinsrq	$0x1, %r11, %xmm14, %xmm14
               	movups	%xmm14, -0x1e0(%rbp)
               	vmovups	-0x1d0(%rbp), %ymm14
               	vextracti128	$0x1, %ymm14, %xmm14
               	movups	%xmm14, -0x1c0(%rbp)
               	movl	$0x2, %edi
               	movups	-0x1c0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0]
               	vzeroupper
               	callq	<addr>
               	vmovq	%xmm0, %r11
               	movups	-0x1c0(%rbp), %xmm14
               	vpinsrq	$0x0, %r11, %xmm14, %xmm14
               	movups	%xmm14, -0x1c0(%rbp)
               	movups	-0x1c0(%rbp), %xmm14
               	vpermilpd	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0]
               	movl	$0x2, %edi
               	vzeroupper
               	callq	<addr>
               	vmovq	%xmm0, %r11
               	movups	-0x1c0(%rbp), %xmm0
               	vpinsrq	$0x1, %r11, %xmm0, %xmm0
               	movups	-0x1e0(%rbp), %xmm15
               	vmovdqa	%xmm15, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, (%rsp)
               	vmovups	0x80(%rsp), %ymm14
               	vmovups	%ymm14, -0x1d0(%rbp)
               	vmovups	-0x1d0(%rbp), %ymm14
               	movups	%xmm14, -0x1e0(%rbp)
               	movl	$0x1, %edi
               	movups	-0x1e0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0]
               	vzeroupper
               	callq	<addr>
               	vmovq	%xmm0, %r11
               	movups	-0x1e0(%rbp), %xmm14
               	vpinsrq	$0x0, %r11, %xmm14, %xmm14
               	movups	%xmm14, -0x1e0(%rbp)
               	movups	-0x1e0(%rbp), %xmm14
               	vpermilpd	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0]
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	vmovq	%xmm0, %r11
               	movups	-0x1e0(%rbp), %xmm14
               	vpinsrq	$0x1, %r11, %xmm14, %xmm14
               	movups	%xmm14, -0x1e0(%rbp)
               	vmovups	-0x1d0(%rbp), %ymm14
               	vextracti128	$0x1, %ymm14, %xmm14
               	movups	%xmm14, -0x1c0(%rbp)
               	movl	$0x1, %edi
               	movups	-0x1c0(%rbp), %xmm14
               	vpermilpd	$0x0, %xmm14, %xmm0 # xmm0 = xmm14[0,0]
               	vzeroupper
               	callq	<addr>
               	vmovq	%xmm0, %r11
               	movups	-0x1c0(%rbp), %xmm14
               	vpinsrq	$0x0, %r11, %xmm14, %xmm14
               	movups	%xmm14, -0x1c0(%rbp)
               	movups	-0x1c0(%rbp), %xmm14
               	vpermilpd	$0x1, %xmm14, %xmm0 # xmm0 = xmm14[1,0]
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	vmovq	%xmm0, %r11
               	movups	-0x1c0(%rbp), %xmm0
               	vpinsrq	$0x1, %r11, %xmm0, %xmm0
               	movups	-0x1e0(%rbp), %xmm15
               	vmovdqa	%xmm15, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, 0x20(%rsp)
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
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	(%rsp), %rdi
               	leaq	-0xa8(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	0x20(%rsp), %rdi
               	leaq	-0x88(%rbp), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
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
               	leaq	0x120(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x80(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	vmovups	0x120(%rsp), %ymm2
               	vmovups	0x80(%rsp), %ymm3
               	vmovdqa	%xmm2, %xmm0
               	vmovdqa	%xmm3, %xmm1
               	leaq	0x120(%rsp), %rsi
               	movups	%xmm0, 0x120(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	movl	$0xb5, %edx
               	xorl	%eax, %eax
               	leaq	-0x38(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	leaq	0x4(%rax), %r8
               	sarxq	%r8, %rdx, %r8
               	testb	$0x1, %r8b
               	je	<addr>
               	leaq	(%rsi,%rcx), %r8
               	movss	(%r8), %xmm0
               	leaq	0x80(%rsp), %r8
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
               	leaq	-0x38(%rbp), %rsi
               	xorl	%eax, %eax
               	movss	-0x38(%rbp), %xmm0
               	movss	-0x34(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0x30(%rbp), %xmm1
               	movss	-0x2c(%rbp), %xmm4
               	addss	%xmm4, %xmm1
               	addss	%xmm1, %xmm0
               	leaq	0x120(%rsp), %rcx
               	movq	%rax, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %rcx
               	sarxq	%rax, %rdx, %rdi
               	testb	$0x1, %dil
               	je	<addr>
               	movapd	%xmm0, %xmm1
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm1
               	movss	%xmm1, (%rcx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x120(%rsp), %rdi
               	movups	0x120(%rsp), %xmm4
               	vextracti128	$0x1, %ymm2, %xmm0
               	vextracti128	$0x1, %ymm3, %xmm1
               	movups	%xmm0, 0x120(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	movl	$0xb5, %edx
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rsi,%rcx), %r8
               	leaq	0x4(%rax), %r9
               	sarxq	%r9, %rdx, %r9
               	testb	$0x1, %r9b
               	je	<addr>
               	leaq	(%rdi,%rcx), %r9
               	movss	(%r9), %xmm0
               	leaq	0x80(%rsp), %r9
               	addq	%r9, %rcx
               	movss	(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	movss	%xmm0, (%r8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movss	-0x38(%rbp), %xmm0
               	movss	-0x34(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	-0x30(%rbp), %xmm1
               	movss	-0x2c(%rbp), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	leaq	0x120(%rsp), %rcx
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
               	movups	0x120(%rsp), %xmm0
               	vmovdqa	%xmm4, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	leaq	0x80(%rsp), %rdi
               	vmovups	%ymm0, 0x80(%rsp)
               	leaq	-0x48(%rbp), %rsi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rbx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x80, %eax
               	leaq	-0x210(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
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
