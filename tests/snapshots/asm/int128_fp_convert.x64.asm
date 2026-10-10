
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
               	leaq	<rip>, %rax      # <addr>
               	movq	%rdi, (%rax)
               	leaq	<rip>, %rdi      # <addr>
               	movq	%rsi, (%rdi)
               	movq	(%rax), %rax
               	movq	(%rdi), %rcx
               	movq	%rax, -0x10(%rbp)
               	xorl	%esi, %esi
               	movq	%rsi, -0x8(%rbp)
               	orq	%rsi, %rcx
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rax, %rsi
               	shrq	$0x20, %rsi
               	testl	%esi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	$0x5, %rsi
               	leaq	0x1(%rsi), %r13
               	shrxq	%rsi, %rax, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x10, %rdi
               	testq	%rdi, %rdi
               	setne	%dil
               	movzbq	%dil, %rdi
               	shlq	$0x4, %rdi
               	addq	%rdi, %r13
               	shrxq	%rdi, %rsi, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x8, %rdi
               	testq	%rdi, %rdi
               	setne	%dil
               	movzbq	%dil, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %r13
               	shrxq	%rdi, %rsi, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x4, %rdi
               	testq	%rdi, %rdi
               	setne	%dil
               	movzbq	%dil, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %r13
               	shrxq	%rdi, %rsi, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x2, %rdi
               	testq	%rdi, %rdi
               	setne	%dil
               	movzbq	%dil, %rdi
               	shlq	%rdi
               	addq	%rdi, %r13
               	shrxq	%rdi, %rsi, %rsi
               	shrq	%rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	addq	%r13, %rsi
               	imulq	%rdx, %rsi
               	movl	$0x40, %edx
               	subq	%rsi, %rdx
               	andq	$0x3f, %rdx
               	movq	$-0x1, %rdi
               	shrxq	%rdx, %rdi, %rdx
               	testq	%rsi, %rsi
               	setne	%dil
               	movzbq	%dil, %rdi
               	imulq	%rdi, %rdx
               	andq	%rcx, %rdx
               	testq	%rdx, %rdx
               	setne	%r13b
               	movzbq	%r13b, %r13
               	movq	%rsi, %rdx
               	andq	$0x7f, %rdx
               	movq	%rsi, %rdi
               	andq	$0x3f, %rdi
               	movl	$0x3f, %r14d
               	subq	%rdi, %r14
               	shrq	$0x6, %rdx
               	negq	%rdx
               	movq	%rdx, %r15
               	xorq	$-0x1, %r15
               	shrxq	%rdi, %rax, %r10
               	movq	%r10, 0x38(%rsp)
               	shlxq	%r14, %rax, %rax
               	shlq	%rax
               	shrxq	%rdi, %rcx, %rcx
               	orq	%rcx, %rax
               	andq	%r15, %rax
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
               	movl	0x10(%rbp), %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx      # <addr>
               	movq	(%rcx), %rcx
               	movq	%rax, -0x10(%rbp)
               	xorl	%edx, %edx
               	movq	%rdx, -0x8(%rbp)
               	movq	%rdx, %rdi
               	orq	%rcx, %rdi
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	shrq	$0x20, %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x5, %rdx
               	leaq	0x1(%rdx), %rbx
               	shrxq	%rdx, %rax, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x10, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %rbx
               	shrxq	%rsi, %rdx, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x8, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rbx
               	shrxq	%rsi, %rdx, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x4, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rbx
               	shrxq	%rsi, %rdx, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x2, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	%rsi
               	addq	%rsi, %rbx
               	shrxq	%rsi, %rdx, %rdx
               	shrq	%rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	addq	%rbx, %rdx
               	imulq	%rcx, %rdx
               	movl	$0x40, %ecx
               	subq	%rdx, %rcx
               	andq	$0x3f, %rcx
               	movq	$-0x1, %rsi
               	shrxq	%rcx, %rsi, %rcx
               	testq	%rdx, %rdx
               	setne	%sil
               	movzbq	%sil, %rsi
               	imulq	%rsi, %rcx
               	andq	%rdi, %rcx
               	testq	%rcx, %rcx
               	setne	%bl
               	movzbq	%bl, %rbx
               	movq	%rdx, %rcx
               	andq	$0x7f, %rcx
               	movq	%rdx, %rsi
               	andq	$0x3f, %rsi
               	movl	$0x3f, %r13d
               	subq	%rsi, %r13
               	shrq	$0x6, %rcx
               	negq	%rcx
               	movq	%rcx, %r14
               	xorq	$-0x1, %r14
               	shrxq	%rsi, %rax, %r15
               	shlxq	%r13, %rax, %rax
               	shlq	%rax
               	shrxq	%rsi, %rdi, %rsi
               	orq	%rsi, %rax
               	andq	%r14, %rax
               	andq	%r15, %rcx
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
               	movss	%xmm0, -0x10(%rbp)
               	movl	-0x10(%rbp), %eax
               	cmpl	%r12d, %eax
               	je	<addr>
               	movl	0x10(%rbp), %eax
               	incq	%rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rdx
               	movq	%rcx, -0x10(%rbp)
               	xorl	%eax, %eax
               	movq	%rax, -0x8(%rbp)
               	orq	%rax, %rdx
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
               	leaq	0x1(%rax), %r12
               	shrxq	%rax, %rcx, %rax
               	movq	%rax, %rdx
               	shrq	$0x10, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %r12
               	shrxq	%rdx, %rax, %rax
               	movq	%rax, %rdx
               	shrq	$0x8, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r12
               	shrxq	%rdx, %rax, %rax
               	movq	%rax, %rdx
               	shrq	$0x4, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r12
               	shrxq	%rdx, %rax, %rax
               	movq	%rax, %rdx
               	shrq	$0x2, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	addq	%rdx, %r12
               	shrxq	%rdx, %rax, %rax
               	shrq	%rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	addq	%r12, %rax
               	imulq	%rdi, %rax
               	movl	$0x40, %edx
               	subq	%rax, %rdx
               	andq	$0x3f, %rdx
               	movq	$-0x1, %rdi
               	shrxq	%rdx, %rdi, %rdx
               	testq	%rax, %rax
               	setne	%dil
               	movzbq	%dil, %rdi
               	imulq	%rdi, %rdx
               	andq	%rsi, %rdx
               	testq	%rdx, %rdx
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%rax, %rdi
               	andq	$0x7f, %rdi
               	movq	%rax, %rdx
               	andq	$0x3f, %rdx
               	movl	$0x3f, %r13d
               	subq	%rdx, %r13
               	shrq	$0x6, %rdi
               	negq	%rdi
               	movq	%rdi, %r14
               	xorq	$-0x1, %r14
               	shrxq	%rdx, %rcx, %r15
               	shlxq	%r13, %rcx, %rcx
               	shlq	%rcx
               	shrxq	%rdx, %rsi, %rdx
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
               	movl	0x10(%rbp), %eax
               	addq	$0x2, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rdx
               	movq	%rcx, -0x10(%rbp)
               	xorl	%eax, %eax
               	movq	%rax, -0x8(%rbp)
               	orq	%rax, %rdx
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
               	movabsq	$-0x8000000000000000, %r8 # imm = 0x8000000000000000
               	andq	%rax, %r8
               	testq	%rcx, %rcx
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rcx, %rax
               	shrq	$0x20, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x5, %rax
               	leaq	0x1(%rax), %rbx
               	shrxq	%rax, %rcx, %rax
               	movq	%rax, %rdx
               	shrq	$0x10, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %rbx
               	shrxq	%rdx, %rax, %rax
               	movq	%rax, %rdx
               	shrq	$0x8, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rbx
               	shrxq	%rdx, %rax, %rax
               	movq	%rax, %rdx
               	shrq	$0x4, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rbx
               	shrxq	%rdx, %rax, %rax
               	movq	%rax, %rdx
               	shrq	$0x2, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	addq	%rdx, %rbx
               	shrxq	%rdx, %rax, %rax
               	shrq	%rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	addq	%rbx, %rax
               	imulq	%rdi, %rax
               	movl	$0x40, %edx
               	subq	%rax, %rdx
               	andq	$0x3f, %rdx
               	movq	$-0x1, %rdi
               	shrxq	%rdx, %rdi, %rdx
               	testq	%rax, %rax
               	setne	%dil
               	movzbq	%dil, %rdi
               	imulq	%rdi, %rdx
               	andq	%rsi, %rdx
               	testq	%rdx, %rdx
               	setne	%bl
               	movzbq	%bl, %rbx
               	movq	%rax, %rdi
               	andq	$0x7f, %rdi
               	movq	%rax, %rdx
               	andq	$0x3f, %rdx
               	movl	$0x3f, %r12d
               	subq	%rdx, %r12
               	shrq	$0x6, %rdi
               	negq	%rdi
               	movq	%rdi, %r13
               	xorq	$-0x1, %r13
               	shrxq	%rdx, %rcx, %r14
               	shlxq	%r12, %rcx, %rcx
               	shlq	%rcx
               	shrxq	%rdx, %rsi, %rdx
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
               	movss	%xmm0, -0x10(%rbp)
               	movl	-0x10(%rbp), %eax
               	cmpl	%r9d, %eax
               	je	<addr>
               	movl	0x10(%rbp), %eax
               	addq	$0x3, %rax
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
               	movq	%rdx, %r13
               	movq	%rsi, %r12
               	leaq	<rip>, %rax      # <addr>
               	movsd	%xmm0, (%rax)
               	movsd	(%rax), %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, %r10
               	sarq	$0x3f, %r10
               	movq	%r10, 0x48(%rsp)
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rcx, %rax
               	shrq	$0x34, %rax
               	leaq	-0x3ff(%rax), %rdi
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$0x10000000000000, %r9  # imm = 0x10000000000000
               	orq	%rcx, %r9
               	subq	$0x433, %rax            # imm = 0x433
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	xorl	%eax, %eax
               	movq	%rdx, %rsi
               	andq	$0x7f, %rsi
               	andq	$0x3f, %rdx
               	movl	$0x3f, %r8d
               	movq	%r8, %r14
               	subq	%rdx, %r14
               	shrq	$0x6, %rsi
               	negq	%rsi
               	movq	%rsi, %r8
               	xorq	$-0x1, %r8
               	shlxq	%rdx, %r9, %r15
               	shrxq	%r14, %r9, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	shrq	%r10
               	movq	%r10, 0x40(%rsp)
               	shlxq	%rdx, %rax, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %r10
               	orq	0x40(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	%r15, %r10
               	andq	%r8, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x40(%rsp), %r10
               	andq	%r8, %r10
               	movq	%r10, 0x40(%rsp)
               	andq	%rsi, %r15
               	movq	0x40(%rsp), %r10
               	orq	%r15, %r10
               	movq	%r10, 0x40(%rsp)
               	shrxq	%rdx, %rax, %r15
               	shlxq	%r14, %rax, %rax
               	shlq	%rax
               	shrxq	%rdx, %r9, %rdx
               	orq	%rdx, %rax
               	andq	%r8, %rax
               	movq	%r15, %rdx
               	andq	%rsi, %rdx
               	orq	%rax, %rdx
               	movq	%r15, %rsi
               	andq	%r8, %rsi
               	movq	%rcx, %rax
               	xorq	$-0x1, %rax
               	movq	0x38(%rsp), %r8
               	andq	%rax, %r8
               	andq	%rcx, %rdx
               	orq	%r8, %rdx
               	movq	%rax, %r10
               	movq	0x40(%rsp), %rax
               	andq	%r10, %rax
               	andq	%rsi, %rcx
               	orq	%rax, %rcx
               	movq	%rdi, %rax
               	sarq	$0x3f, %rax
               	xorq	$-0x1, %rax
               	andq	%rax, %rdx
               	movq	%rcx, %rsi
               	andq	%rax, %rsi
               	cmpl	$0x80, %edi
               	setge	%al
               	movzbq	%al, %rax
               	movq	%rax, %rcx
               	negq	%rcx
               	movq	%rcx, %rax
               	xorq	$-0x1, %rax
               	andq	%rax, %rdx
               	orq	%rcx, %rdx
               	andq	%rsi, %rax
               	orq	%rax, %rcx
               	movq	0x48(%rsp), %rax
               	xorq	$-0x1, %rax
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
               	leaq	<rip>, %rax      # <addr>
               	movsd	(%rax), %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rdx
               	movq	%rdx, %rcx
               	sarq	$0x3f, %rcx
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rdx, %rax
               	movq	%rax, %rsi
               	shrq	$0x34, %rsi
               	leaq	-0x3ff(%rsi), %r14
               	movabsq	$0xfffffffffffff, %rax  # imm = 0xFFFFFFFFFFFFF
               	andq	%rdx, %rax
               	movabsq	$0x10000000000000, %r11 # imm = 0x10000000000000
               	orq	%r11, %rax
               	subq	$0x433, %rsi            # imm = 0x433
               	movq	%rsi, %rdx
               	sarq	$0x3f, %rdx
               	xorq	%rdx, %rsi
               	movq	%rsi, %rdi
               	subq	%rdx, %rdi
               	xorl	%esi, %esi
               	movq	%rdi, %r9
               	andq	$0x7f, %r9
               	movq	%rdi, %r8
               	andq	$0x3f, %r8
               	movl	$0x3f, %edi
               	movq	%rdi, %r15
               	subq	%r8, %r15
               	movq	%r9, %rdi
               	shrq	$0x6, %rdi
               	negq	%rdi
               	movq	%rdi, %r9
               	xorq	$-0x1, %r9
               	shlxq	%r8, %rax, %r10
               	movq	%r10, 0x48(%rsp)
               	shrxq	%r15, %rax, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	shrq	%r10
               	movq	%r10, 0x40(%rsp)
               	shlxq	%r8, %rsi, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %r10
               	orq	0x40(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x48(%rsp), %r10
               	andq	%r9, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x40(%rsp), %r10
               	andq	%r9, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x48(%rsp), %r10
               	andq	%rdi, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x40(%rsp), %r10
               	orq	0x48(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	shrxq	%r8, %rsi, %r10
               	movq	%r10, 0x48(%rsp)
               	shlxq	%r15, %rsi, %rsi
               	shlq	%rsi
               	shrxq	%r8, %rax, %rax
               	orq	%rsi, %rax
               	andq	%r9, %rax
               	movq	0x48(%rsp), %rsi
               	andq	%rdi, %rsi
               	orq	%rax, %rsi
               	movq	0x48(%rsp), %rdi
               	andq	%r9, %rdi
               	movq	%rdx, %rax
               	xorq	$-0x1, %rax
               	movq	0x38(%rsp), %r8
               	andq	%rax, %r8
               	andq	%rdx, %rsi
               	orq	%r8, %rsi
               	movq	%rax, %r10
               	movq	0x40(%rsp), %rax
               	andq	%r10, %rax
               	andq	%rdi, %rdx
               	orq	%rax, %rdx
               	movq	%r14, %rax
               	sarq	$0x3f, %rax
               	xorq	$-0x1, %rax
               	andq	%rax, %rsi
               	movq	%rdx, %rdi
               	andq	%rax, %rdi
               	cmpl	$0x80, %r14d
               	setge	%al
               	movzbq	%al, %rax
               	movq	%rax, %rdx
               	negq	%rdx
               	movq	%rsi, %rax
               	xorq	%rcx, %rax
               	movq	%rdi, %rsi
               	xorq	%rcx, %rsi
               	cmpq	%rcx, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	movq	%rax, %r8
               	subq	%rcx, %r8
               	movq	%rsi, %rax
               	subq	%rcx, %rax
               	movq	%rax, %rsi
               	subq	%rdi, %rsi
               	movq	%rcx, %rdi
               	xorq	$-0x1, %rdi
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	xorq	%r11, %rcx
               	movq	%rdx, %rax
               	xorq	$-0x1, %rax
               	andq	%rax, %r8
               	andq	%rdx, %rdi
               	orq	%r8, %rdi
               	andq	%rsi, %rax
               	andq	%rdx, %rcx
               	orq	%rcx, %rax
               	cmpq	%rbx, %rax
               	jne	<addr>
               	cmpq	%r12, %rdi
               	je	<addr>
               	leaq	0x1(%r13), %rax
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
               	movq	%rdx, 0x48(%rsp)
               	movq	%rsi, %r15
               	leaq	<rip>, %rcx      # <addr>
               	movsd	%xmm0, (%rcx)
               	movsd	(%rcx), %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rdx
               	movq	%rdx, %rcx
               	sarq	$0x3f, %rcx
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rdx, %rax
               	movq	%rax, %r8
               	shrq	$0x34, %r8
               	leaq	-0x3ff(%r8), %rbx
               	movabsq	$0xfffffffffffff, %rax  # imm = 0xFFFFFFFFFFFFF
               	andq	%rdx, %rax
               	movabsq	$0x10000000000000, %r11 # imm = 0x10000000000000
               	orq	%r11, %rax
               	subq	$0x433, %r8             # imm = 0x433
               	movq	%r8, %rdx
               	sarq	$0x3f, %rdx
               	movq	%r8, %rsi
               	xorq	%rdx, %rsi
               	movq	%rsi, %r8
               	subq	%rdx, %r8
               	xorl	%esi, %esi
               	movq	%r8, %rdi
               	andq	$0x7f, %rdi
               	andq	$0x3f, %r8
               	movl	$0x3f, %r9d
               	movq	%r9, %r12
               	subq	%r8, %r12
               	shrq	$0x6, %rdi
               	negq	%rdi
               	movq	%rdi, %r9
               	xorq	$-0x1, %r9
               	shlxq	%r8, %rax, %r13
               	shrxq	%r12, %rax, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	shrq	%r10
               	movq	%r10, 0x40(%rsp)
               	shlxq	%r8, %rsi, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %r10
               	orq	0x40(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	%r13, %r10
               	andq	%r9, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x40(%rsp), %r10
               	andq	%r9, %r10
               	movq	%r10, 0x40(%rsp)
               	andq	%rdi, %r13
               	movq	0x40(%rsp), %r10
               	orq	%r13, %r10
               	movq	%r10, 0x40(%rsp)
               	shrxq	%r8, %rsi, %r13
               	shlxq	%r12, %rsi, %rsi
               	shlq	%rsi
               	shrxq	%r8, %rax, %rax
               	orq	%rsi, %rax
               	andq	%r9, %rax
               	movq	%r13, %rsi
               	andq	%rdi, %rsi
               	orq	%rsi, %rax
               	movq	%r13, %rsi
               	andq	%r9, %rsi
               	movq	%rdx, %r8
               	xorq	$-0x1, %r8
               	movq	0x38(%rsp), %rdi
               	andq	%r8, %rdi
               	andq	%rdx, %rax
               	orq	%rdi, %rax
               	movq	0x40(%rsp), %rdi
               	andq	%r8, %rdi
               	andq	%rsi, %rdx
               	movq	%rdi, %rsi
               	orq	%rdx, %rsi
               	movq	%rbx, %rdx
               	sarq	$0x3f, %rdx
               	xorq	$-0x1, %rdx
               	andq	%rdx, %rax
               	andq	%rdx, %rsi
               	cmpl	$0x80, %ebx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movq	%rax, %r8
               	xorq	%rcx, %r8
               	movq	%rsi, %rax
               	xorq	%rcx, %rax
               	cmpq	%rcx, %r8
               	setb	%sil
               	movzbq	%sil, %rsi
               	movq	%r8, %rdi
               	subq	%rcx, %rdi
               	subq	%rcx, %rax
               	subq	%rsi, %rax
               	movq	%rcx, %rsi
               	xorq	$-0x1, %rsi
               	movabsq	$0x7fffffffffffffff, %r8 # imm = 0x7FFFFFFFFFFFFFFF
               	xorq	%rcx, %r8
               	movq	%rdx, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rdi
               	andq	%rdx, %rsi
               	orq	%rdi, %rsi
               	andq	%rcx, %rax
               	movq	%r8, %rcx
               	andq	%rdx, %rcx
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
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
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
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
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
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
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
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
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
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
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
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
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
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
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
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
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
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
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
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
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
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
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
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
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
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
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
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
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
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
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
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
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
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
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
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
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
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
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
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
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
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
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
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
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
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
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
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
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
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
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
               	leaq	-0x3ff(%rcx), %rdx
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$0x10000000000000, %rsi # imm = 0x10000000000000
               	orq	%rax, %rsi
               	subq	$0x433, %rcx            # imm = 0x433
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	xorq	%rax, %rcx
               	subq	%rax, %rcx
               	xorl	%edi, %edi
               	movq	%rcx, %r8
               	andq	$0x7f, %r8
               	andq	$0x3f, %rcx
               	movl	$0x3f, %r9d
               	movq	%r9, %r12
               	subq	%rcx, %r12
               	shrq	$0x6, %r8
               	negq	%r8
               	movq	%r8, %r9
               	xorq	$-0x1, %r9
               	shlxq	%rcx, %rsi, %r13
               	andq	%r9, %r13
               	shrxq	%rcx, %rdi, %r14
               	shlxq	%r12, %rdi, %rdi
               	shlq	%rdi
               	shrxq	%rcx, %rsi, %rcx
               	orq	%rdi, %rcx
               	andq	%r9, %rcx
               	movq	%r14, %rsi
               	andq	%r8, %rsi
               	orq	%rsi, %rcx
               	movq	%rax, %rsi
               	xorq	$-0x1, %rsi
               	andq	%r13, %rsi
               	andq	%rcx, %rax
               	orq	%rsi, %rax
               	movq	%rdx, %rcx
               	sarq	$0x3f, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rax, %rcx
               	cmpl	$0x80, %edx
               	setge	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movq	%rax, %rdx
               	xorq	$-0x1, %rdx
               	andq	%rdx, %rcx
               	orq	%rcx, %rax
               	movq	%rbx, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rax
               	cmpq	$0x2, %rax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movss	(%rax), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %rbx
               	sarq	$0x3f, %rbx
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rax, %rcx
               	shrq	$0x34, %rcx
               	leaq	-0x3ff(%rcx), %rdx
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$0x10000000000000, %rsi # imm = 0x10000000000000
               	orq	%rax, %rsi
               	subq	$0x433, %rcx            # imm = 0x433
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	xorq	%rax, %rcx
               	subq	%rax, %rcx
               	xorl	%edi, %edi
               	movq	%rcx, %r8
               	andq	$0x7f, %r8
               	andq	$0x3f, %rcx
               	movl	$0x3f, %r9d
               	movq	%r9, %r12
               	subq	%rcx, %r12
               	shrq	$0x6, %r8
               	negq	%r8
               	movq	%r8, %r9
               	xorq	$-0x1, %r9
               	shlxq	%rcx, %rsi, %r13
               	shrxq	%r12, %rsi, %rsi
               	shrq	%rsi
               	shlxq	%rcx, %rdi, %r12
               	orq	%r12, %rsi
               	andq	%r9, %rsi
               	andq	%r13, %r8
               	orq	%r8, %rsi
               	shrxq	%rcx, %rdi, %rcx
               	andq	%r9, %rcx
               	movq	%rax, %rdi
               	xorq	$-0x1, %rdi
               	andq	%rdi, %rsi
               	andq	%rcx, %rax
               	orq	%rsi, %rax
               	movq	%rdx, %rcx
               	sarq	$0x3f, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rax, %rcx
               	cmpl	$0x80, %edx
               	setge	%al
               	movzbq	%al, %rax
               	negq	%rax
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
               	leaq	<rip>, %rax      # <addr>
               	movl	$0xc0600000, (%rax)     # imm = 0xC0600000
               	movss	(%rax), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %rdx
               	sarq	$0x3f, %rdx
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
               	xorl	%r8d, %r8d
               	movq	%rcx, %r9
               	andq	$0x7f, %r9
               	andq	$0x3f, %rcx
               	movl	$0x3f, %ebx
               	movq	%rbx, %r12
               	subq	%rcx, %r12
               	shrq	$0x6, %r9
               	negq	%r9
               	movq	%r9, %rbx
               	xorq	$-0x1, %rbx
               	shlxq	%rcx, %rdi, %r13
               	andq	%rbx, %r13
               	shrxq	%rcx, %r8, %r14
               	shlxq	%r12, %r8, %r8
               	shlq	%r8
               	shrxq	%rcx, %rdi, %rcx
               	orq	%r8, %rcx
               	andq	%rbx, %rcx
               	movq	%r14, %rdi
               	andq	%r9, %rdi
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
               	setge	%al
               	movzbq	%al, %rax
               	negq	%rax
               	xorq	%rdx, %rcx
               	subq	%rdx, %rcx
               	xorq	$-0x1, %rdx
               	movq	%rax, %rsi
               	xorq	$-0x1, %rsi
               	andq	%rsi, %rcx
               	andq	%rdx, %rax
               	orq	%rcx, %rax
               	cmpq	$-0x3, %rax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
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
               	movabsq	$0x10000000000000, %rdi # imm = 0x10000000000000
               	orq	%rcx, %rdi
               	subq	$0x433, %rdx            # imm = 0x433
               	movq	%rdx, %rcx
               	sarq	$0x3f, %rcx
               	xorq	%rcx, %rdx
               	subq	%rcx, %rdx
               	xorl	%r8d, %r8d
               	movq	%rdx, %rsi
               	andq	$0x7f, %rsi
               	andq	$0x3f, %rdx
               	movl	$0x3f, %r9d
               	movq	%r9, %r12
               	subq	%rdx, %r12
               	shrq	$0x6, %rsi
               	movq	%rsi, %r9
               	negq	%r9
               	movq	%r9, %rsi
               	xorq	$-0x1, %rsi
               	shlxq	%rdx, %rdi, %r13
               	shrxq	%r12, %rdi, %r14
               	shrq	%r14
               	shlxq	%rdx, %r8, %r15
               	orq	%r15, %r14
               	movq	%r13, %r15
               	andq	%rsi, %r15
               	andq	%rsi, %r14
               	andq	%r9, %r13
               	orq	%r13, %r14
               	shrxq	%rdx, %r8, %r13
               	shlxq	%r12, %r8, %r8
               	shlq	%r8
               	shrxq	%rdx, %rdi, %rdx
               	orq	%r8, %rdx
               	andq	%rsi, %rdx
               	movq	%r13, %rdi
               	andq	%r9, %rdi
               	orq	%rdx, %rdi
               	andq	%r13, %rsi
               	movq	%rcx, %rdx
               	xorq	$-0x1, %rdx
               	movq	%r15, %r8
               	andq	%rdx, %r8
               	andq	%rcx, %rdi
               	orq	%r8, %rdi
               	andq	%r14, %rdx
               	andq	%rsi, %rcx
               	orq	%rcx, %rdx
               	movq	%rbx, %rcx
               	sarq	$0x3f, %rcx
               	xorq	$-0x1, %rcx
               	movq	%rdi, %rsi
               	andq	%rcx, %rsi
               	andq	%rcx, %rdx
               	cmpl	$0x80, %ebx
               	setge	%cl
               	movzbq	%cl, %rcx
               	negq	%rcx
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
               	leaq	<rip>, %rax      # <addr>
               	xorl	%edx, %edx
               	movq	%rdx, (%rax)
               	leaq	<rip>, %rcx      # <addr>
               	movabsq	$0x10000000000000, %rsi # imm = 0x10000000000000
               	movq	%rsi, (%rcx)
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
               	shrxq	%rcx, %rax, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x10, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %r9
               	shrxq	%rsi, %rcx, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x8, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %r9
               	shrxq	%rsi, %rcx, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x4, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %r9
               	shrxq	%rsi, %rcx, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x2, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	%rsi
               	addq	%rsi, %r9
               	shrxq	%rsi, %rcx, %rcx
               	shrq	%rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	addq	%r9, %rcx
               	imulq	%r8, %rcx
               	movl	$0x40, %esi
               	subq	%rcx, %rsi
               	andq	$0x3f, %rsi
               	movq	$-0x1, %r8
               	shrxq	%rsi, %r8, %rsi
               	testq	%rcx, %rcx
               	setne	%r9b
               	movzbq	%r9b, %r9
               	imulq	%r9, %rsi
               	andq	%rdi, %rsi
               	testq	%rsi, %rsi
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%rcx, %rbx
               	andq	$0x7f, %rbx
               	movq	%rcx, %rsi
               	andq	$0x3f, %rsi
               	movl	$0x3f, %r9d
               	movq	%r9, %r13
               	subq	%rsi, %r13
               	shrq	$0x6, %rbx
               	negq	%rbx
               	movq	%rbx, %r14
               	xorq	$-0x1, %r14
               	shrxq	%rsi, %rax, %r15
               	shlxq	%r13, %rax, %rax
               	shlq	%rax
               	shrxq	%rsi, %rdi, %rsi
               	orq	%rsi, %rax
               	andq	%r14, %rax
               	movq	%r15, %rsi
               	andq	%rbx, %rsi
               	orq	%rsi, %rax
               	orq	%r12, %rax
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
               	leaq	0x3ff(%rcx), %rax
               	shlq	$0x34, %rax
               	movq	%rax, -0x8(%rbp)
               	movsd	-0x8(%rbp), %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %r12
               	sarq	$0x3f, %r12
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
               	movq	%rcx, %rbx
               	andq	$0x7f, %rbx
               	andq	$0x3f, %rcx
               	movq	%r9, %r13
               	subq	%rcx, %r13
               	movq	%rbx, %r9
               	shrq	$0x6, %r9
               	negq	%r9
               	movq	%r9, %rbx
               	xorq	$-0x1, %rbx
               	shlxq	%rcx, %rdi, %r14
               	andq	%rbx, %r14
               	shrxq	%rcx, %rdx, %r15
               	shlxq	%r13, %rdx, %rdx
               	shlq	%rdx
               	shrxq	%rcx, %rdi, %rcx
               	orq	%rdx, %rcx
               	andq	%rbx, %rcx
               	movq	%r15, %rdx
               	andq	%r9, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	xorq	$-0x1, %rdx
               	andq	%r14, %rdx
               	andq	%rcx, %rax
               	orq	%rdx, %rax
               	movq	%rsi, %rcx
               	sarq	$0x3f, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rax, %rcx
               	cmpl	$0x80, %esi
               	setge	%al
               	movzbq	%al, %rax
               	negq	%rax
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
               	leaq	<rip>, %rax      # <addr>
               	movq	$0x5, (%rax)
               	leaq	<rip>, %rcx      # <addr>
               	xorl	%edx, %edx
               	movq	%rdx, (%rcx)
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
               	shrxq	%rcx, %rax, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x10, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %r9
               	shrxq	%rsi, %rcx, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x8, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %r9
               	shrxq	%rsi, %rcx, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x4, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %r9
               	shrxq	%rsi, %rcx, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x2, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	%rsi
               	addq	%rsi, %r9
               	shrxq	%rsi, %rcx, %rcx
               	shrq	%rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	addq	%r9, %rcx
               	imulq	%r8, %rcx
               	movl	$0x40, %esi
               	subq	%rcx, %rsi
               	andq	$0x3f, %rsi
               	movq	$-0x1, %r8
               	shrxq	%rsi, %r8, %rsi
               	testq	%rcx, %rcx
               	setne	%r9b
               	movzbq	%r9b, %r9
               	imulq	%r9, %rsi
               	andq	%rdi, %rsi
               	testq	%rsi, %rsi
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%rcx, %rbx
               	andq	$0x7f, %rbx
               	movq	%rcx, %rsi
               	andq	$0x3f, %rsi
               	movl	$0x3f, %r9d
               	movq	%r9, %r13
               	subq	%rsi, %r13
               	shrq	$0x6, %rbx
               	negq	%rbx
               	movq	%rbx, %r14
               	xorq	$-0x1, %r14
               	shrxq	%rsi, %rax, %r15
               	shlxq	%r13, %rax, %rax
               	shlq	%rax
               	shrxq	%rsi, %rdi, %rsi
               	orq	%rsi, %rax
               	andq	%r14, %rax
               	movq	%r15, %rsi
               	andq	%rbx, %rsi
               	orq	%rsi, %rax
               	orq	%r12, %rax
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
               	leaq	0x3ff(%rcx), %rax
               	shlq	$0x34, %rax
               	movq	%rax, -0x8(%rbp)
               	movsd	-0x8(%rbp), %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %r12
               	sarq	$0x3f, %r12
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
               	movq	%rcx, %rbx
               	andq	$0x7f, %rbx
               	andq	$0x3f, %rcx
               	movq	%r9, %r13
               	subq	%rcx, %r13
               	movq	%rbx, %r9
               	shrq	$0x6, %r9
               	negq	%r9
               	movq	%r9, %rbx
               	xorq	$-0x1, %rbx
               	shlxq	%rcx, %rdi, %r14
               	shrxq	%r13, %rdi, %rdi
               	shrq	%rdi
               	shlxq	%rcx, %rdx, %r13
               	orq	%r13, %rdi
               	andq	%rbx, %rdi
               	andq	%r14, %r9
               	orq	%r9, %rdi
               	shrxq	%rcx, %rdx, %rcx
               	andq	%rbx, %rcx
               	movq	%rax, %rdx
               	xorq	$-0x1, %rdx
               	andq	%rdi, %rdx
               	andq	%rcx, %rax
               	orq	%rdx, %rax
               	movq	%rsi, %rcx
               	sarq	$0x3f, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rax, %rcx
               	cmpl	$0x80, %esi
               	setge	%al
               	movzbq	%al, %rax
               	negq	%rax
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
               	leaq	<rip>, %rax      # <addr>
               	movq	$0x0, (%rax)
               	leaq	<rip>, %rcx      # <addr>
               	movq	$0x3, (%rcx)
               	leaq	<rip>, %rdx      # <addr>
               	movabsq	$0x3ff8000000000000, %rsi # imm = 0x3FF8000000000000
               	movq	%rsi, %xmm14
               	movsd	%xmm14, (%rdx)
               	movq	(%rax), %rax
               	movq	(%rcx), %rsi
               	testq	%rax, %rax
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x5, %rcx
               	leaq	0x1(%rcx), %r8
               	shrxq	%rcx, %rax, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x10, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %r8
               	shrxq	%rdx, %rcx, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x8, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	shrxq	%rdx, %rcx, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x4, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r8
               	shrxq	%rdx, %rcx, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x2, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	addq	%rdx, %r8
               	shrxq	%rdx, %rcx, %rcx
               	shrq	%rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	addq	%r8, %rcx
               	imulq	%rdi, %rcx
               	movl	$0x40, %edx
               	subq	%rcx, %rdx
               	andq	$0x3f, %rdx
               	movq	$-0x1, %rdi
               	shrxq	%rdx, %rdi, %rdx
               	testq	%rcx, %rcx
               	setne	%dil
               	movzbq	%dil, %rdi
               	imulq	%rdi, %rdx
               	andq	%rsi, %rdx
               	testq	%rdx, %rdx
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%rcx, %rdi
               	andq	$0x7f, %rdi
               	movq	%rcx, %rdx
               	andq	$0x3f, %rdx
               	movl	$0x3f, %r9d
               	subq	%rdx, %r9
               	shrq	$0x6, %rdi
               	negq	%rdi
               	movq	%rdi, %rbx
               	xorq	$-0x1, %rbx
               	shrxq	%rdx, %rax, %r12
               	shlxq	%r9, %rax, %rax
               	shlq	%rax
               	shrxq	%rdx, %rsi, %rdx
               	orq	%rdx, %rax
               	andq	%rbx, %rax
               	movq	%r12, %rdx
               	andq	%rdi, %rdx
               	orq	%rdx, %rax
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
               	leaq	0x3ff(%rcx), %rax
               	shlq	$0x34, %rax
               	movq	%rax, -0x8(%rbp)
               	movsd	-0x8(%rbp), %xmm1
               	leaq	<rip>, %rax      # <addr>
               	movsd	(%rax), %xmm2
               	vfmadd213sd	%xmm2, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm2
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
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax      # <addr>
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
               	subq	%rdi, %rcx
               	movabsq	$-0x8000000000000000, %r8 # imm = 0x8000000000000000
               	andq	%rax, %r8
               	testq	%rcx, %rcx
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rcx, %rax
               	shrq	$0x20, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x5, %rax
               	leaq	0x1(%rax), %r9
               	shrxq	%rax, %rcx, %rax
               	movq	%rax, %rdx
               	shrq	$0x10, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %r9
               	shrxq	%rdx, %rax, %rax
               	movq	%rax, %rdx
               	shrq	$0x8, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r9
               	shrxq	%rdx, %rax, %rax
               	movq	%rax, %rdx
               	shrq	$0x4, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r9
               	shrxq	%rdx, %rax, %rax
               	movq	%rax, %rdx
               	shrq	$0x2, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	%rdx
               	addq	%rdx, %r9
               	shrxq	%rdx, %rax, %rax
               	shrq	%rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	addq	%r9, %rax
               	imulq	%rdi, %rax
               	movl	$0x40, %edx
               	subq	%rax, %rdx
               	andq	$0x3f, %rdx
               	movq	$-0x1, %rdi
               	shrxq	%rdx, %rdi, %rdx
               	testq	%rax, %rax
               	setne	%dil
               	movzbq	%dil, %rdi
               	imulq	%rdi, %rdx
               	andq	%rsi, %rdx
               	testq	%rdx, %rdx
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%rax, %rdi
               	andq	$0x7f, %rdi
               	movq	%rax, %rdx
               	andq	$0x3f, %rdx
               	movl	$0x3f, %ebx
               	subq	%rdx, %rbx
               	shrq	$0x6, %rdi
               	negq	%rdi
               	movq	%rdi, %r12
               	xorq	$-0x1, %r12
               	shrxq	%rdx, %rcx, %r13
               	shlxq	%rbx, %rcx, %rcx
               	shlq	%rcx
               	shrxq	%rdx, %rsi, %rdx
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
               	leaq	<rip>, %rax      # <addr>
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
