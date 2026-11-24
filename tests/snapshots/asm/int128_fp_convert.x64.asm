
int128_fp_convert.x64:	file format elf64-x86-64

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

<chk_to_fp>:
               	subq	$0x40, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdx, %rbx
               	movq	%r9, 0x28(%rsp)
               	movq	%r8, 0x30(%rsp)
               	movq	%rcx, 0x38(%rsp)
               	movq	%rdi, <rip> # <addr>
               	movq	%rsi, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rax, %rsi
               	shrq	$0x20, %rsi
               	testl	%esi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	$0x5, %rsi
               	leaq	0x1(%rsi), %r8
               	shrxq	%rsi, %rax, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x10, %rdi
               	testq	%rdi, %rdi
               	setne	%dil
               	movzbq	%dil, %rdi
               	shlq	$0x4, %rdi
               	addq	%rdi, %r8
               	shrxq	%rdi, %rsi, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x8, %rdi
               	testq	%rdi, %rdi
               	setne	%dil
               	movzbq	%dil, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %r8
               	shrxq	%rdi, %rsi, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x4, %rdi
               	testq	%rdi, %rdi
               	setne	%dil
               	movzbq	%dil, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %r8
               	shrxq	%rdi, %rsi, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x2, %rdi
               	testq	%rdi, %rdi
               	setne	%dil
               	movzbq	%dil, %rdi
               	shlq	%rdi
               	addq	%rdi, %r8
               	shrxq	%rdi, %rsi, %rsi
               	shrq	%rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	addq	%r8, %rsi
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
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%rsi, %rdx
               	andq	$0x7f, %rdx
               	movq	%rsi, %rdi
               	andq	$0x3f, %rdi
               	movl	$0x3f, %r9d
               	subq	%rdi, %r9
               	shrq	$0x6, %rdx
               	negq	%rdx
               	movq	%rdx, %r12
               	xorq	$-0x1, %r12
               	shrxq	%rdi, %rax, %r13
               	shlxq	%r9, %rax, %rax
               	shlq	%rax
               	shrxq	%rdi, %rcx, %rdi
               	orq	%rdi, %rax
               	andq	%r12, %rax
               	andq	%r13, %rdx
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
               	leaq	0x3ff(%rsi), %rax
               	shlq	$0x34, %rax
               	movq	%rax, %xmm1
               	mulsd	%xmm1, %xmm0
               	movq	%xmm0, %rax
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	0x60(%rsp), %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x40, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rdi # <addr>
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	shrq	$0x20, %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	shlq	$0x5, %rdx
               	leaq	0x1(%rdx), %r8
               	shrxq	%rdx, %rax, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x10, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %r8
               	shrxq	%rsi, %rdx, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x8, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %r8
               	shrxq	%rsi, %rdx, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x4, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %r8
               	shrxq	%rsi, %rdx, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x2, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	shlq	%rsi
               	addq	%rsi, %r8
               	shrxq	%rsi, %rdx, %rdx
               	shrq	%rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	addq	%r8, %rdx
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
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%rdx, %rcx
               	andq	$0x7f, %rcx
               	movq	%rdx, %rsi
               	andq	$0x3f, %rsi
               	movl	$0x3f, %r9d
               	subq	%rsi, %r9
               	shrq	$0x6, %rcx
               	negq	%rcx
               	movq	%rcx, %rbx
               	xorq	$-0x1, %rbx
               	shrxq	%rsi, %rax, %r12
               	shlxq	%r9, %rax, %rax
               	shlq	%rax
               	shrxq	%rsi, %rdi, %rsi
               	orq	%rsi, %rax
               	andq	%rbx, %rax
               	andq	%r12, %rcx
               	orq	%rcx, %rax
               	orq	%r8, %rax
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
               	movq	%rax, %xmm1
               	mulsd	%xmm1, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movss	%xmm0, 0x48(%rsp)
               	movl	0x48(%rsp), %eax
               	cmpl	0x38(%rsp), %eax
               	je	<addr>
               	movl	0x60(%rsp), %eax
               	incq	%rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x40, %rsp
               	retq
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
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
               	andq	%r13, %rdi
               	orq	%rdi, %rcx
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
               	movq	%rax, %xmm1
               	mulsd	%xmm1, %xmm0
               	movq	%xmm0, %rax
               	cmpq	0x30(%rsp), %rax
               	je	<addr>
               	movl	0x60(%rsp), %eax
               	addq	$0x2, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x40, %rsp
               	retq
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
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
               	andq	%r13, %rdi
               	orq	%rdi, %rcx
               	orq	%r9, %rcx
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
               	movq	%rax, %xmm1
               	mulsd	%xmm1, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movss	%xmm0, 0x48(%rsp)
               	movl	0x48(%rsp), %eax
               	cmpl	0x28(%rsp), %eax
               	je	<addr>
               	movl	0x60(%rsp), %eax
               	addq	$0x3, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x40, %rsp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x40, %rsp
               	retq

<chk_from_fp>:
               	subq	$0x30, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r13
               	movq	%rdx, 0x38(%rsp)
               	movq	%rsi, 0x40(%rsp)
               	movsd	%xmm0, <rip> # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movq	%xmm0, %rcx
               	movq	%rcx, %r14
               	sarq	$0x3f, %r14
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rcx, %rdx
               	shrq	$0x34, %rdx
               	leaq	-0x3ff(%rdx), %rdi
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$0x10000000000000, %r9  # imm = 0x10000000000000
               	orq	%rcx, %r9
               	subq	$0x433, %rdx            # imm = 0x433
               	movq	%rdx, %rcx
               	sarq	$0x3f, %rcx
               	xorq	%rcx, %rdx
               	subq	%rcx, %rdx
               	xorl	%eax, %eax
               	movq	%rdx, %r8
               	andq	$0x7f, %r8
               	andq	$0x3f, %rdx
               	movl	$0x3f, %ebx
               	subq	%rdx, %rbx
               	shrq	$0x6, %r8
               	movq	%r8, %rsi
               	negq	%rsi
               	movq	%rsi, %r8
               	xorq	$-0x1, %r8
               	shlxq	%rdx, %r9, %r12
               	shrxq	%rbx, %r9, %r15
               	shrq	%r15
               	shlxq	%rdx, %rax, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%r15, %r10
               	movq	0x48(%rsp), %r15
               	orq	%r10, %r15
               	movq	%r12, %r10
               	andq	%r8, %r10
               	movq	%r10, 0x48(%rsp)
               	andq	%r8, %r15
               	andq	%rsi, %r12
               	orq	%r12, %r15
               	shrxq	%rdx, %rax, %r12
               	shlxq	%rbx, %rax, %rax
               	shlq	%rax
               	shrxq	%rdx, %r9, %rdx
               	orq	%rax, %rdx
               	andq	%r8, %rdx
               	movq	%r12, %r9
               	andq	%rsi, %r9
               	orq	%rdx, %r9
               	andq	%r12, %r8
               	movq	%rcx, %rdx
               	xorq	$-0x1, %rdx
               	movq	0x48(%rsp), %rax
               	andq	%rdx, %rax
               	andq	%rcx, %r9
               	orq	%rax, %r9
               	andq	%r15, %rdx
               	andq	%r8, %rcx
               	orq	%rcx, %rdx
               	movq	%rdi, %rcx
               	sarq	$0x3f, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %r9
               	movq	%rdx, %r8
               	andq	%rcx, %r8
               	cmpl	$0x80, %edi
               	setge	%cl
               	movzbq	%cl, %rcx
               	negq	%rcx
               	movq	%rcx, %rdx
               	xorq	$-0x1, %rdx
               	andq	%rdx, %r9
               	orq	%rcx, %r9
               	andq	%r8, %rdx
               	orq	%rcx, %rdx
               	movq	%r14, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %r9
               	andq	%rdx, %rcx
               	cmpq	%r13, %rcx
               	jne	<addr>
               	cmpq	0x40(%rsp), %r9
               	je	<addr>
               	movq	0x38(%rsp), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x30, %rsp
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	movq	%xmm0, %rdx
               	movq	%rdx, %rcx
               	sarq	$0x3f, %rcx
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rdx, %rax
               	shrq	$0x34, %rax
               	leaq	-0x3ff(%rax), %rbx
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rdx
               	movabsq	$0x10000000000000, %rdi # imm = 0x10000000000000
               	orq	%rdx, %rdi
               	subq	$0x433, %rax            # imm = 0x433
               	movq	%rax, %rdx
               	sarq	$0x3f, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, %r8
               	subq	%rdx, %r8
               	xorl	%eax, %eax
               	movq	%r8, %rsi
               	andq	$0x7f, %rsi
               	andq	$0x3f, %r8
               	movl	$0x3f, %r12d
               	subq	%r8, %r12
               	shrq	$0x6, %rsi
               	negq	%rsi
               	movq	%rsi, %r9
               	xorq	$-0x1, %r9
               	shlxq	%r8, %rdi, %r14
               	shrxq	%r12, %rdi, %r15
               	shrq	%r15
               	shlxq	%r8, %rax, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%r15, %r10
               	movq	0x48(%rsp), %r15
               	orq	%r10, %r15
               	movq	%r14, %r10
               	andq	%r9, %r10
               	movq	%r10, 0x48(%rsp)
               	andq	%r9, %r15
               	andq	%rsi, %r14
               	orq	%r14, %r15
               	shrxq	%r8, %rax, %r14
               	shlxq	%r12, %rax, %rax
               	shlq	%rax
               	shrxq	%r8, %rdi, %rdi
               	orq	%rdi, %rax
               	andq	%r9, %rax
               	andq	%r14, %rsi
               	orq	%rax, %rsi
               	andq	%r14, %r9
               	movq	%rdx, %rax
               	xorq	$-0x1, %rax
               	movq	0x48(%rsp), %rdi
               	andq	%rax, %rdi
               	andq	%rdx, %rsi
               	orq	%rdi, %rsi
               	andq	%r15, %rax
               	andq	%r9, %rdx
               	orq	%rax, %rdx
               	movq	%rbx, %rax
               	sarq	$0x3f, %rax
               	xorq	$-0x1, %rax
               	andq	%rax, %rsi
               	movq	%rdx, %rdi
               	andq	%rax, %rdi
               	cmpl	$0x80, %ebx
               	setge	%al
               	movzbq	%al, %rax
               	movq	%rax, %rdx
               	negq	%rdx
               	movq	%rsi, %rax
               	xorq	%rcx, %rax
               	xorq	%rcx, %rdi
               	cmpq	%rcx, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	movq	%rax, %r8
               	subq	%rcx, %r8
               	subq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movq	%rcx, %rsi
               	xorq	$-0x1, %rsi
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	xorq	%r11, %rcx
               	movq	%rdx, %rax
               	xorq	$-0x1, %rax
               	andq	%rax, %r8
               	andq	%rdx, %rsi
               	orq	%r8, %rsi
               	andq	%rdi, %rax
               	andq	%rdx, %rcx
               	orq	%rcx, %rax
               	cmpq	%r13, %rax
               	jne	<addr>
               	cmpq	0x40(%rsp), %rsi
               	je	<addr>
               	movq	0x38(%rsp), %rax
               	incq	%rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x30, %rsp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x30, %rsp
               	retq

<chk_from_fp_neg>:
               	subq	$0x40, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, 0x48(%rsp)
               	movq	%rdx, 0x28(%rsp)
               	movq	%rsi, 0x30(%rsp)
               	movsd	%xmm0, <rip> # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movq	%xmm0, %rdx
               	movq	%rdx, %rcx
               	sarq	$0x3f, %rcx
               	movabsq	$0x7fffffffffffffff, %r8 # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rdx, %r8
               	shrq	$0x34, %r8
               	leaq	-0x3ff(%r8), %rbx
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rdx
               	movabsq	$0x10000000000000, %rax # imm = 0x10000000000000
               	orq	%rdx, %rax
               	subq	$0x433, %r8             # imm = 0x433
               	movq	%r8, %rdx
               	sarq	$0x3f, %rdx
               	xorq	%rdx, %r8
               	subq	%rdx, %r8
               	xorl	%esi, %esi
               	movq	%r8, %rdi
               	andq	$0x7f, %rdi
               	andq	$0x3f, %r8
               	movl	$0x3f, %r12d
               	subq	%r8, %r12
               	shrq	$0x6, %rdi
               	negq	%rdi
               	movq	%rdi, %r9
               	xorq	$-0x1, %r9
               	shlxq	%r8, %rax, %r13
               	shrxq	%r12, %rax, %r10
               	movq	%r10, 0x40(%rsp)
               	shrq	%r10
               	movq	%r10, 0x40(%rsp)
               	shlxq	%r8, %rsi, %r10
               	movq	%r10, 0x38(%rsp)
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
               	shrxq	%r8, %rax, %r8
               	orq	%rsi, %r8
               	andq	%r9, %r8
               	andq	%r13, %rdi
               	orq	%r8, %rdi
               	andq	%r13, %r9
               	movq	%rdx, %r8
               	xorq	$-0x1, %r8
               	movq	0x38(%rsp), %rax
               	andq	%r8, %rax
               	andq	%rdx, %rdi
               	orq	%rax, %rdi
               	movq	%r8, %r10
               	movq	0x40(%rsp), %r8
               	andq	%r10, %r8
               	andq	%r9, %rdx
               	orq	%rdx, %r8
               	movq	%rbx, %rdx
               	sarq	$0x3f, %rdx
               	xorq	$-0x1, %rdx
               	andq	%rdx, %rdi
               	movq	%r8, %r9
               	andq	%rdx, %r9
               	cmpl	$0x80, %ebx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movq	%rdi, %r8
               	xorq	%rcx, %r8
               	xorq	%rcx, %r9
               	cmpq	%rcx, %r8
               	setb	%dil
               	movzbq	%dil, %rdi
               	subq	%rcx, %r8
               	subq	%rcx, %r9
               	subq	%rdi, %r9
               	movq	%rcx, %rdi
               	xorq	$-0x1, %rdi
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	xorq	%rcx, %rax
               	movq	%rdx, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %r8
               	andq	%rdx, %rdi
               	orq	%r8, %rdi
               	andq	%r9, %rcx
               	andq	%rax, %rdx
               	orq	%rdx, %rcx
               	cmpq	0x48(%rsp), %rcx
               	jne	<addr>
               	cmpq	0x30(%rsp), %rdi
               	je	<addr>
               	movq	0x28(%rsp), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x40, %rsp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x40, %rsp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	xorl	%edi, %edi
               	subq	$0x10, %rsp
               	movq	$0x1, (%rsp)
               	movq	%rdi, %rsi
               	movq	%rdi, %r9
               	movq	%rdi, %r8
               	movq	%rdi, %rcx
               	movq	%rdi, %rdx
               	callq	<addr>
               	addq	$0x10, %rsp
               	testl	%eax, %eax
               	je	<addr>
               	leave
               	retq
               	xorl	%edi, %edi
               	movl	$0x1, %esi
               	movabsq	$0x3ff0000000000000, %rdx # imm = 0x3FF0000000000000
               	movl	$0x3f800000, %ecx       # imm = 0x3F800000
               	subq	$0x10, %rsp
               	movq	$0x5, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testl	%eax, %eax
               	je	<addr>
               	leave
               	retq
               	xorl	%edi, %edi
               	movl	$0x5, %esi
               	movabsq	$0x4014000000000000, %rdx # imm = 0x4014000000000000
               	movl	$0x40a00000, %ecx       # imm = 0x40A00000
               	subq	$0x10, %rsp
               	movq	$0x9, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testl	%eax, %eax
               	je	<addr>
               	leave
               	retq
               	xorl	%edi, %edi
               	movabsq	$0x20000000000000, %rsi # imm = 0x20000000000000
               	movabsq	$0x4340000000000000, %rdx # imm = 0x4340000000000000
               	movl	$0x5a000000, %ecx       # imm = 0x5A000000
               	subq	$0x10, %rsp
               	movq	$0xd, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testl	%eax, %eax
               	je	<addr>
               	leave
               	retq
               	xorl	%edi, %edi
               	movabsq	$0x20000000000001, %rsi # imm = 0x20000000000001
               	movabsq	$0x4340000000000000, %rdx # imm = 0x4340000000000000
               	movl	$0x5a000000, %ecx       # imm = 0x5A000000
               	subq	$0x10, %rsp
               	movq	$0x11, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testl	%eax, %eax
               	je	<addr>
               	leave
               	retq
               	xorl	%edi, %edi
               	movabsq	$0x20000000000003, %rsi # imm = 0x20000000000003
               	movabsq	$0x4340000000000002, %rdx # imm = 0x4340000000000002
               	movl	$0x5a000000, %ecx       # imm = 0x5A000000
               	subq	$0x10, %rsp
               	movq	$0x15, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testl	%eax, %eax
               	je	<addr>
               	leave
               	retq
               	xorl	%edi, %edi
               	movq	$-0x1, %rsi
               	movabsq	$0x43f0000000000000, %rdx # imm = 0x43F0000000000000
               	movl	$0x5f800000, %ecx       # imm = 0x5F800000
               	subq	$0x10, %rsp
               	movq	$0x19, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testl	%eax, %eax
               	je	<addr>
               	leave
               	retq
               	xorl	%edi, %edi
               	movabsq	$-0x8000000000000000, %rsi # imm = 0x8000000000000000
               	movabsq	$0x43e0000000000000, %rdx # imm = 0x43E0000000000000
               	movl	$0x5f000000, %ecx       # imm = 0x5F000000
               	subq	$0x10, %rsp
               	movq	$0x1d, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testl	%eax, %eax
               	je	<addr>
               	leave
               	retq
               	movl	$0x1, %edi
               	xorl	%esi, %esi
               	movabsq	$0x43f0000000000000, %rdx # imm = 0x43F0000000000000
               	movl	$0x5f800000, %ecx       # imm = 0x5F800000
               	subq	$0x10, %rsp
               	movq	$0x21, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testl	%eax, %eax
               	je	<addr>
               	leave
               	retq
               	movl	$0x5, %edi
               	xorl	%esi, %esi
               	movabsq	$0x4414000000000000, %rdx # imm = 0x4414000000000000
               	movl	$0x60a00000, %ecx       # imm = 0x60A00000
               	subq	$0x10, %rsp
               	movq	$0x25, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testl	%eax, %eax
               	je	<addr>
               	leave
               	retq
               	movabsq	$0x1000000000000, %rdi  # imm = 0x1000000000000
               	movl	$0x1, %esi
               	movabsq	$0x46f0000000000000, %rdx # imm = 0x46F0000000000000
               	movl	$0x77800000, %ecx       # imm = 0x77800000
               	subq	$0x10, %rsp
               	movq	$0x29, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testl	%eax, %eax
               	je	<addr>
               	leave
               	retq
               	movabsq	$0x1000000000001, %rdi  # imm = 0x1000000000001
               	movl	$0x1, %esi
               	movabsq	$0x46f0000000000010, %rdx # imm = 0x46F0000000000010
               	movl	$0x77800000, %ecx       # imm = 0x77800000
               	subq	$0x10, %rsp
               	movq	$0x2d, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testl	%eax, %eax
               	je	<addr>
               	leave
               	retq
               	movq	$-0x1, %rdi
               	movabsq	$0x47f0000000000000, %rdx # imm = 0x47F0000000000000
               	movl	$0x7f800000, %ecx       # imm = 0x7F800000
               	movabsq	$-0x4010000000000000, %r8 # imm = 0xBFF0000000000000
               	movl	$0xbf800000, %r9d       # imm = 0xBF800000
               	subq	$0x10, %rsp
               	movq	$0x31, (%rsp)
               	movq	%rdi, %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testl	%eax, %eax
               	je	<addr>
               	leave
               	retq
               	movabsq	$-0x8000000000000000, %rdi # imm = 0x8000000000000000
               	xorl	%esi, %esi
               	movabsq	$0x47e0000000000000, %rdx # imm = 0x47E0000000000000
               	movl	$0x7f000000, %ecx       # imm = 0x7F000000
               	movabsq	$-0x3820000000000000, %r8 # imm = 0xC7E0000000000000
               	movl	$0xff000000, %r9d       # imm = 0xFF000000
               	subq	$0x10, %rsp
               	movq	$0x35, (%rsp)
               	callq	<addr>
               	addq	$0x10, %rsp
               	testl	%eax, %eax
               	je	<addr>
               	leave
               	retq
               	movabsq	$0x7fffffffffffffff, %rdi # imm = 0x7FFFFFFFFFFFFFFF
               	movq	$-0x1, %rsi
               	movabsq	$0x47e0000000000000, %rdx # imm = 0x47E0000000000000
               	movl	$0x7f000000, %ecx       # imm = 0x7F000000
               	subq	$0x10, %rsp
               	movq	$0x39, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testl	%eax, %eax
               	je	<addr>
               	leave
               	retq
               	movabsq	$0x11223344556677, %rdi # imm = 0x11223344556677
               	movabsq	$-0x7766554433221101, %rsi # imm = 0x8899AABBCCDDEEFF
               	movabsq	$0x4731223344556678, %rdx # imm = 0x4731223344556678
               	movl	$0x7989119a, %ecx       # imm = 0x7989119A
               	subq	$0x10, %rsp
               	movq	$0x3d, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	testl	%eax, %eax
               	je	<addr>
               	leave
               	retq
               	xorl	%edi, %edi
               	movl	$0x41, %edx
               	movq	%rdi, %xmm0
               	movq	%rdi, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leave
               	retq
               	movsd	<rip>, %xmm0
               	xorl	%edi, %edi
               	movl	$0x3, %esi
               	movl	$0x43, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leave
               	retq
               	movsd	<rip>, %xmm0
               	xorl	%edi, %edi
               	movl	$0x45, %edx
               	movq	%rdi, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leave
               	retq
               	movsd	<rip>, %xmm0
               	xorl	%edi, %edi
               	movl	$0x47, %edx
               	movq	%rdi, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leave
               	retq
               	movsd	<rip>, %xmm0
               	movq	$-0x1, %rdi
               	movq	$-0x3, %rsi
               	movl	$0x49, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leave
               	retq
               	movsd	<rip>, %xmm0
               	xorl	%edi, %edi
               	movabsq	$-0x2fd54b7931240000, %rsi # imm = 0xD02AB486CEDC0000
               	movl	$0x4b, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leave
               	retq
               	movsd	<rip>, %xmm0
               	movl	$0x1, %edi
               	xorl	%esi, %esi
               	movl	$0x4d, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leave
               	retq
               	movsd	<rip>, %xmm0
               	movl	$0x20000000, %edi       # imm = 0x20000000
               	xorl	%esi, %esi
               	movl	$0x4f, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leave
               	retq
               	movsd	<rip>, %xmm0
               	movabsq	$-0x8000000000000000, %rdi # imm = 0x8000000000000000
               	xorl	%esi, %esi
               	movl	$0x51, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leave
               	retq
               	movl	$0x40200000, <rip> # imm = 0x40200000
                                                # <addr>
               	movss	<rip>, %xmm0 # <addr>
               	cvtss2sd	%xmm0, %xmm0
               	movq	%xmm0, %rax
               	movq	%rax, %r10
               	sarq	$0x3f, %r10
               	movq	%r10, 0x28(%rsp)
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
               	movq	%r9, %r10
               	subq	%rcx, %r10
               	movq	%r10, 0x20(%rsp)
               	shrq	$0x6, %r8
               	negq	%r8
               	movq	%r8, %r9
               	xorq	$-0x1, %r9
               	shlxq	%rcx, %rsi, %r10
               	movq	%r10, 0x18(%rsp)
               	andq	%r9, %r10
               	movq	%r10, 0x18(%rsp)
               	shrxq	%rcx, %rdi, %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x20(%rsp), %r10
               	shlxq	%r10, %rdi, %rdi
               	shlq	%rdi
               	shrxq	%rcx, %rsi, %rcx
               	orq	%rdi, %rcx
               	andq	%r9, %rcx
               	movq	%r8, %r10
               	movq	0x10(%rsp), %r8
               	andq	%r10, %r8
               	orq	%r8, %rcx
               	movq	%rax, %rsi
               	xorq	$-0x1, %rsi
               	movq	%rsi, %r10
               	movq	0x18(%rsp), %rsi
               	andq	%r10, %rsi
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
               	movq	0x28(%rsp), %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rax
               	cmpq	$0x2, %rax
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	cvtss2sd	%xmm0, %xmm0
               	movq	%xmm0, %rax
               	movq	%rax, %r10
               	sarq	$0x3f, %r10
               	movq	%r10, 0x28(%rsp)
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
               	movq	%r9, %r10
               	subq	%rcx, %r10
               	movq	%r10, 0x20(%rsp)
               	shrq	$0x6, %r8
               	negq	%r8
               	movq	%r8, %r9
               	xorq	$-0x1, %r9
               	shlxq	%rcx, %rsi, %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x20(%rsp), %r10
               	shrxq	%r10, %rsi, %rsi
               	shrq	%rsi
               	shlxq	%rcx, %rdi, %r10
               	movq	%r10, 0x20(%rsp)
               	movq	%rsi, %r10
               	movq	0x20(%rsp), %rsi
               	orq	%r10, %rsi
               	andq	%r9, %rsi
               	movq	%r8, %r10
               	movq	0x18(%rsp), %r8
               	andq	%r10, %r8
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
               	movq	0x28(%rsp), %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x53, %eax
               	leave
               	retq
               	movl	$0xc0600000, <rip> # imm = 0xC0600000
                                                # <addr>
               	movss	<rip>, %xmm0 # <addr>
               	cvtss2sd	%xmm0, %xmm0
               	movq	%xmm0, %rax
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
               	movl	$0x3f, %r10d
               	movq	%r10, 0x28(%rsp)
               	subq	%rcx, %r10
               	movq	%r10, 0x20(%rsp)
               	shrq	$0x6, %r9
               	negq	%r9
               	movq	%r9, %r10
               	xorq	$-0x1, %r10
               	movq	%r10, 0x28(%rsp)
               	shlxq	%rcx, %rdi, %r10
               	movq	%r10, 0x18(%rsp)
               	andq	0x28(%rsp), %r10
               	movq	%r10, 0x18(%rsp)
               	shrxq	%rcx, %r8, %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x20(%rsp), %r10
               	shlxq	%r10, %r8, %r8
               	shlq	%r8
               	shrxq	%rcx, %rdi, %rcx
               	orq	%r8, %rcx
               	andq	0x28(%rsp), %rcx
               	movq	%r9, %r10
               	movq	0x10(%rsp), %r9
               	andq	%r10, %r9
               	orq	%r9, %rcx
               	movq	%rax, %rdi
               	xorq	$-0x1, %rdi
               	movq	%rdi, %r10
               	movq	0x18(%rsp), %rdi
               	andq	%r10, %rdi
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
               	movss	<rip>, %xmm0 # <addr>
               	cvtss2sd	%xmm0, %xmm0
               	movq	%xmm0, %rcx
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rcx, %rdx
               	shrq	$0x34, %rdx
               	leaq	-0x3ff(%rdx), %r10
               	movq	%r10, 0x28(%rsp)
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
               	movq	%r9, %r10
               	subq	%rdx, %r10
               	movq	%r10, 0x20(%rsp)
               	shrq	$0x6, %rsi
               	movq	%rsi, %r9
               	negq	%r9
               	movq	%r9, %rsi
               	xorq	$-0x1, %rsi
               	shlxq	%rdx, %rdi, %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x20(%rsp), %r11
               	shrxq	%r11, %rdi, %r10
               	movq	%r10, 0x10(%rsp)
               	shrq	%r10
               	movq	%r10, 0x10(%rsp)
               	shlxq	%rdx, %r8, %r10
               	movq	%r10, 0x8(%rsp)
               	orq	0x10(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x18(%rsp), %r10
               	andq	%rsi, %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x10(%rsp), %r10
               	andq	%rsi, %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x18(%rsp), %r10
               	andq	%r9, %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x10(%rsp), %r10
               	orq	0x18(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	shrxq	%rdx, %r8, %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x20(%rsp), %r10
               	shlxq	%r10, %r8, %r8
               	shlq	%r8
               	shrxq	%rdx, %rdi, %rdx
               	orq	%r8, %rdx
               	andq	%rsi, %rdx
               	movq	%r9, %r10
               	movq	0x18(%rsp), %r9
               	andq	%r10, %r9
               	orq	%rdx, %r9
               	movq	%rsi, %r10
               	movq	0x18(%rsp), %rsi
               	andq	%r10, %rsi
               	movq	%rcx, %rdx
               	xorq	$-0x1, %rdx
               	movq	0x8(%rsp), %rdi
               	andq	%rdx, %rdi
               	andq	%rcx, %r9
               	orq	%r9, %rdi
               	movq	%rdx, %r10
               	movq	0x10(%rsp), %rdx
               	andq	%r10, %rdx
               	andq	%rsi, %rcx
               	orq	%rcx, %rdx
               	movq	0x28(%rsp), %rcx
               	sarq	$0x3f, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rdi
               	andq	%rcx, %rdx
               	movq	0x28(%rsp), %rcx
               	cmpl	$0x80, %ecx
               	setge	%cl
               	movzbq	%cl, %rcx
               	negq	%rcx
               	xorq	%rax, %rdi
               	xorq	%rax, %rdx
               	cmpq	%rax, %rdi
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
               	leave
               	retq
               	xorl	%edx, %edx
               	movq	%rdx, <rip> # <addr>
               	movabsq	$0x10000000000000, %rax # imm = 0x10000000000000
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rdi # <addr>
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
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x20(%rsp)
               	movq	%rcx, %r10
               	andq	$0x7f, %r10
               	movq	%r10, 0x28(%rsp)
               	movq	%rcx, %rsi
               	andq	$0x3f, %rsi
               	movl	$0x3f, %r9d
               	movq	%r9, %r10
               	subq	%rsi, %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x28(%rsp), %r10
               	shrq	$0x6, %r10
               	movq	%r10, 0x28(%rsp)
               	negq	%r10
               	movq	%r10, 0x28(%rsp)
               	xorq	$-0x1, %r10
               	movq	%r10, 0x10(%rsp)
               	shrxq	%rsi, %rax, %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x18(%rsp), %r10
               	shlxq	%r10, %rax, %rax
               	shlq	%rax
               	shrxq	%rsi, %rdi, %rsi
               	orq	%rsi, %rax
               	andq	0x10(%rsp), %rax
               	movq	0x8(%rsp), %rsi
               	andq	0x28(%rsp), %rsi
               	orq	%rsi, %rax
               	orq	0x20(%rsp), %rax
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
               	movq	%rax, %xmm1
               	mulsd	%xmm1, %xmm0
               	movq	%xmm0, %rax
               	movq	%rax, %r10
               	sarq	$0x3f, %r10
               	movq	%r10, 0x20(%rsp)
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
               	movq	%rcx, %r10
               	andq	$0x7f, %r10
               	movq	%r10, 0x28(%rsp)
               	andq	$0x3f, %rcx
               	movq	%r9, %r10
               	subq	%rcx, %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x28(%rsp), %r9
               	shrq	$0x6, %r9
               	negq	%r9
               	movq	%r9, %r10
               	xorq	$-0x1, %r10
               	movq	%r10, 0x28(%rsp)
               	shlxq	%rcx, %rdi, %r10
               	movq	%r10, 0x10(%rsp)
               	andq	0x28(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	shrxq	%rcx, %rdx, %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x18(%rsp), %r10
               	shlxq	%r10, %rdx, %rdx
               	shlq	%rdx
               	shrxq	%rcx, %rdi, %rcx
               	orq	%rdx, %rcx
               	andq	0x28(%rsp), %rcx
               	movq	%r9, %r10
               	movq	0x8(%rsp), %r9
               	andq	%r10, %r9
               	orq	%r9, %rcx
               	movq	%rax, %rdx
               	xorq	$-0x1, %rdx
               	movq	%rdx, %r10
               	movq	0x10(%rsp), %rdx
               	andq	%r10, %rdx
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
               	movq	0x20(%rsp), %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rax
               	movabsq	$0x10000000000000, %r11 # imm = 0x10000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x55, %eax
               	leave
               	retq
               	movq	$0x5, <rip> # <addr>
               	xorl	%edx, %edx
               	movq	%rdx, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rdi # <addr>
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
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x20(%rsp)
               	movq	%rcx, %r10
               	andq	$0x7f, %r10
               	movq	%r10, 0x28(%rsp)
               	movq	%rcx, %rsi
               	andq	$0x3f, %rsi
               	movl	$0x3f, %r9d
               	movq	%r9, %r10
               	subq	%rsi, %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x28(%rsp), %r10
               	shrq	$0x6, %r10
               	movq	%r10, 0x28(%rsp)
               	negq	%r10
               	movq	%r10, 0x28(%rsp)
               	xorq	$-0x1, %r10
               	movq	%r10, 0x10(%rsp)
               	shrxq	%rsi, %rax, %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x18(%rsp), %r10
               	shlxq	%r10, %rax, %rax
               	shlq	%rax
               	shrxq	%rsi, %rdi, %rsi
               	orq	%rsi, %rax
               	andq	0x10(%rsp), %rax
               	movq	0x8(%rsp), %rsi
               	andq	0x28(%rsp), %rsi
               	orq	%rsi, %rax
               	orq	0x20(%rsp), %rax
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
               	movq	%rax, %xmm1
               	mulsd	%xmm1, %xmm0
               	movq	%xmm0, %rax
               	movq	%rax, %r10
               	sarq	$0x3f, %r10
               	movq	%r10, 0x20(%rsp)
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
               	movq	%rcx, %r10
               	andq	$0x7f, %r10
               	movq	%r10, 0x28(%rsp)
               	andq	$0x3f, %rcx
               	movq	%r9, %r10
               	subq	%rcx, %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x28(%rsp), %r9
               	shrq	$0x6, %r9
               	negq	%r9
               	movq	%r9, %r10
               	xorq	$-0x1, %r10
               	movq	%r10, 0x28(%rsp)
               	shlxq	%rcx, %rdi, %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x18(%rsp), %r10
               	shrxq	%r10, %rdi, %rdi
               	shrq	%rdi
               	shlxq	%rcx, %rdx, %r10
               	movq	%r10, 0x18(%rsp)
               	movq	%rdi, %r10
               	movq	0x18(%rsp), %rdi
               	orq	%r10, %rdi
               	andq	0x28(%rsp), %rdi
               	movq	%r9, %r10
               	movq	0x10(%rsp), %r9
               	andq	%r10, %r9
               	orq	%r9, %rdi
               	shrxq	%rcx, %rdx, %rcx
               	andq	0x28(%rsp), %rcx
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
               	movq	0x20(%rsp), %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x56, %eax
               	leave
               	retq
               	movq	$0x0, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rsi # <addr>
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
               	movq	%rdi, %r10
               	xorq	$-0x1, %r10
               	movq	%r10, 0x28(%rsp)
               	shrxq	%rdx, %rax, %r10
               	movq	%r10, 0x20(%rsp)
               	shlxq	%r9, %rax, %rax
               	shlq	%rax
               	shrxq	%rdx, %rsi, %rdx
               	orq	%rdx, %rax
               	andq	0x28(%rsp), %rax
               	movq	%rdi, %r10
               	movq	0x20(%rsp), %rdi
               	andq	%r10, %rdi
               	orq	%rdi, %rax
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
               	movq	%rax, %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	<rip>, %xmm1 # <addr>
               	addsd	%xmm1, %xmm0
               	movq	%xmm0, %rax
               	movabsq	$0x4012000000000000, %r11 # imm = 0x4012000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x57, %eax
               	leave
               	retq
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
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
               	movl	$0x3f, %r10d
               	movq	%r10, 0x28(%rsp)
               	subq	%rdx, %r10
               	movq	%r10, 0x28(%rsp)
               	shrq	$0x6, %rdi
               	negq	%rdi
               	movq	%rdi, %r10
               	xorq	$-0x1, %r10
               	movq	%r10, 0x20(%rsp)
               	shrxq	%rdx, %rcx, %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x28(%rsp), %r10
               	shlxq	%r10, %rcx, %rcx
               	shlq	%rcx
               	shrxq	%rdx, %rsi, %rdx
               	orq	%rdx, %rcx
               	andq	0x20(%rsp), %rcx
               	movq	%rdi, %r10
               	movq	0x18(%rsp), %rdi
               	andq	%r10, %rdi
               	orq	%rdi, %rcx
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
               	movq	%rax, %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	<rip>, %xmm1 # <addr>
               	mulsd	%xmm1, %xmm0
               	movq	%xmm0, %rax
               	movabsq	$0x4012000000000000, %r11 # imm = 0x4012000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x58, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
