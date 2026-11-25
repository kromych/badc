
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
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rcx # <addr>
               	testq	%rsi, %rsi
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rsi, %rax
               	shrq	$0x20, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x5, %rax
               	leaq	0x1(%rax), %r8
               	shrxq	%rax, %rsi, %rdi
               	movq	%rdi, %rax
               	shrq	$0x10, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	addq	%rax, %r8
               	shrxq	%rax, %rdi, %rdi
               	movq	%rdi, %rax
               	shrq	$0x8, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %r8
               	shrxq	%rax, %rdi, %rdi
               	movq	%rdi, %rax
               	shrq	$0x4, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x2, %rax
               	addq	%rax, %r8
               	shrxq	%rax, %rdi, %rdi
               	movq	%rdi, %rax
               	shrq	$0x2, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	addq	%rax, %r8
               	shrxq	%rax, %rdi, %rax
               	shrq	%rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	addq	%r8, %rax
               	imulq	%rdx, %rax
               	movl	$0x40, %edi
               	subq	%rax, %rdi
               	andq	$0x3f, %rdi
               	movq	$-0x1, %rdx
               	shrxq	%rdi, %rdx, %rdi
               	testl	%eax, %eax
               	setne	%dl
               	movzbq	%dl, %rdx
               	imulq	%rdx, %rdi
               	andq	%rcx, %rdi
               	testq	%rdi, %rdi
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%rax, %rdi
               	andq	$0x3f, %rdi
               	movl	$0x3f, %edx
               	subq	%rdi, %rdx
               	movq	%rax, %r8
               	shrq	$0x6, %r8
               	negq	%r8
               	movq	%r8, %r13
               	xorq	$-0x1, %r13
               	shrxq	%rdi, %rsi, %r9
               	shlxq	%rdx, %rsi, %rdx
               	shlq	%rdx
               	shrxq	%rdi, %rcx, %rsi
               	orq	%rdx, %rsi
               	andq	%r13, %rsi
               	andq	%r8, %r9
               	orq	%r9, %rsi
               	orq	%r12, %rsi
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
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rdi # <addr>
               	testq	%rdx, %rdx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	%rdx, %rax
               	shrq	$0x20, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x5, %rax
               	leaq	0x1(%rax), %r8
               	shrxq	%rax, %rdx, %rsi
               	movq	%rsi, %rax
               	shrq	$0x10, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	addq	%rax, %r8
               	shrxq	%rax, %rsi, %rsi
               	movq	%rsi, %rax
               	shrq	$0x8, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %r8
               	shrxq	%rax, %rsi, %rsi
               	movq	%rsi, %rax
               	shrq	$0x4, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x2, %rax
               	addq	%rax, %r8
               	shrxq	%rax, %rsi, %rsi
               	movq	%rsi, %rax
               	shrq	$0x2, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	addq	%rax, %r8
               	shrxq	%rax, %rsi, %rax
               	shrq	%rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	addq	%r8, %rax
               	imulq	%rcx, %rax
               	movl	$0x40, %esi
               	subq	%rax, %rsi
               	andq	$0x3f, %rsi
               	movq	$-0x1, %rcx
               	shrxq	%rsi, %rcx, %rsi
               	testl	%eax, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	imulq	%rcx, %rsi
               	andq	%rdi, %rsi
               	testq	%rsi, %rsi
               	setne	%bl
               	movzbq	%bl, %rbx
               	movq	%rax, %rsi
               	andq	$0x3f, %rsi
               	movl	$0x3f, %ecx
               	subq	%rsi, %rcx
               	movq	%rax, %r8
               	shrq	$0x6, %r8
               	negq	%r8
               	movq	%r8, %r12
               	xorq	$-0x1, %r12
               	shrxq	%rsi, %rdx, %r9
               	shlxq	%rcx, %rdx, %rcx
               	shlq	%rcx
               	shrxq	%rsi, %rdi, %rdx
               	orq	%rcx, %rdx
               	andq	%r12, %rdx
               	andq	%r8, %r9
               	orq	%r9, %rdx
               	orq	%rbx, %rdx
               	xorps	%xmm0, %xmm0
               	movq	%rdx, %r10
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
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rdx # <addr>
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	xorq	%rcx, %rdx
               	xorq	%rcx, %rax
               	cmpq	%rcx, %rdx
               	setb	%sil
               	movzbq	%sil, %rsi
               	subq	%rcx, %rdx
               	subq	%rcx, %rax
               	subq	%rsi, %rax
               	movabsq	$-0x8000000000000000, %rbx # imm = 0x8000000000000000
               	andq	%rcx, %rbx
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
               	shrxq	%rcx, %rax, %rsi
               	movq	%rsi, %rcx
               	shrq	$0x10, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %r8
               	shrxq	%rcx, %rsi, %rsi
               	movq	%rsi, %rcx
               	shrq	$0x8, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %r8
               	shrxq	%rcx, %rsi, %rsi
               	movq	%rsi, %rcx
               	shrq	$0x4, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %r8
               	shrxq	%rcx, %rsi, %rsi
               	movq	%rsi, %rcx
               	shrq	$0x2, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
               	addq	%rcx, %r8
               	shrxq	%rcx, %rsi, %rcx
               	shrq	%rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	addq	%r8, %rcx
               	imulq	%rdi, %rcx
               	movl	$0x40, %esi
               	subq	%rcx, %rsi
               	andq	$0x3f, %rsi
               	movq	$-0x1, %rdi
               	shrxq	%rsi, %rdi, %rsi
               	testl	%ecx, %ecx
               	setne	%dil
               	movzbq	%dil, %rdi
               	imulq	%rdi, %rsi
               	andq	%rdx, %rsi
               	testq	%rsi, %rsi
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%rcx, %rsi
               	andq	$0x3f, %rsi
               	movl	$0x3f, %edi
               	subq	%rsi, %rdi
               	movq	%rcx, %r8
               	shrq	$0x6, %r8
               	negq	%r8
               	movq	%r8, %r13
               	xorq	$-0x1, %r13
               	shrxq	%rsi, %rax, %r9
               	shlxq	%rdi, %rax, %rdi
               	shlq	%rdi
               	shrxq	%rsi, %rdx, %rax
               	orq	%rdi, %rax
               	andq	%r13, %rax
               	andq	%r8, %r9
               	orq	%r9, %rax
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
               	orq	%rbx, %rax
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
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rdx # <addr>
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	xorq	%rcx, %rdx
               	xorq	%rcx, %rax
               	cmpq	%rcx, %rdx
               	setb	%sil
               	movzbq	%sil, %rsi
               	subq	%rcx, %rdx
               	subq	%rcx, %rax
               	subq	%rsi, %rax
               	movabsq	$-0x8000000000000000, %rbx # imm = 0x8000000000000000
               	andq	%rcx, %rbx
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
               	shrxq	%rcx, %rax, %rsi
               	movq	%rsi, %rcx
               	shrq	$0x10, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %r8
               	shrxq	%rcx, %rsi, %rsi
               	movq	%rsi, %rcx
               	shrq	$0x8, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %r8
               	shrxq	%rcx, %rsi, %rsi
               	movq	%rsi, %rcx
               	shrq	$0x4, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %r8
               	shrxq	%rcx, %rsi, %rsi
               	movq	%rsi, %rcx
               	shrq	$0x2, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
               	addq	%rcx, %r8
               	shrxq	%rcx, %rsi, %rcx
               	shrq	%rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	addq	%r8, %rcx
               	imulq	%rdi, %rcx
               	movl	$0x40, %esi
               	subq	%rcx, %rsi
               	andq	$0x3f, %rsi
               	movq	$-0x1, %rdi
               	shrxq	%rsi, %rdi, %rsi
               	testl	%ecx, %ecx
               	setne	%dil
               	movzbq	%dil, %rdi
               	imulq	%rdi, %rsi
               	andq	%rdx, %rsi
               	testq	%rsi, %rsi
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%rcx, %rsi
               	andq	$0x3f, %rsi
               	movl	$0x3f, %edi
               	subq	%rsi, %rdi
               	movq	%rcx, %r8
               	shrq	$0x6, %r8
               	negq	%r8
               	movq	%r8, %r13
               	xorq	$-0x1, %r13
               	shrxq	%rsi, %rax, %r9
               	shlxq	%rdi, %rax, %rdi
               	shlq	%rdi
               	shrxq	%rsi, %rdx, %rax
               	orq	%rdi, %rax
               	andq	%r13, %rax
               	andq	%r8, %r9
               	orq	%r9, %rax
               	orq	%r12, %rax
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
               	leaq	0x3ff(%rcx), %rax
               	shlq	$0x34, %rax
               	orq	%rbx, %rax
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
               	subq	$0x18, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	movq	%rdi, %rbp
               	movq	%rdx, 0x30(%rsp)
               	movq	%rsi, 0x38(%rsp)
               	movsd	%xmm0, <rip> # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movq	%xmm0, %rcx
               	movq	%rcx, %r14
               	sarq	$0x3f, %r14
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rcx, %rdx
               	shrq	$0x34, %rdx
               	leaq	-0x3ff(%rdx), %r15
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$0x10000000000000, %rbx # imm = 0x10000000000000
               	orq	%rcx, %rbx
               	leaq	-0x433(%rdx), %rcx
               	movq	%rcx, %r9
               	sarq	$0x3f, %r9
               	xorq	%r9, %rcx
               	subq	%r9, %rcx
               	xorl	%r12d, %r12d
               	movq	%rcx, %rdx
               	andq	$0x7f, %rdx
               	andq	$0x3f, %rcx
               	movl	$0x3f, %r13d
               	subq	%rcx, %r13
               	shrq	$0x6, %rdx
               	movq	%rdx, %rsi
               	negq	%rsi
               	movq	%rsi, %rax
               	xorq	$-0x1, %rax
               	shlxq	%rcx, %rbx, %rdi
               	shrxq	%r13, %rbx, %r8
               	shrq	%r8
               	shlxq	%rcx, %r12, %rdx
               	orq	%r8, %rdx
               	movq	%rdi, %r8
               	andq	%rax, %r8
               	andq	%rax, %rdx
               	andq	%rsi, %rdi
               	orq	%rdi, %rdx
               	shrxq	%rcx, %r12, %rdi
               	shlxq	%r13, %r12, %r12
               	shlq	%r12
               	shrxq	%rcx, %rbx, %rcx
               	orq	%r12, %rcx
               	andq	%rax, %rcx
               	andq	%rdi, %rsi
               	orq	%rsi, %rcx
               	andq	%rax, %rdi
               	movq	%r9, %rax
               	xorq	$-0x1, %rax
               	andq	%rax, %r8
               	andq	%r9, %rcx
               	orq	%rcx, %r8
               	andq	%rax, %rdx
               	andq	%r9, %rdi
               	orq	%rdi, %rdx
               	movq	%r15, %rcx
               	sarq	$0x3f, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %r8
               	andq	%rcx, %rdx
               	cmpl	$0x80, %r15d
               	setge	%cl
               	movzbq	%cl, %rcx
               	negq	%rcx
               	movq	%rcx, %r9
               	xorq	$-0x1, %r9
               	andq	%r9, %r8
               	orq	%rcx, %r8
               	andq	%r9, %rdx
               	orq	%rcx, %rdx
               	xorq	$-0x1, %r14
               	andq	%r14, %r8
               	andq	%r14, %rdx
               	cmpq	%rbp, %rdx
               	jne	<addr>
               	cmpq	0x38(%rsp), %r8
               	je	<addr>
               	movq	0x30(%rsp), %rax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x18, %rsp
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	movq	%xmm0, %rcx
               	movq	%rcx, %r9
               	sarq	$0x3f, %r9
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rcx, %rdx
               	shrq	$0x34, %rdx
               	leaq	-0x3ff(%rdx), %r15
               	movabsq	$0xfffffffffffff, %rax  # imm = 0xFFFFFFFFFFFFF
               	andq	%rcx, %rax
               	movabsq	$0x10000000000000, %r12 # imm = 0x10000000000000
               	orq	%rax, %r12
               	subq	$0x433, %rdx            # imm = 0x433
               	movq	%rdx, %rax
               	sarq	$0x3f, %rax
               	xorq	%rax, %rdx
               	subq	%rax, %rdx
               	xorl	%r13d, %r13d
               	movq	%rdx, %rcx
               	andq	$0x7f, %rcx
               	andq	$0x3f, %rdx
               	movl	$0x3f, %r14d
               	subq	%rdx, %r14
               	shrq	$0x6, %rcx
               	movq	%rcx, %rdi
               	negq	%rdi
               	movq	%rdi, %rsi
               	xorq	$-0x1, %rsi
               	shlxq	%rdx, %r12, %rbx
               	shrxq	%r14, %r12, %r8
               	shrq	%r8
               	shlxq	%rdx, %r13, %rcx
               	orq	%r8, %rcx
               	movq	%rbx, %r8
               	andq	%rsi, %r8
               	andq	%rsi, %rcx
               	andq	%rdi, %rbx
               	orq	%rbx, %rcx
               	shrxq	%rdx, %r13, %rbx
               	shlxq	%r14, %r13, %r13
               	shlq	%r13
               	shrxq	%rdx, %r12, %rdx
               	orq	%r13, %rdx
               	andq	%rsi, %rdx
               	andq	%rbx, %rdi
               	orq	%rdi, %rdx
               	andq	%rsi, %rbx
               	movq	%rax, %rsi
               	xorq	$-0x1, %rsi
               	andq	%rsi, %r8
               	andq	%rax, %rdx
               	orq	%rdx, %r8
               	andq	%rsi, %rcx
               	andq	%rax, %rbx
               	orq	%rbx, %rcx
               	movq	%r15, %rdx
               	sarq	$0x3f, %rdx
               	xorq	$-0x1, %rdx
               	andq	%rdx, %r8
               	andq	%rdx, %rcx
               	cmpl	$0x80, %r15d
               	setge	%al
               	movzbq	%al, %rax
               	movq	%rax, %rdx
               	negq	%rdx
               	xorq	%r9, %r8
               	xorq	%r9, %rcx
               	cmpq	%r9, %r8
               	setb	%al
               	movzbq	%al, %rax
               	subq	%r9, %r8
               	subq	%r9, %rcx
               	subq	%rax, %rcx
               	movq	%r9, %rsi
               	xorq	$-0x1, %rsi
               	movabsq	$0x7fffffffffffffff, %rdi # imm = 0x7FFFFFFFFFFFFFFF
               	xorq	%r9, %rdi
               	movq	%rdx, %rax
               	xorq	$-0x1, %rax
               	andq	%rax, %r8
               	andq	%rdx, %rsi
               	orq	%rsi, %r8
               	andq	%rax, %rcx
               	andq	%rdx, %rdi
               	orq	%rdi, %rcx
               	cmpq	%rbp, %rcx
               	jne	<addr>
               	cmpq	0x38(%rsp), %r8
               	je	<addr>
               	movq	0x30(%rsp), %rax
               	incq	%rax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x18, %rsp
               	retq

<chk_from_fp_neg>:
               	subq	$0x30, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, 0x48(%rsp)
               	movq	%rdx, 0x38(%rsp)
               	movq	%rsi, 0x40(%rsp)
               	movsd	%xmm0, <rip> # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movq	%xmm0, %rcx
               	movq	%rcx, %r9
               	sarq	$0x3f, %r9
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rcx, %rdx
               	shrq	$0x34, %rdx
               	leaq	-0x3ff(%rdx), %r15
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$0x10000000000000, %r12 # imm = 0x10000000000000
               	orq	%rcx, %r12
               	subq	$0x433, %rdx            # imm = 0x433
               	movq	%rdx, %rax
               	sarq	$0x3f, %rax
               	xorq	%rax, %rdx
               	subq	%rax, %rdx
               	xorl	%r13d, %r13d
               	movq	%rdx, %rcx
               	andq	$0x7f, %rcx
               	andq	$0x3f, %rdx
               	movl	$0x3f, %r14d
               	subq	%rdx, %r14
               	shrq	$0x6, %rcx
               	movq	%rcx, %rdi
               	negq	%rdi
               	movq	%rdi, %rsi
               	xorq	$-0x1, %rsi
               	shlxq	%rdx, %r12, %rbx
               	shrxq	%r14, %r12, %r8
               	shrq	%r8
               	shlxq	%rdx, %r13, %rcx
               	orq	%r8, %rcx
               	movq	%rbx, %r8
               	andq	%rsi, %r8
               	andq	%rsi, %rcx
               	andq	%rdi, %rbx
               	orq	%rbx, %rcx
               	shrxq	%rdx, %r13, %rbx
               	shlxq	%r14, %r13, %r13
               	shlq	%r13
               	shrxq	%rdx, %r12, %rdx
               	orq	%r13, %rdx
               	andq	%rsi, %rdx
               	andq	%rbx, %rdi
               	orq	%rdi, %rdx
               	andq	%rsi, %rbx
               	movq	%rax, %rsi
               	xorq	$-0x1, %rsi
               	andq	%rsi, %r8
               	andq	%rax, %rdx
               	orq	%rdx, %r8
               	andq	%rsi, %rcx
               	andq	%rax, %rbx
               	orq	%rbx, %rcx
               	movq	%r15, %rdx
               	sarq	$0x3f, %rdx
               	xorq	$-0x1, %rdx
               	andq	%rdx, %r8
               	andq	%rdx, %rcx
               	cmpl	$0x80, %r15d
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	xorq	%r9, %r8
               	xorq	%r9, %rcx
               	cmpq	%r9, %r8
               	setb	%dil
               	movzbq	%dil, %rdi
               	subq	%r9, %r8
               	subq	%r9, %rcx
               	subq	%rdi, %rcx
               	movq	%r9, %rax
               	xorq	$-0x1, %rax
               	movabsq	$0x7fffffffffffffff, %rsi # imm = 0x7FFFFFFFFFFFFFFF
               	xorq	%r9, %rsi
               	movq	%rdx, %r9
               	xorq	$-0x1, %r9
               	andq	%r9, %r8
               	andq	%rdx, %rax
               	orq	%rax, %r8
               	andq	%r9, %rcx
               	andq	%rdx, %rsi
               	orq	%rsi, %rcx
               	cmpq	0x48(%rsp), %rcx
               	jne	<addr>
               	cmpq	0x40(%rsp), %r8
               	je	<addr>
               	movq	0x38(%rsp), %rax
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

<main>:
               	subq	$0x30, %rsp
               	pushq	%rbx
               	subq	$0x10, %rsp
               	xorl	%edi, %edi
               	movq	$0x1, (%rsp)
               	movq	%rdi, %rsi
               	movq	%rdi, %r9
               	movq	%rdi, %r8
               	movq	%rdi, %rcx
               	movq	%rdi, %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	xorl	%edi, %edi
               	movl	$0x1, %esi
               	movabsq	$0x3ff0000000000000, %rdx # imm = 0x3FF0000000000000
               	movl	$0x3f800000, %ecx       # imm = 0x3F800000
               	movq	$0x5, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	xorl	%edi, %edi
               	movl	$0x5, %esi
               	movabsq	$0x4014000000000000, %rdx # imm = 0x4014000000000000
               	movl	$0x40a00000, %ecx       # imm = 0x40A00000
               	movq	$0x9, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	xorl	%edi, %edi
               	movabsq	$0x20000000000000, %rsi # imm = 0x20000000000000
               	movabsq	$0x4340000000000000, %rdx # imm = 0x4340000000000000
               	movl	$0x5a000000, %ecx       # imm = 0x5A000000
               	movq	$0xd, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	xorl	%edi, %edi
               	movabsq	$0x20000000000001, %rsi # imm = 0x20000000000001
               	movabsq	$0x4340000000000000, %rdx # imm = 0x4340000000000000
               	movl	$0x5a000000, %ecx       # imm = 0x5A000000
               	movq	$0x11, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	xorl	%edi, %edi
               	movabsq	$0x20000000000003, %rsi # imm = 0x20000000000003
               	movabsq	$0x4340000000000002, %rdx # imm = 0x4340000000000002
               	movl	$0x5a000000, %ecx       # imm = 0x5A000000
               	movq	$0x15, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	xorl	%edi, %edi
               	movq	$-0x1, %rsi
               	movabsq	$0x43f0000000000000, %rdx # imm = 0x43F0000000000000
               	movl	$0x5f800000, %ecx       # imm = 0x5F800000
               	movq	$0x19, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	xorl	%edi, %edi
               	movabsq	$-0x8000000000000000, %rsi # imm = 0x8000000000000000
               	movabsq	$0x43e0000000000000, %rdx # imm = 0x43E0000000000000
               	movl	$0x5f000000, %ecx       # imm = 0x5F000000
               	movq	$0x1d, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movl	$0x1, %edi
               	xorl	%esi, %esi
               	movabsq	$0x43f0000000000000, %rdx # imm = 0x43F0000000000000
               	movl	$0x5f800000, %ecx       # imm = 0x5F800000
               	movq	$0x21, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movl	$0x5, %edi
               	xorl	%esi, %esi
               	movabsq	$0x4414000000000000, %rdx # imm = 0x4414000000000000
               	movl	$0x60a00000, %ecx       # imm = 0x60A00000
               	movq	$0x25, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movabsq	$0x1000000000000, %rdi  # imm = 0x1000000000000
               	movl	$0x1, %esi
               	movabsq	$0x46f0000000000000, %rdx # imm = 0x46F0000000000000
               	movl	$0x77800000, %ecx       # imm = 0x77800000
               	movq	$0x29, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movabsq	$0x1000000000001, %rdi  # imm = 0x1000000000001
               	movl	$0x1, %esi
               	movabsq	$0x46f0000000000010, %rdx # imm = 0x46F0000000000010
               	movl	$0x77800000, %ecx       # imm = 0x77800000
               	movq	$0x2d, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movq	$-0x1, %rdi
               	movabsq	$0x47f0000000000000, %rdx # imm = 0x47F0000000000000
               	movl	$0x7f800000, %ecx       # imm = 0x7F800000
               	movabsq	$-0x4010000000000000, %r8 # imm = 0xBFF0000000000000
               	movl	$0xbf800000, %r9d       # imm = 0xBF800000
               	movq	$0x31, (%rsp)
               	movq	%rdi, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movabsq	$-0x8000000000000000, %rdi # imm = 0x8000000000000000
               	xorl	%esi, %esi
               	movabsq	$0x47e0000000000000, %rdx # imm = 0x47E0000000000000
               	movl	$0x7f000000, %ecx       # imm = 0x7F000000
               	movabsq	$-0x3820000000000000, %r8 # imm = 0xC7E0000000000000
               	movl	$0xff000000, %r9d       # imm = 0xFF000000
               	movq	$0x35, (%rsp)
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movabsq	$0x7fffffffffffffff, %rdi # imm = 0x7FFFFFFFFFFFFFFF
               	movq	$-0x1, %rsi
               	movabsq	$0x47e0000000000000, %rdx # imm = 0x47E0000000000000
               	movl	$0x7f000000, %ecx       # imm = 0x7F000000
               	movq	$0x39, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movabsq	$0x11223344556677, %rdi # imm = 0x11223344556677
               	movabsq	$-0x7766554433221101, %rsi # imm = 0x8899AABBCCDDEEFF
               	movabsq	$0x4731223344556678, %rdx # imm = 0x4731223344556678
               	movl	$0x7989119a, %ecx       # imm = 0x7989119A
               	movq	$0x3d, (%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	xorl	%edi, %edi
               	movl	$0x41, %edx
               	movq	%rdi, %xmm0
               	movq	%rdi, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movsd	<rip>, %xmm0
               	xorl	%edi, %edi
               	movl	$0x3, %esi
               	movl	$0x43, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movsd	<rip>, %xmm0
               	xorl	%edi, %edi
               	movl	$0x45, %edx
               	movq	%rdi, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movsd	<rip>, %xmm0
               	xorl	%edi, %edi
               	movl	$0x47, %edx
               	movq	%rdi, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movsd	<rip>, %xmm0
               	movq	$-0x1, %rdi
               	movq	$-0x3, %rsi
               	movl	$0x49, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movsd	<rip>, %xmm0
               	xorl	%edi, %edi
               	movabsq	$-0x2fd54b7931240000, %rsi # imm = 0xD02AB486CEDC0000
               	movl	$0x4b, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movsd	<rip>, %xmm0
               	movl	$0x1, %edi
               	xorl	%esi, %esi
               	movl	$0x4d, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movsd	<rip>, %xmm0
               	movl	$0x20000000, %edi       # imm = 0x20000000
               	xorl	%esi, %esi
               	movl	$0x4f, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movsd	<rip>, %xmm0
               	movabsq	$-0x8000000000000000, %rdi # imm = 0x8000000000000000
               	xorl	%esi, %esi
               	movl	$0x51, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
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
               	leaq	-0x3ff(%rcx), %rsi
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$0x10000000000000, %rdi # imm = 0x10000000000000
               	orq	%rax, %rdi
               	leaq	-0x433(%rcx), %rax
               	movq	%rax, %rdx
               	sarq	$0x3f, %rdx
               	xorq	%rdx, %rax
               	subq	%rdx, %rax
               	xorl	%r8d, %r8d
               	movq	%rax, %rcx
               	andq	$0x7f, %rcx
               	andq	$0x3f, %rax
               	movl	$0x3f, %r9d
               	subq	%rax, %r9
               	shrq	$0x6, %rcx
               	movq	%rcx, %rbx
               	negq	%rbx
               	movq	%rbx, %r10
               	xorq	$-0x1, %r10
               	movq	%r10, 0x38(%rsp)
               	shlxq	%rax, %rdi, %rcx
               	andq	0x38(%rsp), %rcx
               	shrxq	%rax, %r8, %r10
               	movq	%r10, 0x30(%rsp)
               	shlxq	%r9, %r8, %r8
               	shlq	%r8
               	shrxq	%rax, %rdi, %rax
               	orq	%r8, %rax
               	andq	0x38(%rsp), %rax
               	movq	0x30(%rsp), %r10
               	andq	%rbx, %r10
               	movq	%r10, 0x30(%rsp)
               	orq	0x30(%rsp), %rax
               	movq	%rdx, %rdi
               	xorq	$-0x1, %rdi
               	andq	%rdi, %rcx
               	andq	%rdx, %rax
               	orq	%rax, %rcx
               	movq	%rsi, %rax
               	sarq	$0x3f, %rax
               	xorq	$-0x1, %rax
               	andq	%rax, %rcx
               	cmpl	$0x80, %esi
               	setge	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movq	%rax, %rdx
               	xorq	$-0x1, %rdx
               	andq	%rdx, %rcx
               	orq	%rax, %rcx
               	xorq	$-0x1, 0x28(%rsp)
               	andq	0x28(%rsp), %rcx
               	cmpq	$0x2, %rcx
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	cvtss2sd	%xmm0, %xmm0
               	movq	%xmm0, %rax
               	movq	%rax, %r10
               	sarq	$0x3f, %r10
               	movq	%r10, 0x30(%rsp)
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rax, %rcx
               	shrq	$0x34, %rcx
               	leaq	-0x3ff(%rcx), %rsi
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$0x10000000000000, %r11 # imm = 0x10000000000000
               	orq	%r11, %rax
               	subq	$0x433, %rcx            # imm = 0x433
               	movq	%rcx, %rdx
               	sarq	$0x3f, %rdx
               	xorq	%rdx, %rcx
               	subq	%rdx, %rcx
               	xorl	%edi, %edi
               	movq	%rcx, %r9
               	andq	$0x7f, %r9
               	andq	$0x3f, %rcx
               	movl	$0x3f, %r8d
               	subq	%rcx, %r8
               	shrq	$0x6, %r9
               	negq	%r9
               	movq	%r9, %rbx
               	xorq	$-0x1, %rbx
               	shlxq	%rcx, %rax, %r10
               	movq	%r10, 0x38(%rsp)
               	shrxq	%r8, %rax, %r8
               	shrq	%r8
               	shlxq	%rcx, %rdi, %rax
               	orq	%r8, %rax
               	andq	%rbx, %rax
               	movq	0x38(%rsp), %r10
               	andq	%r9, %r10
               	movq	%r10, 0x38(%rsp)
               	orq	0x38(%rsp), %rax
               	shrxq	%rcx, %rdi, %rcx
               	andq	%rbx, %rcx
               	movq	%rdx, %rdi
               	xorq	$-0x1, %rdi
               	andq	%rdi, %rax
               	andq	%rdx, %rcx
               	orq	%rcx, %rax
               	movq	%rsi, %rcx
               	sarq	$0x3f, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rax
               	cmpl	$0x80, %esi
               	setge	%cl
               	movzbq	%cl, %rcx
               	negq	%rcx
               	movq	%rcx, %rdx
               	xorq	$-0x1, %rdx
               	andq	%rdx, %rax
               	orq	%rcx, %rax
               	xorq	$-0x1, 0x30(%rsp)
               	andq	0x30(%rsp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x53, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
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
               	leaq	-0x3ff(%rcx), %rdi
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$0x10000000000000, %r8  # imm = 0x10000000000000
               	orq	%rax, %r8
               	leaq	-0x433(%rcx), %rax
               	movq	%rax, %rsi
               	sarq	$0x3f, %rsi
               	xorq	%rsi, %rax
               	subq	%rsi, %rax
               	xorl	%r9d, %r9d
               	movq	%rax, %rcx
               	andq	$0x7f, %rcx
               	andq	$0x3f, %rax
               	movl	$0x3f, %ebx
               	subq	%rax, %rbx
               	shrq	$0x6, %rcx
               	movq	%rcx, %r10
               	negq	%r10
               	movq	%r10, 0x38(%rsp)
               	xorq	$-0x1, %r10
               	movq	%r10, 0x30(%rsp)
               	shlxq	%rax, %r8, %rcx
               	andq	0x30(%rsp), %rcx
               	shrxq	%rax, %r9, %r10
               	movq	%r10, 0x28(%rsp)
               	shlxq	%rbx, %r9, %r9
               	shlq	%r9
               	shrxq	%rax, %r8, %rax
               	orq	%r9, %rax
               	andq	0x30(%rsp), %rax
               	movq	0x28(%rsp), %r10
               	andq	0x38(%rsp), %r10
               	movq	%r10, 0x28(%rsp)
               	orq	0x28(%rsp), %rax
               	movq	%rsi, %r8
               	xorq	$-0x1, %r8
               	andq	%r8, %rcx
               	andq	%rsi, %rax
               	orq	%rax, %rcx
               	movq	%rdi, %rax
               	sarq	$0x3f, %rax
               	xorq	$-0x1, %rax
               	andq	%rax, %rcx
               	cmpl	$0x80, %edi
               	setge	%al
               	movzbq	%al, %rax
               	negq	%rax
               	xorq	%rdx, %rcx
               	subq	%rdx, %rcx
               	xorq	$-0x1, %rdx
               	movq	%rax, %rsi
               	xorq	$-0x1, %rsi
               	andq	%rsi, %rcx
               	andq	%rax, %rdx
               	orq	%rdx, %rcx
               	cmpq	$-0x3, %rcx
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	cvtss2sd	%xmm0, %xmm0
               	movq	%xmm0, %rax
               	movq	%rax, %rdx
               	sarq	$0x3f, %rdx
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rax, %rcx
               	shrq	$0x34, %rcx
               	leaq	-0x3ff(%rcx), %r10
               	movq	%r10, 0x20(%rsp)
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$0x10000000000000, %r10 # imm = 0x10000000000000
               	orq	%rax, %r10
               	movq	%r10, 0x38(%rsp)
               	subq	$0x433, %rcx            # imm = 0x433
               	movq	%rcx, %rsi
               	sarq	$0x3f, %rsi
               	xorq	%rsi, %rcx
               	subq	%rsi, %rcx
               	xorl	%r10d, %r10d
               	movq	%r10, 0x30(%rsp)
               	movq	%rcx, %rax
               	andq	$0x7f, %rax
               	andq	$0x3f, %rcx
               	movl	$0x3f, %r10d
               	movq	%r10, 0x28(%rsp)
               	subq	%rcx, %r10
               	movq	%r10, 0x28(%rsp)
               	shrq	$0x6, %rax
               	movq	%rax, %r9
               	negq	%r9
               	movq	%r9, %r8
               	xorq	$-0x1, %r8
               	movq	0x38(%rsp), %rbx
               	shlxq	%rcx, %rbx, %rbx
               	movq	0x38(%rsp), %rdi
               	movq	0x28(%rsp), %r10
               	shrxq	%r10, %rdi, %rdi
               	shrq	%rdi
               	movq	0x30(%rsp), %rax
               	shlxq	%rcx, %rax, %rax
               	orq	%rdi, %rax
               	movq	%rbx, %rdi
               	andq	%r8, %rdi
               	andq	%r8, %rax
               	andq	%r9, %rbx
               	orq	%rbx, %rax
               	movq	0x30(%rsp), %rbx
               	shrxq	%rcx, %rbx, %rbx
               	movq	0x30(%rsp), %r10
               	movq	0x28(%rsp), %r11
               	shlxq	%r11, %r10, %r10
               	movq	%r10, 0x30(%rsp)
               	shlq	%r10
               	movq	%r10, 0x30(%rsp)
               	movq	%rcx, %r10
               	movq	0x38(%rsp), %rcx
               	shrxq	%r10, %rcx, %rcx
               	orq	0x30(%rsp), %rcx
               	andq	%r8, %rcx
               	andq	%rbx, %r9
               	orq	%r9, %rcx
               	andq	%r8, %rbx
               	movq	%rsi, %r8
               	xorq	$-0x1, %r8
               	andq	%r8, %rdi
               	andq	%rsi, %rcx
               	orq	%rcx, %rdi
               	andq	%r8, %rax
               	andq	%rsi, %rbx
               	orq	%rbx, %rax
               	movq	0x20(%rsp), %rcx
               	sarq	$0x3f, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rdi
               	andq	%rcx, %rax
               	movq	0x20(%rsp), %rcx
               	cmpl	$0x80, %ecx
               	setge	%cl
               	movzbq	%cl, %rcx
               	negq	%rcx
               	xorq	%rdx, %rdi
               	xorq	%rdx, %rax
               	cmpq	%rdx, %rdi
               	setb	%sil
               	movzbq	%sil, %rsi
               	subq	%rdx, %rax
               	subq	%rsi, %rax
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	xorq	%r11, %rdx
               	movq	%rcx, %rsi
               	xorq	$-0x1, %rsi
               	andq	%rsi, %rax
               	andq	%rcx, %rdx
               	orq	%rdx, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x54, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	xorl	%esi, %esi
               	movq	%rsi, <rip> # <addr>
               	movabsq	$0x10000000000000, %rax # imm = 0x10000000000000
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %r9 # <addr>
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
               	shrxq	%rax, %rcx, %rdx
               	movq	%rdx, %rax
               	shrq	$0x10, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	addq	%rax, %r8
               	shrxq	%rax, %rdx, %rdx
               	movq	%rdx, %rax
               	shrq	$0x8, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %r8
               	shrxq	%rax, %rdx, %rdx
               	movq	%rdx, %rax
               	shrq	$0x4, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x2, %rax
               	addq	%rax, %r8
               	shrxq	%rax, %rdx, %rdx
               	movq	%rdx, %rax
               	shrq	$0x2, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	addq	%rax, %r8
               	shrxq	%rax, %rdx, %rax
               	shrq	%rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	addq	%r8, %rax
               	imulq	%rdi, %rax
               	movl	$0x40, %edx
               	subq	%rax, %rdx
               	andq	$0x3f, %rdx
               	movq	$-0x1, %r8
               	shrxq	%rdx, %r8, %rdx
               	testl	%eax, %eax
               	setne	%dil
               	movzbq	%dil, %rdi
               	imulq	%rdi, %rdx
               	andq	%r9, %rdx
               	testq	%rdx, %rdx
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x28(%rsp)
               	movq	%rax, %rdx
               	andq	$0x3f, %rdx
               	movl	$0x3f, %edi
               	movq	%rdi, %r10
               	subq	%rdx, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%rax, %rbx
               	shrq	$0x6, %rbx
               	negq	%rbx
               	movq	%rbx, %r10
               	xorq	$-0x1, %r10
               	movq	%r10, 0x20(%rsp)
               	shrxq	%rdx, %rcx, %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x38(%rsp), %r11
               	shlxq	%r11, %rcx, %r10
               	movq	%r10, 0x38(%rsp)
               	shlq	%r10
               	movq	%r10, 0x38(%rsp)
               	shrxq	%rdx, %r9, %rcx
               	orq	0x38(%rsp), %rcx
               	andq	0x20(%rsp), %rcx
               	movq	0x30(%rsp), %r10
               	andq	%rbx, %r10
               	movq	%r10, 0x30(%rsp)
               	orq	0x30(%rsp), %rcx
               	orq	0x28(%rsp), %rcx
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
               	movq	%rax, %xmm1
               	mulsd	%xmm1, %xmm0
               	movq	%xmm0, %rax
               	movq	%rax, %r10
               	sarq	$0x3f, %r10
               	movq	%r10, 0x20(%rsp)
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rax, %rcx
               	shrq	$0x34, %rcx
               	leaq	-0x3ff(%rcx), %r9
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$0x10000000000000, %rbx # imm = 0x10000000000000
               	orq	%rax, %rbx
               	leaq	-0x433(%rcx), %rax
               	movq	%rax, %rdx
               	sarq	$0x3f, %rdx
               	xorq	%rdx, %rax
               	subq	%rdx, %rax
               	movq	%rax, %rcx
               	andq	$0x7f, %rcx
               	andq	$0x3f, %rax
               	subq	%rax, %rdi
               	shrq	$0x6, %rcx
               	movq	%rcx, %r10
               	negq	%r10
               	movq	%r10, 0x38(%rsp)
               	xorq	$-0x1, %r10
               	movq	%r10, 0x30(%rsp)
               	shlxq	%rax, %rbx, %rcx
               	andq	0x30(%rsp), %rcx
               	shrxq	%rax, %rsi, %r10
               	movq	%r10, 0x28(%rsp)
               	shlxq	%rdi, %rsi, %rsi
               	shlq	%rsi
               	shrxq	%rax, %rbx, %rax
               	orq	%rsi, %rax
               	andq	0x30(%rsp), %rax
               	movq	0x28(%rsp), %r10
               	andq	0x38(%rsp), %r10
               	movq	%r10, 0x28(%rsp)
               	orq	0x28(%rsp), %rax
               	movq	%rdx, %rsi
               	xorq	$-0x1, %rsi
               	andq	%rsi, %rcx
               	andq	%rdx, %rax
               	orq	%rax, %rcx
               	movq	%r9, %rax
               	sarq	$0x3f, %rax
               	xorq	$-0x1, %rax
               	andq	%rax, %rcx
               	cmpl	$0x80, %r9d
               	setge	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movq	%rax, %rdx
               	xorq	$-0x1, %rdx
               	andq	%rdx, %rcx
               	andq	%rax, %r8
               	orq	%r8, %rcx
               	xorq	$-0x1, 0x20(%rsp)
               	andq	0x20(%rsp), %rcx
               	movabsq	$0x10000000000000, %r11 # imm = 0x10000000000000
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x55, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movq	$0x5, <rip> # <addr>
               	xorl	%esi, %esi
               	movq	%rsi, <rip> # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %r9 # <addr>
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
               	shrxq	%rax, %rcx, %rdx
               	movq	%rdx, %rax
               	shrq	$0x10, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	addq	%rax, %r8
               	shrxq	%rax, %rdx, %rdx
               	movq	%rdx, %rax
               	shrq	$0x8, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %r8
               	shrxq	%rax, %rdx, %rdx
               	movq	%rdx, %rax
               	shrq	$0x4, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x2, %rax
               	addq	%rax, %r8
               	shrxq	%rax, %rdx, %rdx
               	movq	%rdx, %rax
               	shrq	$0x2, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	addq	%rax, %r8
               	shrxq	%rax, %rdx, %rax
               	shrq	%rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	addq	%r8, %rax
               	imulq	%rdi, %rax
               	movl	$0x40, %edx
               	subq	%rax, %rdx
               	andq	$0x3f, %rdx
               	movq	$-0x1, %r8
               	shrxq	%rdx, %r8, %rdx
               	testl	%eax, %eax
               	setne	%dil
               	movzbq	%dil, %rdi
               	imulq	%rdi, %rdx
               	andq	%r9, %rdx
               	testq	%rdx, %rdx
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x28(%rsp)
               	movq	%rax, %rdx
               	andq	$0x3f, %rdx
               	movl	$0x3f, %edi
               	movq	%rdi, %r10
               	subq	%rdx, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%rax, %rbx
               	shrq	$0x6, %rbx
               	negq	%rbx
               	movq	%rbx, %r10
               	xorq	$-0x1, %r10
               	movq	%r10, 0x20(%rsp)
               	shrxq	%rdx, %rcx, %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x38(%rsp), %r11
               	shlxq	%r11, %rcx, %r10
               	movq	%r10, 0x38(%rsp)
               	shlq	%r10
               	movq	%r10, 0x38(%rsp)
               	shrxq	%rdx, %r9, %rcx
               	orq	0x38(%rsp), %rcx
               	andq	0x20(%rsp), %rcx
               	movq	0x30(%rsp), %r10
               	andq	%rbx, %r10
               	movq	%r10, 0x30(%rsp)
               	orq	0x30(%rsp), %rcx
               	orq	0x28(%rsp), %rcx
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
               	movq	%rax, %xmm1
               	mulsd	%xmm1, %xmm0
               	movq	%xmm0, %rax
               	movq	%rax, %r10
               	sarq	$0x3f, %r10
               	movq	%r10, 0x28(%rsp)
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rax, %rcx
               	shrq	$0x34, %rcx
               	leaq	-0x3ff(%rcx), %r9
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$0x10000000000000, %r11 # imm = 0x10000000000000
               	orq	%r11, %rax
               	subq	$0x433, %rcx            # imm = 0x433
               	movq	%rcx, %rdx
               	sarq	$0x3f, %rdx
               	xorq	%rdx, %rcx
               	subq	%rdx, %rcx
               	movq	%rcx, %rbx
               	andq	$0x7f, %rbx
               	andq	$0x3f, %rcx
               	subq	%rcx, %rdi
               	shrq	$0x6, %rbx
               	negq	%rbx
               	movq	%rbx, %r10
               	xorq	$-0x1, %r10
               	movq	%r10, 0x38(%rsp)
               	shlxq	%rcx, %rax, %r10
               	movq	%r10, 0x30(%rsp)
               	shrxq	%rdi, %rax, %rdi
               	shrq	%rdi
               	shlxq	%rcx, %rsi, %rax
               	orq	%rdi, %rax
               	andq	0x38(%rsp), %rax
               	movq	0x30(%rsp), %r10
               	andq	%rbx, %r10
               	movq	%r10, 0x30(%rsp)
               	orq	0x30(%rsp), %rax
               	shrxq	%rcx, %rsi, %rcx
               	andq	0x38(%rsp), %rcx
               	movq	%rdx, %rsi
               	xorq	$-0x1, %rsi
               	andq	%rsi, %rax
               	andq	%rdx, %rcx
               	orq	%rcx, %rax
               	movq	%r9, %rcx
               	sarq	$0x3f, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rax
               	cmpl	$0x80, %r9d
               	setge	%cl
               	movzbq	%cl, %rcx
               	negq	%rcx
               	movq	%rcx, %rdx
               	xorq	$-0x1, %rdx
               	andq	%rcx, %r8
               	andq	%rdx, %rax
               	orq	%r8, %rax
               	xorq	$-0x1, 0x28(%rsp)
               	andq	0x28(%rsp), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x56, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movq	$0x0, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, <rip> # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rsi # <addr>
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
               	shrxq	%rax, %rcx, %rdx
               	movq	%rdx, %rax
               	shrq	$0x10, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	addq	%rax, %r8
               	shrxq	%rax, %rdx, %rdx
               	movq	%rdx, %rax
               	shrq	$0x8, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %r8
               	shrxq	%rax, %rdx, %rdx
               	movq	%rdx, %rax
               	shrq	$0x4, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x2, %rax
               	addq	%rax, %r8
               	shrxq	%rax, %rdx, %rdx
               	movq	%rdx, %rax
               	shrq	$0x2, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	addq	%rax, %r8
               	shrxq	%rax, %rdx, %rax
               	shrq	%rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	addq	%r8, %rax
               	imulq	%rdi, %rax
               	movl	$0x40, %edx
               	subq	%rax, %rdx
               	andq	$0x3f, %rdx
               	movq	$-0x1, %rdi
               	shrxq	%rdx, %rdi, %rdx
               	testl	%eax, %eax
               	setne	%dil
               	movzbq	%dil, %rdi
               	imulq	%rdi, %rdx
               	andq	%rsi, %rdx
               	testq	%rdx, %rdx
               	setne	%bl
               	movzbq	%bl, %rbx
               	movq	%rax, %rdx
               	andq	$0x3f, %rdx
               	movl	$0x3f, %edi
               	subq	%rdx, %rdi
               	movq	%rax, %r8
               	shrq	$0x6, %r8
               	negq	%r8
               	movq	%r8, %r10
               	xorq	$-0x1, %r10
               	movq	%r10, 0x38(%rsp)
               	shrxq	%rdx, %rcx, %r9
               	shlxq	%rdi, %rcx, %rdi
               	shlq	%rdi
               	shrxq	%rdx, %rsi, %rcx
               	orq	%rdi, %rcx
               	andq	0x38(%rsp), %rcx
               	andq	%r8, %r9
               	orq	%r9, %rcx
               	orq	%rbx, %rcx
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
               	movq	%rax, %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	<rip>, %xmm1 # <addr>
               	addsd	%xmm1, %xmm0
               	movq	%xmm0, %rax
               	movabsq	$0x4012000000000000, %r11 # imm = 0x4012000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x57, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rdx # <addr>
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	xorq	%rcx, %rdx
               	xorq	%rcx, %rax
               	cmpq	%rcx, %rdx
               	setb	%sil
               	movzbq	%sil, %rsi
               	subq	%rcx, %rdx
               	subq	%rcx, %rax
               	subq	%rsi, %rax
               	movabsq	$-0x8000000000000000, %rbx # imm = 0x8000000000000000
               	andq	%rcx, %rbx
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
               	shrxq	%rcx, %rax, %rsi
               	movq	%rsi, %rcx
               	shrq	$0x10, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %r8
               	shrxq	%rcx, %rsi, %rsi
               	movq	%rsi, %rcx
               	shrq	$0x8, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %r8
               	shrxq	%rcx, %rsi, %rsi
               	movq	%rsi, %rcx
               	shrq	$0x4, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %r8
               	shrxq	%rcx, %rsi, %rsi
               	movq	%rsi, %rcx
               	shrq	$0x2, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
               	addq	%rcx, %r8
               	shrxq	%rcx, %rsi, %rcx
               	shrq	%rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	addq	%r8, %rcx
               	imulq	%rdi, %rcx
               	movl	$0x40, %esi
               	subq	%rcx, %rsi
               	andq	$0x3f, %rsi
               	movq	$-0x1, %rdi
               	shrxq	%rsi, %rdi, %rsi
               	testl	%ecx, %ecx
               	setne	%dil
               	movzbq	%dil, %rdi
               	imulq	%rdi, %rsi
               	andq	%rdx, %rsi
               	testq	%rsi, %rsi
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%rcx, %rsi
               	andq	$0x3f, %rsi
               	movl	$0x3f, %edi
               	subq	%rsi, %rdi
               	movq	%rcx, %r8
               	shrq	$0x6, %r8
               	negq	%r8
               	movq	%r8, %r10
               	xorq	$-0x1, %r10
               	movq	%r10, 0x30(%rsp)
               	shrxq	%rsi, %rax, %r9
               	shlxq	%rdi, %rax, %rdi
               	shlq	%rdi
               	shrxq	%rsi, %rdx, %rax
               	orq	%rdi, %rax
               	andq	0x30(%rsp), %rax
               	andq	%r8, %r9
               	orq	%r9, %rax
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
               	leaq	0x3ff(%rcx), %rax
               	shlq	$0x34, %rax
               	orq	%rbx, %rax
               	movq	%rax, %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	<rip>, %xmm1 # <addr>
               	mulsd	%xmm1, %xmm0
               	movq	%xmm0, %rax
               	movabsq	$0x4012000000000000, %r11 # imm = 0x4012000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x58, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
