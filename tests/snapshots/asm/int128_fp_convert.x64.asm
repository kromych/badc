
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
               	subq	$0x48, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdx, 0x48(%rsp)
               	movq	%r8, 0x40(%rsp)
               	movq	%rcx, %rbx
               	leaq	<rip>, %rcx
               	movq	%rdi, (%rcx)
               	leaq	<rip>, %rdx
               	movq	%rsi, (%rdx)
               	movq	(%rcx), %rdi
               	movq	(%rdx), %r8
               	leaq	-0x10(%rbp), %rax
               	movq	%rdi, (%rax)
               	xorl	%esi, %esi
               	movq	%rsi, 0x8(%rax)
               	orq	%rsi, %r8
               	movq	%rdi, %rax
               	orq	%rsi, %rax
               	xorl	%r12d, %r12d
               	testq	%rax, %rax
               	setne	%r13b
               	movzbq	%r13b, %r13
               	movq	%rax, %rsi
               	shrq	$0x20, %rsi
               	testl	%esi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	$0x5, %rsi
               	leaq	0x1(%rsi), %r14
               	movq	%rax, %rdi
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	movq	%rdi, %rsi
               	shrq	$0x10, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %r14
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	movq	%rdi, %rsi
               	shrq	$0x8, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %r14
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	movq	%rdi, %rsi
               	shrq	$0x4, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %r14
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	movq	%rdi, %rsi
               	shrq	$0x2, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	%rsi
               	addq	%rsi, %r14
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	movq	%rdi, %rsi
               	shrq	%rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	addq	%rsi, %r14
               	movq	%r14, %rsi
               	imulq	%r13, %rsi
               	movl	$0x40, %edi
               	subq	%rsi, %rdi
               	andq	$0x3f, %rdi
               	movq	$-0x1, %r13
               	movq	%rdi, %r10
               	movq	%r13, %rdi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	testq	%rsi, %rsi
               	setne	%r13b
               	movzbq	%r13b, %r13
               	imulq	%r13, %rdi
               	andq	%r8, %rdi
               	testq	%rdi, %rdi
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%rsi, %r13
               	andq	$0x7f, %r13
               	movq	%rsi, %rdi
               	andq	$0x3f, %rdi
               	movl	$0x3f, %r14d
               	movq	%r14, %r10
               	subq	%rdi, %r10
               	movq	%r10, 0x30(%rsp)
               	shrq	$0x6, %r13
               	negq	%r13
               	addq	%r12, %r13
               	movq	%r13, %r14
               	xorq	$-0x1, %r14
               	movq	%rax, %r15
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %r15
               	popq	%rcx
               	movq	0x30(%rsp), %r10
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rax
               	popq	%rcx
               	shlq	%rax
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %r8
               	popq	%rcx
               	orq	%r8, %rax
               	andq	%r14, %rax
               	movq	%r15, %rdi
               	andq	%r13, %rdi
               	orq	%rdi, %rax
               	orq	0x38(%rsp), %rax
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
               	orq	%r12, %rax
               	movq	%rax, -0x18(%rbp)
               	movsd	-0x18(%rbp,%riz), %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rbp,%riz)
               	movq	-0x8(%rbp), %rax
               	cmpq	0x48(%rsp), %rax
               	je	<addr>
               	movslq	0x10(%rbp), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	(%rcx), %rdi
               	movq	(%rdx), %r8
               	leaq	-0x10(%rbp), %rax
               	movq	%rdi, (%rax)
               	xorl	%esi, %esi
               	movq	%rsi, 0x8(%rax)
               	orq	%rsi, %r8
               	movq	%rdi, %rax
               	orq	%rsi, %rax
               	xorl	%r12d, %r12d
               	testq	%rax, %rax
               	setne	%r13b
               	movzbq	%r13b, %r13
               	movq	%rax, %rsi
               	shrq	$0x20, %rsi
               	testl	%esi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	$0x5, %rsi
               	leaq	0x1(%rsi), %r14
               	movq	%rax, %rdi
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	movq	%rdi, %rsi
               	shrq	$0x10, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %r14
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	movq	%rdi, %rsi
               	shrq	$0x8, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %r14
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	movq	%rdi, %rsi
               	shrq	$0x4, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %r14
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	movq	%rdi, %rsi
               	shrq	$0x2, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	%rsi
               	addq	%rsi, %r14
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	movq	%rdi, %rsi
               	shrq	%rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	addq	%rsi, %r14
               	movq	%r14, %rsi
               	imulq	%r13, %rsi
               	movl	$0x40, %edi
               	subq	%rsi, %rdi
               	andq	$0x3f, %rdi
               	movq	$-0x1, %r13
               	movq	%rdi, %r10
               	movq	%r13, %rdi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	testq	%rsi, %rsi
               	setne	%r13b
               	movzbq	%r13b, %r13
               	imulq	%r13, %rdi
               	andq	%r8, %rdi
               	testq	%rdi, %rdi
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%rsi, %r13
               	andq	$0x7f, %r13
               	movq	%rsi, %rdi
               	andq	$0x3f, %rdi
               	movl	$0x3f, %r14d
               	movq	%r14, %r10
               	subq	%rdi, %r10
               	movq	%r10, 0x38(%rsp)
               	shrq	$0x6, %r13
               	negq	%r13
               	addq	%r12, %r13
               	movq	%r13, %r14
               	xorq	$-0x1, %r14
               	movq	%rax, %r15
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %r15
               	popq	%rcx
               	movq	0x38(%rsp), %r10
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rax
               	popq	%rcx
               	shlq	%rax
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %r8
               	popq	%rcx
               	orq	%r8, %rax
               	andq	%r14, %rax
               	movq	%r15, %rdi
               	andq	%r13, %rdi
               	orq	%rdi, %rax
               	orq	0x48(%rsp), %rax
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
               	leaq	0x3ff(%rsi), %rax
               	shlq	$0x34, %rax
               	orq	%r12, %rax
               	movq	%rax, -0x18(%rbp)
               	movsd	-0x18(%rbp,%riz), %xmm1
               	mulsd	%xmm1, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	leaq	-0x10(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
               	movl	(%rax), %esi
               	cmpl	%ebx, %esi
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
               	movq	(%rcx), %rdi
               	movq	(%rdx), %r8
               	movq	%rdi, (%rax)
               	xorl	%esi, %esi
               	movq	%rsi, 0x8(%rax)
               	orq	%rsi, %r8
               	orq	%rdi, %rsi
               	movq	%rsi, %rax
               	sarq	$0x3f, %rax
               	movq	%r8, %rdi
               	xorq	%rax, %rdi
               	xorq	%rax, %rsi
               	cmpq	%rax, %rdi
               	setb	%bl
               	movzbq	%bl, %rbx
               	movq	%rdi, %r8
               	subq	%rax, %r8
               	subq	%rax, %rsi
               	subq	%rbx, %rsi
               	movabsq	$-0x8000000000000000, %r14 # imm = 0x8000000000000000
               	andq	%rax, %r14
               	testq	%rsi, %rsi
               	setne	%bl
               	movzbq	%bl, %rbx
               	movq	%rsi, %rax
               	shrq	$0x20, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x5, %rax
               	leaq	0x1(%rax), %r12
               	movq	%rsi, %rdi
               	pushq	%rcx
               	movq	%rax, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	movq	%rdi, %rax
               	shrq	$0x10, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	addq	%rax, %r12
               	pushq	%rcx
               	movq	%rax, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	movq	%rdi, %rax
               	shrq	$0x8, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %r12
               	pushq	%rcx
               	movq	%rax, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	movq	%rdi, %rax
               	shrq	$0x4, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x2, %rax
               	addq	%rax, %r12
               	pushq	%rcx
               	movq	%rax, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	movq	%rdi, %rax
               	shrq	$0x2, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	addq	%rax, %r12
               	pushq	%rcx
               	movq	%rax, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	movq	%rdi, %rax
               	shrq	%rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	addq	%rax, %r12
               	movq	%r12, %rax
               	imulq	%rbx, %rax
               	movl	$0x40, %edi
               	subq	%rax, %rdi
               	andq	$0x3f, %rdi
               	movq	$-0x1, %rbx
               	movq	%rdi, %r10
               	movq	%rbx, %rdi
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	imulq	%rbx, %rdi
               	andq	%r8, %rdi
               	testq	%rdi, %rdi
               	setne	%r15b
               	movzbq	%r15b, %r15
               	movq	%rax, %rbx
               	andq	$0x7f, %rbx
               	movq	%rax, %rdi
               	andq	$0x3f, %rdi
               	movl	$0x3f, %r12d
               	movq	%r12, %r10
               	subq	%rdi, %r10
               	movq	%r10, 0x48(%rsp)
               	shrq	$0x6, %rbx
               	xorl	%r12d, %r12d
               	negq	%rbx
               	addq	%r12, %rbx
               	movq	%rbx, %r12
               	xorq	$-0x1, %r12
               	movq	%rsi, %r13
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %r13
               	popq	%rcx
               	movq	0x48(%rsp), %r10
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rsi
               	popq	%rcx
               	shlq	%rsi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shrq	%cl, %r8
               	popq	%rcx
               	orq	%r8, %rsi
               	andq	%r12, %rsi
               	movq	%r13, %rdi
               	andq	%rbx, %rdi
               	orq	%rdi, %rsi
               	orq	%r15, %rsi
               	xorps	%xmm0, %xmm0
               	movq	%rsi, %r10
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
               	orq	%r14, %rax
               	movq	%rax, -0x18(%rbp)
               	movsd	-0x18(%rbp,%riz), %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rbp,%riz)
               	movq	-0x8(%rbp), %rax
               	cmpq	0x40(%rsp), %rax
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
               	movq	(%rcx), %rsi
               	movq	(%rdx), %rdx
               	leaq	-0x10(%rbp), %rax
               	movq	%rsi, (%rax)
               	xorl	%ecx, %ecx
               	movq	%rcx, 0x8(%rax)
               	orq	%rcx, %rdx
               	orq	%rsi, %rcx
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
               	subq	%rdi, %rcx
               	movabsq	$-0x8000000000000000, %r12 # imm = 0x8000000000000000
               	andq	%rax, %r12
               	testq	%rcx, %rcx
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rcx, %rax
               	shrq	$0x20, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x5, %rax
               	leaq	0x1(%rax), %r8
               	movq	%rcx, %rdx
               	pushq	%rcx
               	movq	%rax, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movq	%rdx, %rax
               	shrq	$0x10, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	addq	%rax, %r8
               	pushq	%rcx
               	movq	%rax, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movq	%rdx, %rax
               	shrq	$0x8, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %r8
               	pushq	%rcx
               	movq	%rax, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movq	%rdx, %rax
               	shrq	$0x4, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x2, %rax
               	addq	%rax, %r8
               	pushq	%rcx
               	movq	%rax, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movq	%rdx, %rax
               	shrq	$0x2, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	addq	%rax, %r8
               	pushq	%rcx
               	movq	%rax, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movq	%rdx, %rax
               	shrq	%rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	addq	%rax, %r8
               	movq	%r8, %rax
               	imulq	%rdi, %rax
               	movl	$0x40, %edx
               	subq	%rax, %rdx
               	andq	$0x3f, %rdx
               	movq	$-0x1, %rdi
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	imulq	%rdi, %rdx
               	andq	%rsi, %rdx
               	testq	%rdx, %rdx
               	setne	%r13b
               	movzbq	%r13b, %r13
               	movq	%rax, %rdi
               	andq	$0x7f, %rdi
               	movq	%rax, %rdx
               	andq	$0x3f, %rdx
               	movl	$0x3f, %r8d
               	movq	%r8, %r14
               	subq	%rdx, %r14
               	movq	%rdi, %r8
               	shrq	$0x6, %r8
               	xorl	%edi, %edi
               	subq	%r8, %rdi
               	movq	%rdi, %r8
               	xorq	$-0x1, %r8
               	movq	%rcx, %rbx
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rbx
               	popq	%rcx
               	movq	%rcx, %r11
               	movq	%r14, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	shlq	%rcx
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	orq	%rsi, %rcx
               	andq	%r8, %rcx
               	movq	%rbx, %rdx
               	andq	%rdi, %rdx
               	orq	%rdx, %rcx
               	orq	%r13, %rcx
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
               	orq	%r12, %rax
               	movq	%rax, -0x18(%rbp)
               	movsd	-0x18(%rbp,%riz), %xmm1
               	mulsd	%xmm1, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	leaq	-0x10(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
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
               	subq	$0x48, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r12
               	movslq	%edx, %rdi
               	movq	%rsi, %r13
               	leaq	<rip>, %r8
               	movsd	%xmm0, (%r8,%riz)
               	movsd	(%r8,%riz), %xmm0
               	movsd	%xmm0, -0x8(%rbp,%riz)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %r10
               	sarq	$0x3f, %r10
               	movq	%r10, 0x48(%rsp)
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rax, %rcx
               	shrq	$0x34, %rcx
               	leaq	-0x3ff(%rcx), %r14
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$0x10000000000000, %r9  # imm = 0x10000000000000
               	orq	%rax, %r9
               	subq	$0x433, %rcx            # imm = 0x433
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	xorq	%rax, %rcx
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	xorl	%ecx, %ecx
               	movq	%rdx, %rsi
               	andq	$0x7f, %rsi
               	andq	$0x3f, %rdx
               	movl	$0x3f, %ebx
               	movq	%rbx, %r15
               	subq	%rdx, %r15
               	shrq	$0x6, %rsi
               	movq	%rcx, %rbx
               	subq	%rsi, %rbx
               	movq	%rbx, %rsi
               	xorq	$-0x1, %rsi
               	movq	%r9, %r10
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shlq	%cl, %r10
               	popq	%rcx
               	movq	%r10, 0x58(%rsp)
               	movq	%r9, %r10
               	pushq	%rcx
               	movq	%r15, %rcx
               	shrq	%cl, %r10
               	popq	%rcx
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	shrq	%r10
               	movq	%r10, 0x50(%rsp)
               	movq	%rcx, %r10
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shlq	%cl, %r10
               	popq	%rcx
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	orq	0x50(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rsp), %r10
               	andq	%rsi, %r10
               	movq	%r10, 0x38(%rsp)
               	xorl	%r10d, %r10d
               	movq	%r10, 0x50(%rsp)
               	movq	0x38(%rsp), %r10
               	orq	0x50(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x40(%rsp), %r10
               	andq	%rsi, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rsp), %r10
               	andq	%rbx, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x40(%rsp), %r10
               	orq	0x58(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	%rcx, %r10
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %r10
               	popq	%rcx
               	movq	%r10, 0x58(%rsp)
               	movq	%r15, %r10
               	movq	%rcx, %r15
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %r15
               	popq	%rcx
               	shlq	%r15
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %r9
               	popq	%rcx
               	movq	%r9, %rdx
               	orq	%r15, %rdx
               	andq	%rsi, %rdx
               	movq	0x58(%rsp), %r9
               	andq	%rbx, %r9
               	orq	%rdx, %r9
               	movq	0x58(%rsp), %rdx
               	andq	%rsi, %rdx
               	movq	%rdx, %rsi
               	orq	0x50(%rsp), %rsi
               	movq	%rax, %rdx
               	xorq	$-0x1, %rdx
               	movq	0x38(%rsp), %rbx
               	andq	%rdx, %rbx
               	andq	%rax, %r9
               	orq	%rbx, %r9
               	movq	%rdx, %r10
               	movq	0x40(%rsp), %rdx
               	andq	%r10, %rdx
               	andq	%rsi, %rax
               	orq	%rax, %rdx
               	movq	%r14, %rax
               	sarq	$0x3f, %rax
               	xorq	$-0x1, %rax
               	movq	%r9, %rsi
               	andq	%rax, %rsi
               	andq	%rax, %rdx
               	cmpl	$0x80, %r14d
               	setge	%r9b
               	movzbq	%r9b, %r9
               	movq	%rcx, %rax
               	subq	%r9, %rax
               	movq	%rax, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rsi
               	andq	$-0x1, %rax
               	orq	%rax, %rsi
               	andq	%rdx, %rcx
               	orq	%rax, %rcx
               	movq	0x48(%rsp), %rax
               	xorq	$-0x1, %rax
               	movq	%rsi, %rdx
               	andq	%rax, %rdx
               	andq	%rcx, %rax
               	cmpq	%r12, %rax
               	jne	<addr>
               	cmpq	%r13, %rdx
               	je	<addr>
               	movq	%rdi, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movsd	(%r8,%riz), %xmm0
               	movsd	%xmm0, -0x8(%rbp,%riz)
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rcx, %rdx
               	shrq	$0x34, %rdx
               	leaq	-0x3ff(%rdx), %r14
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$0x10000000000000, %r9  # imm = 0x10000000000000
               	orq	%rcx, %r9
               	subq	$0x433, %rdx            # imm = 0x433
               	movq	%rdx, %rcx
               	sarq	$0x3f, %rcx
               	xorq	%rcx, %rdx
               	movq	%rdx, %rsi
               	subq	%rcx, %rsi
               	xorl	%edx, %edx
               	movq	%rsi, %r8
               	andq	$0x7f, %r8
               	andq	$0x3f, %rsi
               	movl	$0x3f, %ebx
               	movq	%rbx, %r15
               	subq	%rsi, %r15
               	shrq	$0x6, %r8
               	movq	%rdx, %rbx
               	subq	%r8, %rbx
               	movq	%rbx, %r8
               	xorq	$-0x1, %r8
               	movq	%r9, %r10
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shlq	%cl, %r10
               	popq	%rcx
               	movq	%r10, 0x58(%rsp)
               	movq	%r9, %r10
               	pushq	%rcx
               	movq	%r15, %rcx
               	shrq	%cl, %r10
               	popq	%rcx
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	shrq	%r10
               	movq	%r10, 0x50(%rsp)
               	movq	%rdx, %r10
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shlq	%cl, %r10
               	popq	%rcx
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r10
               	orq	0x50(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x58(%rsp), %r10
               	andq	%r8, %r10
               	movq	%r10, 0x40(%rsp)
               	xorl	%r10d, %r10d
               	movq	%r10, 0x50(%rsp)
               	movq	0x40(%rsp), %r10
               	orq	0x50(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x48(%rsp), %r10
               	andq	%r8, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x58(%rsp), %r10
               	andq	%rbx, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x48(%rsp), %r10
               	orq	0x58(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%rdx, %r10
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %r10
               	popq	%rcx
               	movq	%r10, 0x58(%rsp)
               	movq	%r15, %r10
               	movq	%rdx, %r15
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %r15
               	popq	%rcx
               	shlq	%r15
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %r9
               	popq	%rcx
               	movq	%r9, %rsi
               	orq	%r15, %rsi
               	andq	%r8, %rsi
               	movq	0x58(%rsp), %r9
               	andq	%rbx, %r9
               	orq	%rsi, %r9
               	movq	0x58(%rsp), %rsi
               	andq	%r8, %rsi
               	movq	%rsi, %r8
               	orq	0x50(%rsp), %r8
               	movq	%rcx, %rsi
               	xorq	$-0x1, %rsi
               	movq	0x40(%rsp), %rbx
               	andq	%rsi, %rbx
               	andq	%rcx, %r9
               	orq	%rbx, %r9
               	movq	%rsi, %r10
               	movq	0x48(%rsp), %rsi
               	andq	%r10, %rsi
               	andq	%r8, %rcx
               	orq	%rcx, %rsi
               	movq	%r14, %rcx
               	sarq	$0x3f, %rcx
               	xorq	$-0x1, %rcx
               	movq	%r9, %r8
               	andq	%rcx, %r8
               	andq	%rcx, %rsi
               	cmpl	$0x80, %r14d
               	setge	%r9b
               	movzbq	%r9b, %r9
               	movq	%rdx, %rcx
               	subq	%r9, %rcx
               	movq	%r8, %rdx
               	xorq	%rax, %rdx
               	xorq	%rax, %rsi
               	cmpq	%rax, %rdx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	subq	%rax, %rdx
               	subq	%rax, %rsi
               	subq	%r8, %rsi
               	movq	%rax, %r8
               	xorq	$-0x1, %r8
               	movabsq	$0x7fffffffffffffff, %r9 # imm = 0x7FFFFFFFFFFFFFFF
               	xorq	%rax, %r9
               	movq	%rcx, %rax
               	xorq	$-0x1, %rax
               	andq	%rax, %rdx
               	andq	%rcx, %r8
               	orq	%r8, %rdx
               	andq	%rsi, %rax
               	andq	%r9, %rcx
               	orq	%rcx, %rax
               	cmpq	%r12, %rax
               	jne	<addr>
               	cmpq	%r13, %rdx
               	je	<addr>
               	leaq	0x1(%rdi), %rax
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
               	movq	%rdi, 0x48(%rsp)
               	movslq	%edx, %r8
               	movq	%rsi, 0x40(%rsp)
               	leaq	<rip>, %rax
               	movsd	%xmm0, (%rax,%riz)
               	movsd	(%rax,%riz), %xmm0
               	movsd	%xmm0, -0x8(%rbp,%riz)
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rcx, %rdx
               	shrq	$0x34, %rdx
               	leaq	-0x3ff(%rdx), %r12
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$0x10000000000000, %r9  # imm = 0x10000000000000
               	orq	%rcx, %r9
               	subq	$0x433, %rdx            # imm = 0x433
               	movq	%rdx, %rcx
               	sarq	$0x3f, %rcx
               	xorq	%rcx, %rdx
               	movq	%rdx, %rsi
               	subq	%rcx, %rsi
               	xorl	%edx, %edx
               	movq	%rsi, %rdi
               	andq	$0x7f, %rdi
               	andq	$0x3f, %rsi
               	movl	$0x3f, %ebx
               	movq	%rbx, %r13
               	subq	%rsi, %r13
               	shrq	$0x6, %rdi
               	movq	%rdx, %rbx
               	subq	%rdi, %rbx
               	movq	%rbx, %rdi
               	xorq	$-0x1, %rdi
               	movq	%r9, %r14
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shlq	%cl, %r14
               	popq	%rcx
               	movq	%r9, %r15
               	pushq	%rcx
               	movq	%r13, %rcx
               	shrq	%cl, %r15
               	popq	%rcx
               	shrq	%r15
               	movq	%rdx, %r10
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shlq	%cl, %r10
               	popq	%rcx
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %r10
               	orq	%r15, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%r14, %r10
               	andq	%rdi, %r10
               	movq	%r10, 0x30(%rsp)
               	xorl	%r15d, %r15d
               	movq	0x30(%rsp), %r10
               	orq	%r15, %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x38(%rsp), %r10
               	andq	%rdi, %r10
               	movq	%r10, 0x38(%rsp)
               	andq	%rbx, %r14
               	movq	0x38(%rsp), %r10
               	orq	%r14, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%rdx, %r14
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %r14
               	popq	%rcx
               	movq	%r13, %r10
               	movq	%rdx, %r13
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %r13
               	popq	%rcx
               	shlq	%r13
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %r9
               	popq	%rcx
               	movq	%r9, %rsi
               	orq	%r13, %rsi
               	andq	%rdi, %rsi
               	movq	%r14, %r9
               	andq	%rbx, %r9
               	orq	%rsi, %r9
               	movq	%r14, %rsi
               	andq	%rdi, %rsi
               	movq	%rsi, %rdi
               	orq	%r15, %rdi
               	movq	%rcx, %rsi
               	xorq	$-0x1, %rsi
               	movq	0x30(%rsp), %rbx
               	andq	%rsi, %rbx
               	andq	%rcx, %r9
               	orq	%rbx, %r9
               	movq	%rsi, %r10
               	movq	0x38(%rsp), %rsi
               	andq	%r10, %rsi
               	andq	%rdi, %rcx
               	orq	%rcx, %rsi
               	movq	%r12, %rcx
               	sarq	$0x3f, %rcx
               	xorq	$-0x1, %rcx
               	movq	%r9, %rdi
               	andq	%rcx, %rdi
               	andq	%rcx, %rsi
               	cmpl	$0x80, %r12d
               	setge	%r9b
               	movzbq	%r9b, %r9
               	movq	%rdx, %rcx
               	subq	%r9, %rcx
               	movq	%rdi, %rdx
               	xorq	%rax, %rdx
               	xorq	%rax, %rsi
               	cmpq	%rax, %rdx
               	setb	%dil
               	movzbq	%dil, %rdi
               	subq	%rax, %rdx
               	subq	%rax, %rsi
               	subq	%rdi, %rsi
               	movq	%rax, %rdi
               	xorq	$-0x1, %rdi
               	movabsq	$0x7fffffffffffffff, %r9 # imm = 0x7FFFFFFFFFFFFFFF
               	xorq	%rax, %r9
               	movq	%rcx, %rax
               	xorq	$-0x1, %rax
               	andq	%rax, %rdx
               	andq	%rcx, %rdi
               	orq	%rdi, %rdx
               	andq	%rsi, %rax
               	andq	%r9, %rcx
               	orq	%rcx, %rax
               	cmpq	0x48(%rsp), %rax
               	jne	<addr>
               	cmpq	0x40(%rsp), %rdx
               	je	<addr>
               	movq	%r8, %rax
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
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	xorl	%edi, %edi
               	movl	$0x47, %edx
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
               	movq	%rax, %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movq	$-0x1, %rdi
               	movq	$-0x3, %rsi
               	movl	$0x49, %edx
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
               	movabsq	$0x47e0000000000000, %rax # imm = 0x47E0000000000000
               	movq	%rax, %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$-0x8000000000000000, %rdi # imm = 0x8000000000000000
               	xorl	%esi, %esi
               	movl	$0x51, %edx
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
               	movss	(%rax,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movsd	%xmm0, -0x8(%rbp,%riz)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %r14
               	sarq	$0x3f, %r14
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rax, %rcx
               	shrq	$0x34, %rcx
               	leaq	-0x3ff(%rcx), %r9
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$0x10000000000000, %rdi # imm = 0x10000000000000
               	orq	%rax, %rdi
               	subq	$0x433, %rcx            # imm = 0x433
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	xorq	%rax, %rcx
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	xorl	%ecx, %ecx
               	movq	%rdx, %rsi
               	andq	$0x7f, %rsi
               	andq	$0x3f, %rdx
               	movl	$0x3f, %r8d
               	movq	%r8, %rbx
               	subq	%rdx, %rbx
               	shrq	$0x6, %rsi
               	movq	%rcx, %r8
               	subq	%rsi, %r8
               	movq	%r8, %rsi
               	xorq	$-0x1, %rsi
               	movq	%rdi, %r12
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shlq	%cl, %r12
               	popq	%rcx
               	movq	%r12, %r10
               	andq	%rsi, %r10
               	movq	%r10, 0x38(%rsp)
               	xorl	%r13d, %r13d
               	movq	0x38(%rsp), %r10
               	orq	%r13, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%rcx, %r12
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %r12
               	popq	%rcx
               	movq	%rbx, %r10
               	movq	%rcx, %rbx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rbx
               	popq	%rcx
               	shlq	%rbx
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	movq	%rdi, %rdx
               	orq	%rbx, %rdx
               	andq	%rsi, %rdx
               	movq	%r12, %rdi
               	andq	%r8, %rdi
               	orq	%rdx, %rdi
               	movq	%rax, %rdx
               	xorq	$-0x1, %rdx
               	movq	0x38(%rsp), %r8
               	andq	%rdx, %r8
               	andq	%rax, %rdi
               	orq	%r8, %rdi
               	movq	%r9, %rax
               	sarq	$0x3f, %rax
               	xorq	$-0x1, %rax
               	movq	%rdi, %rsi
               	andq	%rax, %rsi
               	cmpl	$0x80, %r9d
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rcx, %rax
               	subq	%rdi, %rax
               	movq	%rax, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rsi
               	andq	$-0x1, %rax
               	orq	%rax, %rsi
               	movq	%r14, %rax
               	xorq	$-0x1, %rax
               	movq	%rsi, %rdx
               	andq	%rax, %rdx
               	cmpq	$0x2, %rdx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movss	(%rax,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movsd	%xmm0, -0x8(%rbp,%riz)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %r14
               	sarq	$0x3f, %r14
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rax, %rcx
               	shrq	$0x34, %rcx
               	leaq	-0x3ff(%rcx), %r9
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$0x10000000000000, %rdi # imm = 0x10000000000000
               	orq	%rax, %rdi
               	subq	$0x433, %rcx            # imm = 0x433
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	xorq	%rax, %rcx
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	xorl	%ecx, %ecx
               	movq	%rdx, %rsi
               	andq	$0x7f, %rsi
               	andq	$0x3f, %rdx
               	movl	$0x3f, %r8d
               	movq	%r8, %rbx
               	subq	%rdx, %rbx
               	shrq	$0x6, %rsi
               	movq	%rcx, %r8
               	subq	%rsi, %r8
               	movq	%r8, %rsi
               	xorq	$-0x1, %rsi
               	movq	%rdi, %r12
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shlq	%cl, %r12
               	popq	%rcx
               	movq	%rdi, %r13
               	pushq	%rcx
               	movq	%rbx, %rcx
               	shrq	%cl, %r13
               	popq	%rcx
               	shrq	%r13
               	movq	%rcx, %r15
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shlq	%cl, %r15
               	popq	%rcx
               	orq	%r13, %r15
               	xorl	%r13d, %r13d
               	andq	%rsi, %r15
               	andq	%r8, %r12
               	orq	%r12, %r15
               	movq	%rcx, %r12
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %r12
               	popq	%rcx
               	movq	%r12, %rdx
               	andq	%rsi, %rdx
               	movq	%rdx, %rsi
               	orq	%r13, %rsi
               	movq	%rax, %rdx
               	xorq	$-0x1, %rdx
               	andq	%r15, %rdx
               	andq	%rsi, %rax
               	orq	%rax, %rdx
               	movq	%r9, %rax
               	sarq	$0x3f, %rax
               	xorq	$-0x1, %rax
               	andq	%rax, %rdx
               	cmpl	$0x80, %r9d
               	setge	%dil
               	movzbq	%dil, %rdi
               	movq	%rcx, %rax
               	subq	%rdi, %rax
               	movq	%rax, %rcx
               	xorq	$-0x1, %rcx
               	andq	$-0x1, %rax
               	andq	%rdx, %rcx
               	orq	%rax, %rcx
               	movq	%r14, %rax
               	xorq	$-0x1, %rax
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
               	movl	$0x40600000, %ecx       # imm = 0x40600000
               	movq	%rcx, %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	movss	(%rax,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movsd	%xmm0, -0x8(%rbp,%riz)
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
               	subq	$0x433, %rdx            # imm = 0x433
               	movq	%rdx, %rcx
               	sarq	$0x3f, %rcx
               	xorq	%rcx, %rdx
               	movq	%rdx, %rsi
               	subq	%rcx, %rsi
               	xorl	%edx, %edx
               	movq	%rsi, %rdi
               	andq	$0x7f, %rdi
               	andq	$0x3f, %rsi
               	movl	$0x3f, %r9d
               	movq	%r9, %r12
               	subq	%rsi, %r12
               	shrq	$0x6, %rdi
               	movq	%rdx, %r9
               	subq	%rdi, %r9
               	movq	%r9, %rdi
               	xorq	$-0x1, %rdi
               	movq	%r8, %r13
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shlq	%cl, %r13
               	popq	%rcx
               	movq	%r13, %r10
               	andq	%rdi, %r10
               	movq	%r10, 0x38(%rsp)
               	xorl	%r14d, %r14d
               	movq	0x38(%rsp), %r10
               	orq	%r14, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%rdx, %r13
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %r13
               	popq	%rcx
               	movq	%r12, %r10
               	movq	%rdx, %r12
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %r12
               	popq	%rcx
               	shlq	%r12
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %r8
               	popq	%rcx
               	movq	%r8, %rsi
               	orq	%r12, %rsi
               	andq	%rdi, %rsi
               	movq	%r13, %r8
               	andq	%r9, %r8
               	orq	%rsi, %r8
               	movq	%rcx, %rsi
               	xorq	$-0x1, %rsi
               	movq	0x38(%rsp), %r9
               	andq	%rsi, %r9
               	andq	%rcx, %r8
               	orq	%r9, %r8
               	movq	%rbx, %rcx
               	sarq	$0x3f, %rcx
               	xorq	$-0x1, %rcx
               	movq	%r8, %rdi
               	andq	%rcx, %rdi
               	cmpl	$0x80, %ebx
               	setge	%r8b
               	movzbq	%r8b, %r8
               	movq	%rdx, %rcx
               	subq	%r8, %rcx
               	movq	%rdi, %rdx
               	xorq	%rax, %rdx
               	subq	%rax, %rdx
               	movq	%rax, %rdi
               	xorq	$-0x1, %rdi
               	movq	%rcx, %rax
               	xorq	$-0x1, %rax
               	andq	%rax, %rdx
               	andq	%rcx, %rdi
               	orq	%rdi, %rdx
               	cmpq	$-0x3, %rdx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movss	(%rax,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movsd	%xmm0, -0x8(%rbp,%riz)
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
               	subq	$0x433, %rdx            # imm = 0x433
               	movq	%rdx, %rcx
               	sarq	$0x3f, %rcx
               	xorq	%rcx, %rdx
               	movq	%rdx, %rsi
               	subq	%rcx, %rsi
               	xorl	%edx, %edx
               	movq	%rsi, %rdi
               	andq	$0x7f, %rdi
               	andq	$0x3f, %rsi
               	movl	$0x3f, %r9d
               	movq	%r9, %r12
               	subq	%rsi, %r12
               	shrq	$0x6, %rdi
               	movq	%rdx, %r9
               	subq	%rdi, %r9
               	movq	%r9, %rdi
               	xorq	$-0x1, %rdi
               	movq	%r8, %r13
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shlq	%cl, %r13
               	popq	%rcx
               	movq	%r8, %r14
               	pushq	%rcx
               	movq	%r12, %rcx
               	shrq	%cl, %r14
               	popq	%rcx
               	shrq	%r14
               	movq	%rdx, %r15
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shlq	%cl, %r15
               	popq	%rcx
               	orq	%r14, %r15
               	movq	%r13, %r10
               	andq	%rdi, %r10
               	movq	%r10, 0x38(%rsp)
               	xorl	%r14d, %r14d
               	movq	0x38(%rsp), %r10
               	orq	%r14, %r10
               	movq	%r10, 0x38(%rsp)
               	andq	%rdi, %r15
               	andq	%r9, %r13
               	orq	%r13, %r15
               	movq	%rdx, %r13
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %r13
               	popq	%rcx
               	movq	%r12, %r10
               	movq	%rdx, %r12
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %r12
               	popq	%rcx
               	shlq	%r12
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %r8
               	popq	%rcx
               	movq	%r8, %rsi
               	orq	%r12, %rsi
               	andq	%rdi, %rsi
               	movq	%r13, %r8
               	andq	%r9, %r8
               	orq	%rsi, %r8
               	movq	%r13, %rsi
               	andq	%rdi, %rsi
               	movq	%rsi, %rdi
               	orq	%r14, %rdi
               	movq	%rcx, %rsi
               	xorq	$-0x1, %rsi
               	movq	0x38(%rsp), %r9
               	andq	%rsi, %r9
               	andq	%rcx, %r8
               	orq	%r9, %r8
               	andq	%r15, %rsi
               	andq	%rdi, %rcx
               	orq	%rcx, %rsi
               	movq	%rbx, %rcx
               	sarq	$0x3f, %rcx
               	xorq	$-0x1, %rcx
               	movq	%r8, %rdi
               	andq	%rcx, %rdi
               	andq	%rcx, %rsi
               	cmpl	$0x80, %ebx
               	setge	%r8b
               	movzbq	%r8b, %r8
               	movq	%rdx, %rcx
               	subq	%r8, %rcx
               	movq	%rdi, %rdx
               	xorq	%rax, %rdx
               	xorq	%rax, %rsi
               	cmpq	%rax, %rdx
               	setb	%dil
               	movzbq	%dil, %rdi
               	subq	%rax, %rsi
               	subq	%rdi, %rsi
               	movabsq	$0x7fffffffffffffff, %r8 # imm = 0x7FFFFFFFFFFFFFFF
               	xorq	%rax, %r8
               	movq	%rcx, %rax
               	xorq	$-0x1, %rax
               	andq	%rsi, %rax
               	andq	%r8, %rcx
               	orq	%rcx, %rax
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
               	leaq	<rip>, %rdx
               	movabsq	$0x10000000000000, %rsi # imm = 0x10000000000000
               	movq	%rsi, (%rdx)
               	movq	(%rcx), %rcx
               	movq	(%rdx), %rdx
               	movq	%rax, %rdi
               	orq	%rdx, %rdi
               	orq	%rax, %rcx
               	testq	%rcx, %rcx
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%rcx, %rdx
               	shrq	$0x20, %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x5, %rdx
               	leaq	0x1(%rdx), %r9
               	movq	%rcx, %rsi
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movq	%rsi, %rdx
               	shrq	$0x10, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %r9
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movq	%rsi, %rdx
               	shrq	$0x8, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r9
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movq	%rsi, %rdx
               	shrq	$0x4, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r9
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movq	%rsi, %rdx
               	shrq	$0x2, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	addq	%rdx, %r9
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movq	%rsi, %rdx
               	shrq	%rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	addq	%rdx, %r9
               	movq	%r9, %rdx
               	imulq	%r8, %rdx
               	movl	$0x40, %esi
               	subq	%rdx, %rsi
               	andq	$0x3f, %rsi
               	movq	$-0x1, %r9
               	movq	%r9, %r8
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %r8
               	popq	%rcx
               	testq	%rdx, %rdx
               	setne	%sil
               	movzbq	%sil, %rsi
               	imulq	%r8, %rsi
               	andq	%rdi, %rsi
               	testq	%rsi, %rsi
               	setne	%r14b
               	movzbq	%r14b, %r14
               	movq	%rdx, %rbx
               	andq	$0x7f, %rbx
               	movq	%rdx, %rsi
               	andq	$0x3f, %rsi
               	movl	$0x3f, %r8d
               	movq	%r8, %r15
               	subq	%rsi, %r15
               	shrq	$0x6, %rbx
               	negq	%rbx
               	addq	%rax, %rbx
               	movq	%rbx, %r12
               	xorq	$-0x1, %r12
               	movq	%rcx, %r13
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %r13
               	popq	%rcx
               	movq	%rcx, %r11
               	movq	%r15, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	shlq	%rcx
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	orq	%rdi, %rcx
               	andq	%r12, %rcx
               	movq	%r13, %rsi
               	andq	%rbx, %rsi
               	orq	%rsi, %rcx
               	orq	%r14, %rcx
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
               	leaq	0x3ff(%rdx), %rcx
               	shlq	$0x34, %rcx
               	orq	%rax, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movsd	-0x8(%rbp,%riz), %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rbp,%riz)
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, %r15
               	sarq	$0x3f, %r15
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rcx, %rdx
               	shrq	$0x34, %rdx
               	leaq	-0x3ff(%rdx), %rbx
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$0x10000000000000, %rdi # imm = 0x10000000000000
               	orq	%rcx, %rdi
               	subq	$0x433, %rdx            # imm = 0x433
               	movq	%rdx, %rcx
               	sarq	$0x3f, %rcx
               	xorq	%rcx, %rdx
               	subq	%rcx, %rdx
               	movq	%rdx, %rsi
               	andq	$0x7f, %rsi
               	andq	$0x3f, %rdx
               	movq	%r8, %r12
               	subq	%rdx, %r12
               	shrq	$0x6, %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movq	%r8, %rsi
               	xorq	$-0x1, %rsi
               	movq	%rdi, %r13
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shlq	%cl, %r13
               	popq	%rcx
               	movq	%r13, %r10
               	andq	%rsi, %r10
               	movq	%r10, 0x30(%rsp)
               	xorl	%r14d, %r14d
               	movq	0x30(%rsp), %r10
               	orq	%r14, %r10
               	movq	%r10, 0x30(%rsp)
               	movq	%rax, %r13
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %r13
               	popq	%rcx
               	movq	%r12, %r10
               	movq	%rax, %r12
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %r12
               	popq	%rcx
               	shlq	%r12
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	movq	%rdi, %rdx
               	orq	%r12, %rdx
               	andq	%rsi, %rdx
               	movq	%r13, %rdi
               	andq	%r8, %rdi
               	orq	%rdx, %rdi
               	movq	%rcx, %rdx
               	xorq	$-0x1, %rdx
               	movq	0x30(%rsp), %r8
               	andq	%rdx, %r8
               	andq	%rcx, %rdi
               	orq	%r8, %rdi
               	movq	%rbx, %rcx
               	sarq	$0x3f, %rcx
               	xorq	$-0x1, %rcx
               	movq	%rdi, %rsi
               	andq	%rcx, %rsi
               	cmpl	$0x80, %ebx
               	setge	%cl
               	movzbq	%cl, %rcx
               	subq	%rcx, %rax
               	movq	%rax, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rsi
               	andq	%r9, %rax
               	orq	%rax, %rsi
               	movq	%r15, %rax
               	xorq	$-0x1, %rax
               	movq	%rsi, %rdx
               	andq	%rax, %rdx
               	movabsq	$0x10000000000000, %r11 # imm = 0x10000000000000
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
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
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	movq	%rax, (%rdx)
               	movq	(%rcx), %rcx
               	movq	(%rdx), %rdx
               	movq	%rax, %rdi
               	orq	%rdx, %rdi
               	orq	%rax, %rcx
               	testq	%rcx, %rcx
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%rcx, %rdx
               	shrq	$0x20, %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x5, %rdx
               	leaq	0x1(%rdx), %r9
               	movq	%rcx, %rsi
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movq	%rsi, %rdx
               	shrq	$0x10, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %r9
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movq	%rsi, %rdx
               	shrq	$0x8, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r9
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movq	%rsi, %rdx
               	shrq	$0x4, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r9
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movq	%rsi, %rdx
               	shrq	$0x2, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	addq	%rdx, %r9
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movq	%rsi, %rdx
               	shrq	%rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	addq	%rdx, %r9
               	movq	%r9, %rdx
               	imulq	%r8, %rdx
               	movl	$0x40, %esi
               	subq	%rdx, %rsi
               	andq	$0x3f, %rsi
               	movq	$-0x1, %r9
               	movq	%r9, %r8
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %r8
               	popq	%rcx
               	testq	%rdx, %rdx
               	setne	%sil
               	movzbq	%sil, %rsi
               	imulq	%r8, %rsi
               	andq	%rdi, %rsi
               	testq	%rsi, %rsi
               	setne	%r14b
               	movzbq	%r14b, %r14
               	movq	%rdx, %rbx
               	andq	$0x7f, %rbx
               	movq	%rdx, %rsi
               	andq	$0x3f, %rsi
               	movl	$0x3f, %r8d
               	movq	%r8, %r15
               	subq	%rsi, %r15
               	shrq	$0x6, %rbx
               	negq	%rbx
               	addq	%rax, %rbx
               	movq	%rbx, %r12
               	xorq	$-0x1, %r12
               	movq	%rcx, %r13
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %r13
               	popq	%rcx
               	movq	%rcx, %r11
               	movq	%r15, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	shlq	%rcx
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	orq	%rdi, %rcx
               	andq	%r12, %rcx
               	movq	%r13, %rsi
               	andq	%rbx, %rsi
               	orq	%rsi, %rcx
               	orq	%r14, %rcx
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
               	leaq	0x3ff(%rdx), %rcx
               	shlq	$0x34, %rcx
               	orq	%rax, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movsd	-0x8(%rbp,%riz), %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rbp,%riz)
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, %r15
               	sarq	$0x3f, %r15
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rcx, %rdx
               	shrq	$0x34, %rdx
               	leaq	-0x3ff(%rdx), %rbx
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$0x10000000000000, %rdi # imm = 0x10000000000000
               	orq	%rcx, %rdi
               	subq	$0x433, %rdx            # imm = 0x433
               	movq	%rdx, %rcx
               	sarq	$0x3f, %rcx
               	xorq	%rcx, %rdx
               	subq	%rcx, %rdx
               	movq	%rdx, %rsi
               	andq	$0x7f, %rsi
               	andq	$0x3f, %rdx
               	movq	%r8, %r12
               	subq	%rdx, %r12
               	shrq	$0x6, %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movq	%r8, %rsi
               	xorq	$-0x1, %rsi
               	movq	%rdi, %r13
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shlq	%cl, %r13
               	popq	%rcx
               	movq	%rdi, %r14
               	pushq	%rcx
               	movq	%r12, %rcx
               	shrq	%cl, %r14
               	popq	%rcx
               	shrq	%r14
               	movq	%rax, %r10
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shlq	%cl, %r10
               	popq	%rcx
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %r10
               	orq	%r14, %r10
               	movq	%r10, 0x38(%rsp)
               	xorl	%r14d, %r14d
               	movq	0x38(%rsp), %r10
               	andq	%rsi, %r10
               	movq	%r10, 0x38(%rsp)
               	andq	%r8, %r13
               	movq	0x38(%rsp), %r10
               	orq	%r13, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%rax, %r13
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %r13
               	popq	%rcx
               	movq	%r13, %rdx
               	andq	%rsi, %rdx
               	movq	%rdx, %rsi
               	orq	%r14, %rsi
               	movq	%rcx, %rdx
               	xorq	$-0x1, %rdx
               	movq	%rdx, %r10
               	movq	0x38(%rsp), %rdx
               	andq	%r10, %rdx
               	andq	%rsi, %rcx
               	orq	%rcx, %rdx
               	movq	%rbx, %rcx
               	sarq	$0x3f, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rdx
               	cmpl	$0x80, %ebx
               	setge	%cl
               	movzbq	%cl, %rcx
               	subq	%rcx, %rax
               	movq	%rax, %rcx
               	xorq	$-0x1, %rcx
               	andq	%r9, %rax
               	andq	%rdx, %rcx
               	orq	%rax, %rcx
               	movq	%r15, %rax
               	xorq	$-0x1, %rax
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
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rdx
               	movq	$0x3, (%rdx)
               	leaq	<rip>, %rdi
               	movabsq	$0x3ff8000000000000, %rsi # imm = 0x3FF8000000000000
               	movq	%rsi, %xmm14
               	movsd	%xmm14, (%rdi,%riz)
               	movq	(%rcx), %rcx
               	movq	(%rdx), %rdx
               	movq	%rax, %r8
               	orq	%rdx, %r8
               	orq	%rax, %rcx
               	testq	%rcx, %rcx
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%rcx, %rdx
               	shrq	$0x20, %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x5, %rdx
               	leaq	0x1(%rdx), %rbx
               	movq	%rcx, %rsi
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movq	%rsi, %rdx
               	shrq	$0x10, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %rbx
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movq	%rsi, %rdx
               	shrq	$0x8, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rbx
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movq	%rsi, %rdx
               	shrq	$0x4, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rbx
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movq	%rsi, %rdx
               	shrq	$0x2, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	addq	%rdx, %rbx
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	movq	%rsi, %rdx
               	shrq	%rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	addq	%rdx, %rbx
               	movq	%rbx, %rdx
               	imulq	%r9, %rdx
               	movl	$0x40, %esi
               	subq	%rdx, %rsi
               	andq	$0x3f, %rsi
               	movq	$-0x1, %r9
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %r9
               	popq	%rcx
               	testq	%rdx, %rdx
               	setne	%sil
               	movzbq	%sil, %rsi
               	imulq	%r9, %rsi
               	andq	%r8, %rsi
               	testq	%rsi, %rsi
               	setne	%r13b
               	movzbq	%r13b, %r13
               	movq	%rdx, %r9
               	andq	$0x7f, %r9
               	movq	%rdx, %rsi
               	andq	$0x3f, %rsi
               	movl	$0x3f, %ebx
               	movq	%rbx, %r14
               	subq	%rsi, %r14
               	shrq	$0x6, %r9
               	negq	%r9
               	addq	%rax, %r9
               	movq	%r9, %rbx
               	xorq	$-0x1, %rbx
               	movq	%rcx, %r12
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %r12
               	popq	%rcx
               	movq	%rcx, %r11
               	movq	%r14, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	shlq	%rcx
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shrq	%cl, %r8
               	popq	%rcx
               	orq	%r8, %rcx
               	andq	%rbx, %rcx
               	movq	%r12, %rsi
               	andq	%r9, %rsi
               	orq	%rsi, %rcx
               	orq	%r13, %rcx
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
               	leaq	0x3ff(%rdx), %rcx
               	shlq	$0x34, %rcx
               	orq	%rcx, %rax
               	movq	%rax, -0x8(%rbp)
               	movsd	-0x8(%rbp,%riz), %xmm1
               	movsd	(%rdi,%riz), %xmm2
               	movapd	%xmm0, %xmm14
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movsd	%xmm0, -0x8(%rbp,%riz)
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
               	xorl	%eax, %eax
               	orq	%rax, %rdx
               	orq	%rax, %rcx
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
               	subq	%rdi, %rcx
               	movabsq	$-0x8000000000000000, %rbx # imm = 0x8000000000000000
               	andq	%rax, %rbx
               	testq	%rcx, %rcx
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rcx, %rax
               	shrq	$0x20, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x5, %rax
               	leaq	0x1(%rax), %r8
               	movq	%rcx, %rdx
               	pushq	%rcx
               	movq	%rax, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movq	%rdx, %rax
               	shrq	$0x10, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	addq	%rax, %r8
               	pushq	%rcx
               	movq	%rax, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movq	%rdx, %rax
               	shrq	$0x8, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %r8
               	pushq	%rcx
               	movq	%rax, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movq	%rdx, %rax
               	shrq	$0x4, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x2, %rax
               	addq	%rax, %r8
               	pushq	%rcx
               	movq	%rax, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movq	%rdx, %rax
               	shrq	$0x2, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	addq	%rax, %r8
               	pushq	%rcx
               	movq	%rax, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	movq	%rdx, %rax
               	shrq	%rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	addq	%rax, %r8
               	movq	%r8, %rax
               	imulq	%rdi, %rax
               	movl	$0x40, %edx
               	subq	%rax, %rdx
               	andq	$0x3f, %rdx
               	movq	$-0x1, %rdi
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rdi
               	popq	%rcx
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	imulq	%rdi, %rdx
               	andq	%rsi, %rdx
               	testq	%rdx, %rdx
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%rax, %rdi
               	andq	$0x7f, %rdi
               	movq	%rax, %rdx
               	andq	$0x3f, %rdx
               	movl	$0x3f, %r8d
               	movq	%r8, %r13
               	subq	%rdx, %r13
               	movq	%rdi, %r8
               	shrq	$0x6, %r8
               	xorl	%edi, %edi
               	subq	%r8, %rdi
               	movq	%rdi, %r8
               	xorq	$-0x1, %r8
               	movq	%rcx, %r9
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %r9
               	popq	%rcx
               	movq	%rcx, %r11
               	movq	%r13, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	shlq	%rcx
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rsi
               	popq	%rcx
               	orq	%rsi, %rcx
               	andq	%r8, %rcx
               	movq	%r9, %rdx
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
               	movsd	-0x18(%rbp,%riz), %xmm1
               	mulsd	%xmm1, %xmm0
               	leaq	<rip>, %rax
               	movsd	(%rax,%riz), %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rbp,%riz)
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
