
int128_fp_convert.x64:	file format elf64-x86-64

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

<chk_to_fp>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdx, %rbx
               	movq	%rcx, %r12
               	leaq	<rip>, %rax
               	movq	%rdi, (%rax)
               	leaq	<rip>, %rdi
               	movq	%rsi, (%rdi)
               	movq	(%rax), %rax
               	movq	(%rdi), %rcx
               	leaq	-0x10(%rbp), %rsi
               	movq	%rax, (%rsi)
               	xorl	%edi, %edi
               	movq	%rdi, 0x8(%rsi)
               	orq	%rcx, %rdi
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	setne	%r13b
               	movzbq	%r13b, %r13
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x5, %rcx
               	leaq	0x1(%rcx), %r14
               	movq	%rax, %rsi
               	shrq	%cl, %rsi
               	movq	%rsi, %rcx
               	shrq	$0x10, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %r14
               	shrq	%cl, %rsi
               	movq	%rsi, %rcx
               	shrq	$0x8, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %r14
               	shrq	%cl, %rsi
               	movq	%rsi, %rcx
               	shrq	$0x4, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %r14
               	shrq	%cl, %rsi
               	movq	%rsi, %rcx
               	shrq	$0x2, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
               	addq	%rcx, %r14
               	shrq	%cl, %rsi
               	movq	%rsi, %rcx
               	shrq	%rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	leaq	(%r14,%rcx), %rsi
               	imulq	%r13, %rsi
               	movl	$0x40, %ecx
               	subq	%rsi, %rcx
               	andq	$0x3f, %rcx
               	movq	$-0x1, %r13
               	movq	%rcx, %r10
               	movq	%r13, %r11
               	movq	%r10, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	testq	%rsi, %rsi
               	setne	%r13b
               	movzbq	%r13b, %r13
               	imulq	%r13, %rcx
               	andq	%rdi, %rcx
               	testq	%rcx, %rcx
               	setne	%r13b
               	movzbq	%r13b, %r13
               	movq	%rsi, %r14
               	andq	$0x7f, %r14
               	movq	%rsi, %rcx
               	andq	$0x3f, %rcx
               	movl	$0x3f, %r15d
               	subq	%rcx, %r15
               	shrq	$0x6, %r14
               	subq	%r14, %rdx
               	movq	%rdx, %r14
               	xorq	$-0x1, %r14
               	movq	%rax, %r10
               	shrq	%cl, %r10
               	movq	%r10, 0x38(%rsp)
               	pushq	%rcx
               	movq	%r15, %rcx
               	shlq	%cl, %rax
               	popq	%rcx
               	shlq	%rax
               	shrq	%cl, %rdi
               	orq	%rdi, %rax
               	andq	%r14, %rax
               	movq	0x38(%rsp), %rcx
               	andq	%rdx, %rcx
               	orq	%rcx, %rax
               	orq	%r13, %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm0
               	addsd	%xmm0, %xmm0
               	leaq	0x3ff(%rsi), %rax
               	shlq	$0x34, %rax
               	movq	%rax, -0x18(%rbp)
               	movsd	-0x18(%rbp), %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	cmpq	%rbx, %rax
               	je	<addr>
               	movslq	0x10(%rbp), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, (%rdx)
               	xorl	%esi, %esi
               	movq	%rsi, 0x8(%rdx)
               	movq	%rsi, %rdi
               	orq	%rcx, %rdi
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x5, %rcx
               	leaq	0x1(%rcx), %r13
               	movq	%rax, %rdx
               	shrq	%cl, %rdx
               	movq	%rdx, %rcx
               	shrq	$0x10, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %r13
               	shrq	%cl, %rdx
               	movq	%rdx, %rcx
               	shrq	$0x8, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %r13
               	shrq	%cl, %rdx
               	movq	%rdx, %rcx
               	shrq	$0x4, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %r13
               	shrq	%cl, %rdx
               	movq	%rdx, %rcx
               	shrq	$0x2, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
               	addq	%rcx, %r13
               	shrq	%cl, %rdx
               	movq	%rdx, %rcx
               	shrq	%rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	leaq	(%r13,%rcx), %rdx
               	imulq	%rbx, %rdx
               	movl	$0x40, %ecx
               	subq	%rdx, %rcx
               	andq	$0x3f, %rcx
               	movq	$-0x1, %rbx
               	movq	%rcx, %r10
               	movq	%rbx, %r11
               	movq	%r10, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	testq	%rdx, %rdx
               	setne	%bl
               	movzbq	%bl, %rbx
               	imulq	%rbx, %rcx
               	andq	%rdi, %rcx
               	testq	%rcx, %rcx
               	setne	%bl
               	movzbq	%bl, %rbx
               	movq	%rdx, %r13
               	andq	$0x7f, %r13
               	movq	%rdx, %rcx
               	andq	$0x3f, %rcx
               	movl	$0x3f, %r14d
               	subq	%rcx, %r14
               	shrq	$0x6, %r13
               	subq	%r13, %rsi
               	movq	%rsi, %r13
               	xorq	$-0x1, %r13
               	movq	%rax, %r15
               	shrq	%cl, %r15
               	pushq	%rcx
               	movq	%r14, %rcx
               	shlq	%cl, %rax
               	popq	%rcx
               	shlq	%rax
               	shrq	%cl, %rdi
               	orq	%rdi, %rax
               	andq	%r13, %rax
               	movq	%r15, %rcx
               	andq	%rsi, %rcx
               	orq	%rcx, %rax
               	orq	%rbx, %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm0
               	addss	%xmm0, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	leaq	0x3ff(%rdx), %rax
               	shlq	$0x34, %rax
               	movq	%rax, -0x18(%rbp)
               	movsd	-0x18(%rbp), %xmm1
               	mulsd	%xmm1, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	leaq	-0x10(%rbp), %rax
               	movss	%xmm0, (%rax)
               	movl	(%rax), %ecx
               	cmpl	%r12d, %ecx
               	je	<addr>
               	movslq	0x10(%rbp), %rax
               	incq	%rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	movq	%rcx, (%rax)
               	xorl	%edx, %edx
               	movq	%rdx, 0x8(%rax)
               	orq	%rsi, %rdx
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	xorq	%rax, %rdx
               	xorq	%rax, %rcx
               	cmpq	%rax, %rdx
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdx, %rsi
               	subq	%rax, %rsi
               	subq	%rax, %rcx
               	movq	%rcx, %rdx
               	subq	%rdi, %rdx
               	movabsq	$-0x8000000000000000, %rbx # imm = 0x8000000000000000
               	andq	%rax, %rbx
               	testq	%rdx, %rdx
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdx, %rax
               	shrq	$0x20, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, %rcx
               	shlq	$0x5, %rcx
               	leaq	0x1(%rcx), %r12
               	movq	%rdx, %rax
               	shrq	%cl, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %r12
               	shrq	%cl, %rax
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %r12
               	shrq	%cl, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %r12
               	shrq	%cl, %rax
               	movq	%rax, %rcx
               	shrq	$0x2, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
               	addq	%rcx, %r12
               	shrq	%cl, %rax
               	shrq	%rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	leaq	(%r12,%rcx), %rax
               	imulq	%rdi, %rax
               	movl	$0x40, %ecx
               	subq	%rax, %rcx
               	andq	$0x3f, %rcx
               	movq	$-0x1, %rdi
               	shrq	%cl, %rdi
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	imulq	%rdi, %rcx
               	andq	%rsi, %rcx
               	testq	%rcx, %rcx
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%rax, %rdi
               	andq	$0x7f, %rdi
               	movq	%rax, %rcx
               	andq	$0x3f, %rcx
               	movl	$0x3f, %r13d
               	subq	%rcx, %r13
               	shrq	$0x6, %rdi
               	xorl	%r14d, %r14d
               	negq	%rdi
               	addq	%r14, %rdi
               	movq	%rdi, %r14
               	xorq	$-0x1, %r14
               	movq	%rdx, %r15
               	shrq	%cl, %r15
               	pushq	%rcx
               	movq	%r13, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	shlq	%rdx
               	shrq	%cl, %rsi
               	movq	%rsi, %rcx
               	orq	%rdx, %rcx
               	andq	%r14, %rcx
               	movq	%r15, %rdx
               	andq	%rdi, %rdx
               	orq	%rdx, %rcx
               	orq	%r12, %rcx
               	xorps	%xmm0, %xmm0
               	movq	%rcx, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm0
               	addsd	%xmm0, %xmm0
               	addq	$0x3ff, %rax            # imm = 0x3FF
               	shlq	$0x34, %rax
               	orq	%rbx, %rax
               	movq	%rax, -0x18(%rbp)
               	movsd	-0x18(%rbp), %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	cmpq	%r8, %rax
               	je	<addr>
               	movslq	0x10(%rbp), %rax
               	addq	$0x2, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	leaq	-0x10(%rbp), %rax
               	movq	%rcx, (%rax)
               	xorl	%edx, %edx
               	movq	%rdx, 0x8(%rax)
               	orq	%rsi, %rdx
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	xorq	%rax, %rdx
               	xorq	%rax, %rcx
               	cmpq	%rax, %rdx
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdx, %rsi
               	subq	%rax, %rsi
               	subq	%rax, %rcx
               	movq	%rcx, %rdx
               	subq	%rdi, %rdx
               	movabsq	$-0x8000000000000000, %r8 # imm = 0x8000000000000000
               	andq	%rax, %r8
               	testq	%rdx, %rdx
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdx, %rax
               	shrq	$0x20, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, %rcx
               	shlq	$0x5, %rcx
               	leaq	0x1(%rcx), %rbx
               	movq	%rdx, %rax
               	shrq	%cl, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rbx
               	shrq	%cl, %rax
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rbx
               	shrq	%cl, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rbx
               	shrq	%cl, %rax
               	movq	%rax, %rcx
               	shrq	$0x2, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
               	addq	%rcx, %rbx
               	shrq	%cl, %rax
               	shrq	%rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	leaq	(%rbx,%rcx), %rax
               	imulq	%rdi, %rax
               	movl	$0x40, %ecx
               	subq	%rax, %rcx
               	andq	$0x3f, %rcx
               	movq	$-0x1, %rdi
               	shrq	%cl, %rdi
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	imulq	%rdi, %rcx
               	andq	%rsi, %rcx
               	testq	%rcx, %rcx
               	setne	%bl
               	movzbq	%bl, %rbx
               	movq	%rax, %rdi
               	andq	$0x7f, %rdi
               	movq	%rax, %rcx
               	andq	$0x3f, %rcx
               	movl	$0x3f, %r12d
               	subq	%rcx, %r12
               	shrq	$0x6, %rdi
               	xorl	%r13d, %r13d
               	negq	%rdi
               	addq	%r13, %rdi
               	movq	%rdi, %r13
               	xorq	$-0x1, %r13
               	movq	%rdx, %r14
               	shrq	%cl, %r14
               	pushq	%rcx
               	movq	%r12, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	shlq	%rdx
               	shrq	%cl, %rsi
               	movq	%rsi, %rcx
               	orq	%rdx, %rcx
               	andq	%r13, %rcx
               	movq	%r14, %rdx
               	andq	%rdi, %rdx
               	orq	%rdx, %rcx
               	orq	%rbx, %rcx
               	xorps	%xmm0, %xmm0
               	movq	%rcx, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2ss	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2ss	%r11, %xmm0
               	addss	%xmm0, %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	addq	$0x3ff, %rax            # imm = 0x3FF
               	shlq	$0x34, %rax
               	orq	%r8, %rax
               	movq	%rax, -0x18(%rbp)
               	movsd	-0x18(%rbp), %xmm1
               	mulsd	%xmm1, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	leaq	-0x10(%rbp), %rax
               	movss	%xmm0, (%rax)
               	movl	(%rax), %eax
               	cmpl	%r9d, %eax
               	je	<addr>
               	movslq	0x10(%rbp), %rax
               	addq	$0x3, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<chk_from_fp>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movslq	%edx, %r13
               	movq	%rsi, %r12
               	leaq	<rip>, %rax
               	movsd	%xmm0, (%rax)
               	movsd	(%rax), %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, %r10
               	sarq	$0x3f, %r10
               	movq	%r10, 0x48(%rsp)
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rcx, %rax
               	movq	%rax, %rdx
               	shrq	$0x34, %rdx
               	leaq	-0x3ff(%rdx), %rdi
               	movabsq	$0xfffffffffffff, %rax  # imm = 0xFFFFFFFFFFFFF
               	andq	%rcx, %rax
               	movabsq	$0x10000000000000, %r11 # imm = 0x10000000000000
               	orq	%r11, %rax
               	leaq	-0x433(%rdx), %rcx
               	movq	%rcx, %rdx
               	sarq	$0x3f, %rdx
               	xorq	%rdx, %rcx
               	subq	%rdx, %rcx
               	xorl	%r8d, %r8d
               	movq	%rcx, %rsi
               	andq	$0x7f, %rsi
               	andq	$0x3f, %rcx
               	movl	$0x3f, %r9d
               	movq	%r9, %r14
               	subq	%rcx, %r14
               	movq	%rsi, %r9
               	shrq	$0x6, %r9
               	movq	%r8, %rsi
               	subq	%r9, %rsi
               	movq	%rsi, %r9
               	xorq	$-0x1, %r9
               	movq	%rax, %r15
               	shlq	%cl, %r15
               	movq	%rax, %r10
               	pushq	%rcx
               	movq	%r14, %rcx
               	shrq	%cl, %r10
               	popq	%rcx
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	shrq	%r10
               	movq	%r10, 0x40(%rsp)
               	movq	%r8, %r10
               	shlq	%cl, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %r10
               	orq	0x40(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	%r15, %r10
               	andq	%r9, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x40(%rsp), %r10
               	andq	%r9, %r10
               	movq	%r10, 0x40(%rsp)
               	andq	%rsi, %r15
               	movq	0x40(%rsp), %r10
               	orq	%r15, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	%r8, %r15
               	shrq	%cl, %r15
               	movq	%r14, %r10
               	movq	%r8, %r14
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %r14
               	popq	%rcx
               	shlq	%r14
               	shrq	%cl, %rax
               	orq	%r14, %rax
               	andq	%r9, %rax
               	movq	%r15, %rcx
               	andq	%rsi, %rcx
               	orq	%rax, %rcx
               	movq	%r15, %rsi
               	andq	%r9, %rsi
               	movq	%rdx, %rax
               	xorq	$-0x1, %rax
               	movq	0x38(%rsp), %r9
               	andq	%rax, %r9
               	andq	%rdx, %rcx
               	orq	%r9, %rcx
               	movq	%rax, %r10
               	movq	0x40(%rsp), %rax
               	andq	%r10, %rax
               	andq	%rsi, %rdx
               	orq	%rax, %rdx
               	movq	%rdi, %rax
               	sarq	$0x3f, %rax
               	xorq	$-0x1, %rax
               	movq	%rcx, %rsi
               	andq	%rax, %rsi
               	andq	%rax, %rdx
               	cmpl	$0x80, %edi
               	setge	%al
               	movzbq	%al, %rax
               	movq	%r8, %rcx
               	subq	%rax, %rcx
               	movq	%rcx, %rax
               	xorq	$-0x1, %rax
               	andq	%rax, %rsi
               	orq	%rcx, %rsi
               	andq	%rdx, %rax
               	orq	%rax, %rcx
               	movq	0x48(%rsp), %rax
               	xorq	$-0x1, %rax
               	movq	%rsi, %rdx
               	andq	%rax, %rdx
               	andq	%rcx, %rax
               	cmpq	%rbx, %rax
               	jne	<addr>
               	cmpq	%r12, %rdx
               	je	<addr>
               	movq	%r13, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rax
               	movsd	(%rax), %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, %rdx
               	sarq	$0x3f, %rdx
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rcx, %rax
               	shrq	$0x34, %rax
               	leaq	-0x3ff(%rax), %r14
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$0x10000000000000, %rsi # imm = 0x10000000000000
               	orq	%rcx, %rsi
               	subq	$0x433, %rax            # imm = 0x433
               	movq	%rax, %r8
               	sarq	$0x3f, %r8
               	xorq	%r8, %rax
               	subq	%r8, %rax
               	xorl	%r9d, %r9d
               	movq	%rax, %rdi
               	andq	$0x7f, %rdi
               	movq	%rax, %rcx
               	andq	$0x3f, %rcx
               	movl	$0x3f, %eax
               	movq	%rax, %r15
               	subq	%rcx, %r15
               	movq	%rdi, %rax
               	shrq	$0x6, %rax
               	movq	%r9, %rdi
               	subq	%rax, %rdi
               	movq	%rdi, %rax
               	xorq	$-0x1, %rax
               	movq	%rsi, %r10
               	shlq	%cl, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%rsi, %r10
               	pushq	%rcx
               	movq	%r15, %rcx
               	shrq	%cl, %r10
               	popq	%rcx
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	shrq	%r10
               	movq	%r10, 0x40(%rsp)
               	movq	%r9, %r10
               	shlq	%cl, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %r10
               	orq	0x40(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x48(%rsp), %r10
               	andq	%rax, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x40(%rsp), %r10
               	andq	%rax, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x48(%rsp), %r10
               	andq	%rdi, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x40(%rsp), %r10
               	orq	0x48(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	%r9, %r10
               	shrq	%cl, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%r15, %r10
               	movq	%r9, %r15
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %r15
               	popq	%rcx
               	shlq	%r15
               	shrq	%cl, %rsi
               	movq	%rsi, %rcx
               	orq	%r15, %rcx
               	andq	%rax, %rcx
               	movq	0x48(%rsp), %rsi
               	andq	%rdi, %rsi
               	orq	%rsi, %rcx
               	movq	0x48(%rsp), %rsi
               	andq	%rax, %rsi
               	movq	%r8, %rax
               	xorq	$-0x1, %rax
               	movq	0x38(%rsp), %rdi
               	andq	%rax, %rdi
               	andq	%r8, %rcx
               	orq	%rdi, %rcx
               	movq	%rax, %r10
               	movq	0x40(%rsp), %rax
               	andq	%r10, %rax
               	andq	%r8, %rsi
               	orq	%rax, %rsi
               	movq	%r14, %rax
               	sarq	$0x3f, %rax
               	xorq	$-0x1, %rax
               	movq	%rcx, %rdi
               	andq	%rax, %rdi
               	andq	%rax, %rsi
               	cmpl	$0x80, %r14d
               	setge	%al
               	movzbq	%al, %rax
               	movq	%r9, %rcx
               	subq	%rax, %rcx
               	movq	%rdi, %rax
               	xorq	%rdx, %rax
               	xorq	%rdx, %rsi
               	cmpq	%rdx, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rax, %r8
               	subq	%rdx, %r8
               	movq	%rsi, %rax
               	subq	%rdx, %rax
               	movq	%rax, %rsi
               	subq	%rdi, %rsi
               	movq	%rdx, %rdi
               	xorq	$-0x1, %rdi
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	xorq	%r11, %rdx
               	movq	%rcx, %rax
               	xorq	$-0x1, %rax
               	andq	%rax, %r8
               	andq	%rcx, %rdi
               	orq	%r8, %rdi
               	andq	%rsi, %rax
               	andq	%rdx, %rcx
               	orq	%rcx, %rax
               	cmpq	%rbx, %rax
               	jne	<addr>
               	cmpq	%r12, %rdi
               	je	<addr>
               	leaq	0x1(%r13), %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<chk_from_fp_neg>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r14
               	movslq	%edx, %r11
               	movq	%r11, 0x48(%rsp)
               	movq	%rsi, %r15
               	leaq	<rip>, %rcx
               	movsd	%xmm0, (%rcx)
               	movsd	(%rcx), %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, %rdx
               	sarq	$0x3f, %rdx
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rcx, %rax
               	movq	%rax, %r8
               	shrq	$0x34, %r8
               	leaq	-0x3ff(%r8), %rbx
               	movabsq	$0xfffffffffffff, %rax  # imm = 0xFFFFFFFFFFFFF
               	andq	%rcx, %rax
               	movabsq	$0x10000000000000, %rsi # imm = 0x10000000000000
               	orq	%rax, %rsi
               	leaq	-0x433(%r8), %rcx
               	movq	%rcx, %r8
               	sarq	$0x3f, %r8
               	movq	%rcx, %rax
               	xorq	%r8, %rax
               	movq	%rax, %rcx
               	subq	%r8, %rcx
               	xorl	%r9d, %r9d
               	movq	%rcx, %rax
               	andq	$0x7f, %rax
               	andq	$0x3f, %rcx
               	movl	$0x3f, %edi
               	movq	%rdi, %r12
               	subq	%rcx, %r12
               	shrq	$0x6, %rax
               	movq	%r9, %rdi
               	subq	%rax, %rdi
               	movq	%rdi, %rax
               	xorq	$-0x1, %rax
               	movq	%rsi, %r13
               	shlq	%cl, %r13
               	movq	%rsi, %r10
               	pushq	%rcx
               	movq	%r12, %rcx
               	shrq	%cl, %r10
               	popq	%rcx
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	shrq	%r10
               	movq	%r10, 0x40(%rsp)
               	movq	%r9, %r10
               	shlq	%cl, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %r10
               	orq	0x40(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	%r13, %r10
               	andq	%rax, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x40(%rsp), %r10
               	andq	%rax, %r10
               	movq	%r10, 0x40(%rsp)
               	andq	%rdi, %r13
               	movq	0x40(%rsp), %r10
               	orq	%r13, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	%r9, %r13
               	shrq	%cl, %r13
               	movq	%r12, %r10
               	movq	%r9, %r12
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %r12
               	popq	%rcx
               	shlq	%r12
               	shrq	%cl, %rsi
               	movq	%rsi, %rcx
               	orq	%r12, %rcx
               	andq	%rax, %rcx
               	movq	%r13, %rsi
               	andq	%rdi, %rsi
               	orq	%rcx, %rsi
               	andq	%r13, %rax
               	movq	%r8, %rcx
               	xorq	$-0x1, %rcx
               	movq	0x38(%rsp), %rdi
               	andq	%rcx, %rdi
               	andq	%r8, %rsi
               	orq	%rdi, %rsi
               	movq	%rcx, %r10
               	movq	0x40(%rsp), %rcx
               	andq	%r10, %rcx
               	andq	%r8, %rax
               	orq	%rcx, %rax
               	movq	%rbx, %rcx
               	sarq	$0x3f, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rsi
               	andq	%rcx, %rax
               	cmpl	$0x80, %ebx
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%r9, %rcx
               	subq	%rdi, %rcx
               	movq	%rsi, %r8
               	xorq	%rdx, %r8
               	xorq	%rdx, %rax
               	cmpq	%rdx, %r8
               	setb	%sil
               	movzbq	%sil, %rsi
               	movq	%r8, %rdi
               	subq	%rdx, %rdi
               	subq	%rdx, %rax
               	subq	%rsi, %rax
               	movq	%rdx, %rsi
               	xorq	$-0x1, %rsi
               	movabsq	$0x7fffffffffffffff, %r8 # imm = 0x7FFFFFFFFFFFFFFF
               	xorq	%rdx, %r8
               	movq	%rcx, %rdx
               	xorq	$-0x1, %rdx
               	andq	%rdx, %rdi
               	andq	%rcx, %rsi
               	orq	%rdi, %rsi
               	andq	%rdx, %rax
               	andq	%r8, %rcx
               	orq	%rcx, %rax
               	cmpq	%r14, %rax
               	jne	<addr>
               	cmpq	%r15, %rsi
               	je	<addr>
               	movq	0x48(%rsp), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%edi, %edi
               	movl	$0x1, %eax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rdi, %rsi
               	movq	%rdi, %r9
               	movq	%rdi, %r8
               	movq	%rdi, %rcx
               	movq	%rdi, %rdx
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%edi, %edi
               	movl	$0x1, %esi
               	movabsq	$0x3ff0000000000000, %rdx # imm = 0x3FF0000000000000
               	movl	$0x3f800000, %ecx       # imm = 0x3F800000
               	movl	$0x5, %eax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%edi, %edi
               	movl	$0x5, %esi
               	movabsq	$0x4014000000000000, %rdx # imm = 0x4014000000000000
               	movl	$0x40a00000, %ecx       # imm = 0x40A00000
               	movl	$0x9, %eax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%edi, %edi
               	movabsq	$0x20000000000000, %rsi # imm = 0x20000000000000
               	movabsq	$0x4340000000000000, %rdx # imm = 0x4340000000000000
               	movl	$0x5a000000, %ecx       # imm = 0x5A000000
               	movl	$0xd, %eax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%edi, %edi
               	movabsq	$0x20000000000001, %rsi # imm = 0x20000000000001
               	movabsq	$0x4340000000000000, %rdx # imm = 0x4340000000000000
               	movl	$0x5a000000, %ecx       # imm = 0x5A000000
               	movl	$0x11, %eax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%edi, %edi
               	movabsq	$0x20000000000003, %rsi # imm = 0x20000000000003
               	movabsq	$0x4340000000000002, %rdx # imm = 0x4340000000000002
               	movl	$0x5a000000, %ecx       # imm = 0x5A000000
               	movl	$0x15, %eax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%edi, %edi
               	movq	$-0x1, %rsi
               	movabsq	$0x43f0000000000000, %rdx # imm = 0x43F0000000000000
               	movl	$0x5f800000, %ecx       # imm = 0x5F800000
               	movl	$0x19, %eax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%edi, %edi
               	movabsq	$-0x8000000000000000, %rsi # imm = 0x8000000000000000
               	movabsq	$0x43e0000000000000, %rdx # imm = 0x43E0000000000000
               	movl	$0x5f000000, %ecx       # imm = 0x5F000000
               	movl	$0x1d, %eax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x1, %edi
               	xorl	%esi, %esi
               	movabsq	$0x43f0000000000000, %rdx # imm = 0x43F0000000000000
               	movl	$0x5f800000, %ecx       # imm = 0x5F800000
               	movl	$0x21, %eax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x5, %edi
               	xorl	%esi, %esi
               	movabsq	$0x4414000000000000, %rdx # imm = 0x4414000000000000
               	movl	$0x60a00000, %ecx       # imm = 0x60A00000
               	movl	$0x25, %eax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movabsq	$0x1000000000000, %rdi  # imm = 0x1000000000000
               	movl	$0x1, %esi
               	movabsq	$0x46f0000000000000, %rdx # imm = 0x46F0000000000000
               	movl	$0x77800000, %ecx       # imm = 0x77800000
               	movl	$0x29, %eax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movabsq	$0x1000000000001, %rdi  # imm = 0x1000000000001
               	movl	$0x1, %esi
               	movabsq	$0x46f0000000000010, %rdx # imm = 0x46F0000000000010
               	movl	$0x77800000, %ecx       # imm = 0x77800000
               	movl	$0x2d, %eax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	$-0x1, %rdi
               	movabsq	$0x47f0000000000000, %rdx # imm = 0x47F0000000000000
               	movl	$0x7f800000, %ecx       # imm = 0x7F800000
               	movabsq	$-0x4010000000000000, %r8 # imm = 0xBFF0000000000000
               	movl	$0xbf800000, %r9d       # imm = 0xBF800000
               	movl	$0x31, %eax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rdi, %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movabsq	$-0x8000000000000000, %rdi # imm = 0x8000000000000000
               	xorl	%esi, %esi
               	movabsq	$0x47e0000000000000, %rdx # imm = 0x47E0000000000000
               	movl	$0x7f000000, %ecx       # imm = 0x7F000000
               	movabsq	$-0x3820000000000000, %r8 # imm = 0xC7E0000000000000
               	movl	$0xff000000, %r9d       # imm = 0xFF000000
               	movl	$0x35, %eax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movabsq	$0x7fffffffffffffff, %rdi # imm = 0x7FFFFFFFFFFFFFFF
               	movq	$-0x1, %rsi
               	movabsq	$0x47e0000000000000, %rdx # imm = 0x47E0000000000000
               	movl	$0x7f000000, %ecx       # imm = 0x7F000000
               	movl	$0x39, %eax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movabsq	$0x11223344556677, %rdi # imm = 0x11223344556677
               	movabsq	$-0x7766554433221101, %rsi # imm = 0x8899AABBCCDDEEFF
               	movabsq	$0x4731223344556678, %rdx # imm = 0x4731223344556678
               	movl	$0x7989119a, %ecx       # imm = 0x7989119A
               	movl	$0x3d, %eax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%edi, %edi
               	movl	$0x41, %edx
               	movq	%rdi, %xmm0
               	movq	%rdi, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movabsq	$0x400ffdf3b645a1cb, %rax # imm = 0x400FFDF3B645A1CB
               	xorl	%edi, %edi
               	movl	$0x3, %esi
               	movl	$0x43, %edx
               	movq	%rax, %xmm0
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	xorl	%edi, %edi
               	movl	$0x45, %edx
               	movq	%rax, %xmm0
               	movq	%rdi, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movabsq	$-0x4020000000000000, %rax # imm = 0xBFE0000000000000
               	xorl	%edi, %edi
               	movl	$0x47, %edx
               	movq	%rax, %xmm0
               	movq	%rdi, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movabsq	$-0x3ff0020c49ba5e35, %rax # imm = 0xC00FFDF3B645A1CB
               	movq	$-0x1, %rdi
               	movq	$-0x3, %rsi
               	movl	$0x49, %edx
               	movq	%rax, %xmm0
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movabsq	$0x43ea055690d9db80, %rax # imm = 0x43EA055690D9DB80
               	xorl	%edi, %edi
               	movabsq	$-0x2fd54b7931240000, %rsi # imm = 0xD02AB486CEDC0000
               	movl	$0x4b, %edx
               	movq	%rax, %xmm0
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movabsq	$0x43f0000000000000, %rax # imm = 0x43F0000000000000
               	movl	$0x1, %edi
               	xorl	%esi, %esi
               	movl	$0x4d, %edx
               	movq	%rax, %xmm0
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movabsq	$0x45c0000000000000, %rax # imm = 0x45C0000000000000
               	movl	$0x20000000, %edi       # imm = 0x20000000
               	xorl	%esi, %esi
               	movl	$0x4f, %edx
               	movq	%rax, %xmm0
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movabsq	$-0x3820000000000000, %rax # imm = 0xC7E0000000000000
               	movabsq	$-0x8000000000000000, %rdi # imm = 0x8000000000000000
               	xorl	%esi, %esi
               	movl	$0x51, %edx
               	movq	%rax, %xmm0
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rax
               	movl	$0x40200000, (%rax)     # imm = 0x40200000
               	movss	(%rax), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %rbx
               	sarq	$0x3f, %rbx
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rax, %rcx
               	shrq	$0x34, %rcx
               	leaq	-0x3ff(%rcx), %rsi
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$0x10000000000000, %rdi # imm = 0x10000000000000
               	orq	%rax, %rdi
               	subq	$0x433, %rcx            # imm = 0x433
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	xorq	%rax, %rcx
               	subq	%rax, %rcx
               	xorl	%edx, %edx
               	movq	%rcx, %r8
               	andq	$0x7f, %r8
               	andq	$0x3f, %rcx
               	movl	$0x3f, %r9d
               	movq	%r9, %r12
               	subq	%rcx, %r12
               	movq	%r8, %r9
               	shrq	$0x6, %r9
               	movq	%rdx, %r8
               	subq	%r9, %r8
               	movq	%r8, %r9
               	xorq	$-0x1, %r9
               	movq	%rdi, %r13
               	shlq	%cl, %r13
               	andq	%r9, %r13
               	movq	%rdx, %r14
               	shrq	%cl, %r14
               	movq	%r12, %r10
               	movq	%rdx, %r12
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %r12
               	popq	%rcx
               	shlq	%r12
               	shrq	%cl, %rdi
               	movq	%rdi, %rcx
               	orq	%r12, %rcx
               	andq	%r9, %rcx
               	movq	%r14, %rdi
               	andq	%r8, %rdi
               	orq	%rdi, %rcx
               	movq	%rax, %rdi
               	xorq	$-0x1, %rdi
               	andq	%r13, %rdi
               	andq	%rcx, %rax
               	orq	%rdi, %rax
               	movq	%rsi, %rcx
               	sarq	$0x3f, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rax, %rcx
               	cmpl	$0x80, %esi
               	setge	%sil
               	movzbq	%sil, %rsi
               	movq	%rdx, %rax
               	subq	%rsi, %rax
               	movq	%rax, %rdx
               	xorq	$-0x1, %rdx
               	andq	%rdx, %rcx
               	orq	%rcx, %rax
               	movq	%rbx, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rax
               	cmpq	$0x2, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movss	(%rax), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %rbx
               	sarq	$0x3f, %rbx
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rax, %rcx
               	shrq	$0x34, %rcx
               	leaq	-0x3ff(%rcx), %rsi
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$0x10000000000000, %rdi # imm = 0x10000000000000
               	orq	%rax, %rdi
               	subq	$0x433, %rcx            # imm = 0x433
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	xorq	%rax, %rcx
               	subq	%rax, %rcx
               	xorl	%edx, %edx
               	movq	%rcx, %r8
               	andq	$0x7f, %r8
               	andq	$0x3f, %rcx
               	movl	$0x3f, %r9d
               	movq	%r9, %r12
               	subq	%rcx, %r12
               	movq	%r8, %r9
               	shrq	$0x6, %r9
               	movq	%rdx, %r8
               	subq	%r9, %r8
               	movq	%r8, %r9
               	xorq	$-0x1, %r9
               	movq	%rdi, %r13
               	shlq	%cl, %r13
               	pushq	%rcx
               	movq	%r12, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	shrq	%rdi
               	movq	%rdx, %r12
               	shlq	%cl, %r12
               	orq	%r12, %rdi
               	andq	%r9, %rdi
               	andq	%r13, %r8
               	orq	%r8, %rdi
               	movq	%rdx, %r8
               	shrq	%cl, %r8
               	movq	%r8, %rcx
               	andq	%r9, %rcx
               	movq	%rax, %r8
               	xorq	$-0x1, %r8
               	andq	%r8, %rdi
               	andq	%rcx, %rax
               	orq	%rdi, %rax
               	movq	%rsi, %rcx
               	sarq	$0x3f, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rax, %rcx
               	cmpl	$0x80, %esi
               	setge	%sil
               	movzbq	%sil, %rsi
               	movq	%rdx, %rax
               	subq	%rsi, %rax
               	movq	%rax, %rdx
               	xorq	$-0x1, %rdx
               	andq	%rdx, %rcx
               	orq	%rcx, %rax
               	movq	%rbx, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x53, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rax
               	movl	$0xc0600000, (%rax)     # imm = 0xC0600000
               	movss	(%rax), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %rsi
               	sarq	$0x3f, %rsi
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rax, %rcx
               	shrq	$0x34, %rcx
               	leaq	-0x3ff(%rcx), %rdi
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$0x10000000000000, %r8  # imm = 0x10000000000000
               	orq	%rax, %r8
               	subq	$0x433, %rcx            # imm = 0x433
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	xorq	%rax, %rcx
               	subq	%rax, %rcx
               	xorl	%edx, %edx
               	movq	%rcx, %r9
               	andq	$0x7f, %r9
               	andq	$0x3f, %rcx
               	movl	$0x3f, %ebx
               	movq	%rbx, %r12
               	subq	%rcx, %r12
               	shrq	$0x6, %r9
               	negq	%r9
               	addq	%rdx, %r9
               	movq	%r9, %rbx
               	xorq	$-0x1, %rbx
               	movq	%r8, %r13
               	shlq	%cl, %r13
               	andq	%rbx, %r13
               	movq	%rdx, %r14
               	shrq	%cl, %r14
               	movq	%r12, %r10
               	movq	%rdx, %r12
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %r12
               	popq	%rcx
               	shlq	%r12
               	shrq	%cl, %r8
               	movq	%r8, %rcx
               	orq	%r12, %rcx
               	andq	%rbx, %rcx
               	movq	%r14, %r8
               	andq	%r9, %r8
               	orq	%r8, %rcx
               	movq	%rax, %r8
               	xorq	$-0x1, %r8
               	andq	%r13, %r8
               	andq	%rcx, %rax
               	orq	%r8, %rax
               	movq	%rdi, %rcx
               	sarq	$0x3f, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rax, %rcx
               	cmpl	$0x80, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rdx, %rax
               	subq	%rdi, %rax
               	xorq	%rsi, %rcx
               	subq	%rsi, %rcx
               	movq	%rsi, %rdx
               	xorq	$-0x1, %rdx
               	movq	%rax, %rsi
               	xorq	$-0x1, %rsi
               	andq	%rsi, %rcx
               	andq	%rdx, %rax
               	orq	%rcx, %rax
               	cmpq	$-0x3, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movss	(%rax), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rcx, %rdx
               	shrq	$0x34, %rdx
               	leaq	-0x3ff(%rdx), %rbx
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$0x10000000000000, %r8  # imm = 0x10000000000000
               	orq	%rcx, %r8
               	leaq	-0x433(%rdx), %rcx
               	movq	%rcx, %rdx
               	sarq	$0x3f, %rdx
               	xorq	%rdx, %rcx
               	subq	%rdx, %rcx
               	xorl	%esi, %esi
               	movq	%rcx, %rdi
               	andq	$0x7f, %rdi
               	andq	$0x3f, %rcx
               	movl	$0x3f, %r9d
               	movq	%r9, %r12
               	subq	%rcx, %r12
               	shrq	$0x6, %rdi
               	movq	%rsi, %r9
               	subq	%rdi, %r9
               	movq	%r9, %rdi
               	xorq	$-0x1, %rdi
               	movq	%r8, %r13
               	shlq	%cl, %r13
               	movq	%r8, %r14
               	pushq	%rcx
               	movq	%r12, %rcx
               	shrq	%cl, %r14
               	popq	%rcx
               	shrq	%r14
               	movq	%rsi, %r15
               	shlq	%cl, %r15
               	orq	%r15, %r14
               	movq	%r13, %r15
               	andq	%rdi, %r15
               	andq	%rdi, %r14
               	andq	%r9, %r13
               	orq	%r13, %r14
               	movq	%rsi, %r13
               	shrq	%cl, %r13
               	movq	%r12, %r10
               	movq	%rsi, %r12
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %r12
               	popq	%rcx
               	shlq	%r12
               	shrq	%cl, %r8
               	movq	%r8, %rcx
               	orq	%r12, %rcx
               	andq	%rdi, %rcx
               	movq	%r13, %r8
               	andq	%r9, %r8
               	orq	%rcx, %r8
               	andq	%r13, %rdi
               	movq	%rdx, %rcx
               	xorq	$-0x1, %rcx
               	movq	%r15, %r9
               	andq	%rcx, %r9
               	andq	%rdx, %r8
               	orq	%r9, %r8
               	andq	%r14, %rcx
               	andq	%rdi, %rdx
               	orq	%rcx, %rdx
               	movq	%rbx, %rcx
               	sarq	$0x3f, %rcx
               	xorq	$-0x1, %rcx
               	movq	%r8, %rdi
               	andq	%rcx, %rdi
               	andq	%rcx, %rdx
               	cmpl	$0x80, %ebx
               	setge	%r8b
               	movzbq	%r8b, %r8
               	movq	%rsi, %rcx
               	subq	%r8, %rcx
               	movq	%rdi, %rsi
               	xorq	%rax, %rsi
               	xorq	%rax, %rdx
               	cmpq	%rax, %rsi
               	setb	%sil
               	movzbq	%sil, %rsi
               	subq	%rax, %rdx
               	subq	%rsi, %rdx
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	xorq	%r11, %rax
               	movq	%rcx, %rsi
               	xorq	$-0x1, %rsi
               	andq	%rsi, %rdx
               	andq	%rcx, %rax
               	orq	%rdx, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x54, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rsi
               	movabsq	$0x10000000000000, %rdx # imm = 0x10000000000000
               	movq	%rdx, (%rsi)
               	movq	(%rcx), %rdx
               	movq	(%rsi), %rdi
               	testq	%rdx, %rdx
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%rdx, %rcx
               	shrq	$0x20, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x5, %rcx
               	leaq	0x1(%rcx), %r9
               	movq	%rdx, %rsi
               	shrq	%cl, %rsi
               	movq	%rsi, %rcx
               	shrq	$0x10, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %r9
               	shrq	%cl, %rsi
               	movq	%rsi, %rcx
               	shrq	$0x8, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %r9
               	shrq	%cl, %rsi
               	movq	%rsi, %rcx
               	shrq	$0x4, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %r9
               	shrq	%cl, %rsi
               	movq	%rsi, %rcx
               	shrq	$0x2, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
               	addq	%rcx, %r9
               	shrq	%cl, %rsi
               	movq	%rsi, %rcx
               	shrq	%rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	leaq	(%r9,%rcx), %rsi
               	imulq	%r8, %rsi
               	movl	$0x40, %ecx
               	subq	%rsi, %rcx
               	andq	$0x3f, %rcx
               	movq	$-0x1, %r8
               	movq	%r8, %r9
               	shrq	%cl, %r9
               	testq	%rsi, %rsi
               	setne	%cl
               	movzbq	%cl, %rcx
               	imulq	%r9, %rcx
               	andq	%rdi, %rcx
               	testq	%rcx, %rcx
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%rsi, %rbx
               	andq	$0x7f, %rbx
               	movq	%rsi, %rcx
               	andq	$0x3f, %rcx
               	movl	$0x3f, %r9d
               	movq	%r9, %r13
               	subq	%rcx, %r13
               	shrq	$0x6, %rbx
               	negq	%rbx
               	addq	%rax, %rbx
               	movq	%rbx, %r14
               	xorq	$-0x1, %r14
               	movq	%rdx, %r15
               	shrq	%cl, %r15
               	pushq	%rcx
               	movq	%r13, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	shlq	%rdx
               	shrq	%cl, %rdi
               	movq	%rdi, %rcx
               	orq	%rdx, %rcx
               	andq	%r14, %rcx
               	movq	%r15, %rdx
               	andq	%rbx, %rdx
               	orq	%rdx, %rcx
               	orq	%r12, %rcx
               	xorps	%xmm0, %xmm0
               	movq	%rcx, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm0
               	addsd	%xmm0, %xmm0
               	leaq	0x3ff(%rsi), %rcx
               	shlq	$0x34, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movsd	-0x8(%rbp), %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, %r12
               	sarq	$0x3f, %r12
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rcx, %rdx
               	shrq	$0x34, %rdx
               	leaq	-0x3ff(%rdx), %rsi
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$0x10000000000000, %rdi # imm = 0x10000000000000
               	orq	%rcx, %rdi
               	leaq	-0x433(%rdx), %rcx
               	movq	%rcx, %rdx
               	sarq	$0x3f, %rdx
               	xorq	%rdx, %rcx
               	subq	%rdx, %rcx
               	movq	%rcx, %rbx
               	andq	$0x7f, %rbx
               	andq	$0x3f, %rcx
               	movq	%r9, %r13
               	subq	%rcx, %r13
               	movq	%rbx, %r9
               	shrq	$0x6, %r9
               	negq	%r9
               	addq	%rax, %r9
               	movq	%r9, %rbx
               	xorq	$-0x1, %rbx
               	movq	%rdi, %r14
               	shlq	%cl, %r14
               	andq	%rbx, %r14
               	movq	%rax, %r15
               	shrq	%cl, %r15
               	movq	%r13, %r10
               	movq	%rax, %r13
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %r13
               	popq	%rcx
               	shlq	%r13
               	shrq	%cl, %rdi
               	movq	%rdi, %rcx
               	orq	%r13, %rcx
               	andq	%rbx, %rcx
               	movq	%r15, %rdi
               	andq	%r9, %rdi
               	orq	%rdi, %rcx
               	movq	%rdx, %rdi
               	xorq	$-0x1, %rdi
               	andq	%r14, %rdi
               	andq	%rdx, %rcx
               	orq	%rdi, %rcx
               	movq	%rsi, %rdx
               	sarq	$0x3f, %rdx
               	xorq	$-0x1, %rdx
               	andq	%rdx, %rcx
               	cmpl	$0x80, %esi
               	setge	%dl
               	movzbq	%dl, %rdx
               	subq	%rdx, %rax
               	movq	%rax, %rdx
               	xorq	$-0x1, %rdx
               	andq	%rdx, %rcx
               	andq	%r8, %rax
               	orq	%rcx, %rax
               	movq	%r12, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rax
               	movabsq	$0x10000000000000, %r11 # imm = 0x10000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x55, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movq	$0x5, (%rcx)
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	movq	%rax, (%rsi)
               	movq	(%rcx), %rdx
               	movq	(%rsi), %rdi
               	testq	%rdx, %rdx
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%rdx, %rcx
               	shrq	$0x20, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x5, %rcx
               	leaq	0x1(%rcx), %r9
               	movq	%rdx, %rsi
               	shrq	%cl, %rsi
               	movq	%rsi, %rcx
               	shrq	$0x10, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %r9
               	shrq	%cl, %rsi
               	movq	%rsi, %rcx
               	shrq	$0x8, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %r9
               	shrq	%cl, %rsi
               	movq	%rsi, %rcx
               	shrq	$0x4, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %r9
               	shrq	%cl, %rsi
               	movq	%rsi, %rcx
               	shrq	$0x2, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
               	addq	%rcx, %r9
               	shrq	%cl, %rsi
               	movq	%rsi, %rcx
               	shrq	%rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	leaq	(%r9,%rcx), %rsi
               	imulq	%r8, %rsi
               	movl	$0x40, %ecx
               	subq	%rsi, %rcx
               	andq	$0x3f, %rcx
               	movq	$-0x1, %r8
               	movq	%r8, %r9
               	shrq	%cl, %r9
               	testq	%rsi, %rsi
               	setne	%cl
               	movzbq	%cl, %rcx
               	imulq	%r9, %rcx
               	andq	%rdi, %rcx
               	testq	%rcx, %rcx
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%rsi, %rbx
               	andq	$0x7f, %rbx
               	movq	%rsi, %rcx
               	andq	$0x3f, %rcx
               	movl	$0x3f, %r9d
               	movq	%r9, %r13
               	subq	%rcx, %r13
               	shrq	$0x6, %rbx
               	negq	%rbx
               	addq	%rax, %rbx
               	movq	%rbx, %r14
               	xorq	$-0x1, %r14
               	movq	%rdx, %r15
               	shrq	%cl, %r15
               	pushq	%rcx
               	movq	%r13, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	shlq	%rdx
               	shrq	%cl, %rdi
               	movq	%rdi, %rcx
               	orq	%rdx, %rcx
               	andq	%r14, %rcx
               	movq	%r15, %rdx
               	andq	%rbx, %rdx
               	orq	%rdx, %rcx
               	orq	%r12, %rcx
               	xorps	%xmm0, %xmm0
               	movq	%rcx, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm0
               	addsd	%xmm0, %xmm0
               	leaq	0x3ff(%rsi), %rcx
               	shlq	$0x34, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movsd	-0x8(%rbp), %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, %r12
               	sarq	$0x3f, %r12
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rcx, %rdx
               	shrq	$0x34, %rdx
               	leaq	-0x3ff(%rdx), %rsi
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$0x10000000000000, %rdi # imm = 0x10000000000000
               	orq	%rcx, %rdi
               	leaq	-0x433(%rdx), %rcx
               	movq	%rcx, %rdx
               	sarq	$0x3f, %rdx
               	xorq	%rdx, %rcx
               	subq	%rdx, %rcx
               	movq	%rcx, %rbx
               	andq	$0x7f, %rbx
               	andq	$0x3f, %rcx
               	movq	%r9, %r13
               	subq	%rcx, %r13
               	movq	%rbx, %r9
               	shrq	$0x6, %r9
               	negq	%r9
               	addq	%rax, %r9
               	movq	%r9, %rbx
               	xorq	$-0x1, %rbx
               	movq	%rdi, %r14
               	shlq	%cl, %r14
               	pushq	%rcx
               	movq	%r13, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	shrq	%rdi
               	movq	%rax, %r13
               	shlq	%cl, %r13
               	orq	%r13, %rdi
               	andq	%rbx, %rdi
               	andq	%r14, %r9
               	orq	%r9, %rdi
               	movq	%rax, %r9
               	shrq	%cl, %r9
               	movq	%r9, %rcx
               	andq	%rbx, %rcx
               	movq	%rdx, %r9
               	xorq	$-0x1, %r9
               	andq	%r9, %rdi
               	andq	%rdx, %rcx
               	orq	%rdi, %rcx
               	movq	%rsi, %rdx
               	sarq	$0x3f, %rdx
               	xorq	$-0x1, %rdx
               	andq	%rdx, %rcx
               	cmpl	$0x80, %esi
               	setge	%dl
               	movzbq	%dl, %rdx
               	subq	%rdx, %rax
               	movq	%rax, %rdx
               	xorq	$-0x1, %rdx
               	andq	%r8, %rax
               	andq	%rdx, %rcx
               	orq	%rcx, %rax
               	movq	%r12, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x56, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rax
               	xorl	%esi, %esi
               	movq	%rsi, (%rax)
               	leaq	<rip>, %rcx
               	movq	$0x3, (%rcx)
               	leaq	<rip>, %rdx
               	movabsq	$0x3ff8000000000000, %rdi # imm = 0x3FF8000000000000
               	movq	%rdi, %xmm14
               	movsd	%xmm14, (%rdx)
               	movq	(%rax), %rax
               	movq	(%rcx), %rdi
               	testq	%rax, %rax
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x5, %rcx
               	leaq	0x1(%rcx), %r9
               	movq	%rax, %rdx
               	shrq	%cl, %rdx
               	movq	%rdx, %rcx
               	shrq	$0x10, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %r9
               	shrq	%cl, %rdx
               	movq	%rdx, %rcx
               	shrq	$0x8, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %r9
               	shrq	%cl, %rdx
               	movq	%rdx, %rcx
               	shrq	$0x4, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %r9
               	shrq	%cl, %rdx
               	movq	%rdx, %rcx
               	shrq	$0x2, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
               	addq	%rcx, %r9
               	shrq	%cl, %rdx
               	movq	%rdx, %rcx
               	shrq	%rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	leaq	(%r9,%rcx), %rdx
               	imulq	%r8, %rdx
               	movl	$0x40, %ecx
               	subq	%rdx, %rcx
               	andq	$0x3f, %rcx
               	movq	$-0x1, %r8
               	shrq	%cl, %r8
               	testq	%rdx, %rdx
               	setne	%cl
               	movzbq	%cl, %rcx
               	imulq	%r8, %rcx
               	andq	%rdi, %rcx
               	testq	%rcx, %rcx
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%rdx, %r9
               	andq	$0x7f, %r9
               	movq	%rdx, %rcx
               	andq	$0x3f, %rcx
               	movl	$0x3f, %ebx
               	subq	%rcx, %rbx
               	shrq	$0x6, %r9
               	subq	%r9, %rsi
               	movq	%rsi, %r9
               	xorq	$-0x1, %r9
               	movq	%rax, %r12
               	shrq	%cl, %r12
               	pushq	%rcx
               	movq	%rbx, %rcx
               	shlq	%cl, %rax
               	popq	%rcx
               	shlq	%rax
               	shrq	%cl, %rdi
               	orq	%rdi, %rax
               	andq	%r9, %rax
               	movq	%r12, %rcx
               	andq	%rsi, %rcx
               	orq	%rcx, %rax
               	orq	%r8, %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm0
               	addsd	%xmm0, %xmm0
               	leaq	0x3ff(%rdx), %rax
               	shlq	$0x34, %rax
               	movq	%rax, -0x8(%rbp)
               	movsd	-0x8(%rbp), %xmm1
               	leaq	<rip>, %rax
               	movsd	(%rax), %xmm2
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x4012000000000000, %r11 # imm = 0x4012000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x57, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	xorq	%rax, %rdx
               	xorq	%rax, %rcx
               	cmpq	%rax, %rdx
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rdx, %rsi
               	subq	%rax, %rsi
               	subq	%rax, %rcx
               	movq	%rcx, %rdx
               	subq	%rdi, %rdx
               	movabsq	$-0x8000000000000000, %r8 # imm = 0x8000000000000000
               	andq	%rax, %r8
               	testq	%rdx, %rdx
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdx, %rax
               	shrq	$0x20, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, %rcx
               	shlq	$0x5, %rcx
               	leaq	0x1(%rcx), %r9
               	movq	%rdx, %rax
               	shrq	%cl, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %r9
               	shrq	%cl, %rax
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %r9
               	shrq	%cl, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %r9
               	shrq	%cl, %rax
               	movq	%rax, %rcx
               	shrq	$0x2, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
               	addq	%rcx, %r9
               	shrq	%cl, %rax
               	shrq	%rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	leaq	(%r9,%rcx), %rax
               	imulq	%rdi, %rax
               	movl	$0x40, %ecx
               	subq	%rax, %rcx
               	andq	$0x3f, %rcx
               	movq	$-0x1, %rdi
               	shrq	%cl, %rdi
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	imulq	%rdi, %rcx
               	andq	%rsi, %rcx
               	testq	%rcx, %rcx
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%rax, %rdi
               	andq	$0x7f, %rdi
               	movq	%rax, %rcx
               	andq	$0x3f, %rcx
               	movl	$0x3f, %ebx
               	subq	%rcx, %rbx
               	shrq	$0x6, %rdi
               	xorl	%r12d, %r12d
               	negq	%rdi
               	addq	%r12, %rdi
               	movq	%rdi, %r12
               	xorq	$-0x1, %r12
               	movq	%rdx, %r13
               	shrq	%cl, %r13
               	pushq	%rcx
               	movq	%rbx, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	shlq	%rdx
               	shrq	%cl, %rsi
               	movq	%rsi, %rcx
               	orq	%rdx, %rcx
               	andq	%r12, %rcx
               	movq	%r13, %rdx
               	andq	%rdi, %rdx
               	orq	%rdx, %rcx
               	orq	%r9, %rcx
               	xorps	%xmm0, %xmm0
               	movq	%rcx, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm0
               	addsd	%xmm0, %xmm0
               	addq	$0x3ff, %rax            # imm = 0x3FF
               	shlq	$0x34, %rax
               	orq	%r8, %rax
               	movq	%rax, -0x18(%rbp)
               	movsd	-0x18(%rbp), %xmm1
               	mulsd	%xmm1, %xmm0
               	leaq	<rip>, %rax
               	movsd	(%rax), %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x4012000000000000, %r11 # imm = 0x4012000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x58, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
