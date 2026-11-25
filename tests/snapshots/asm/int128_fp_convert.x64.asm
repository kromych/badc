
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
               	pushq	%rbx
               	movq	%rdx, %rbx
               	movq	%r9, 0x18(%rsp)
               	movq	%r8, 0x20(%rsp)
               	movq	%rcx, 0x28(%rsp)
               	movq	%rdi, <rip> # <addr>
               	movq	%rsi, <rip> # <addr>
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %r10 # <addr>
               	testq	%rsi, %rsi
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rsi, %rax
               	shrq	$0x20, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x5, %rax
               	leaq	0x1(%rax), %r11
               	shrxq	%rax, %rsi, %rdi
               	movq	%rdi, %rax
               	shrq	$0x10, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	addq	%rax, %r11
               	shrxq	%rax, %rdi, %rdi
               	movq	%rdi, %rax
               	shrq	$0x8, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %r11
               	shrxq	%rax, %rdi, %rdi
               	movq	%rdi, %rax
               	shrq	$0x4, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x2, %rax
               	addq	%rax, %r11
               	shrxq	%rax, %rdi, %rdi
               	movq	%rdi, %rax
               	shrq	$0x2, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	addq	%rax, %r11
               	shrxq	%rax, %rdi, %rax
               	shrq	%rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	addq	%r11, %rax
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
               	andq	%r10, %rdi
               	testq	%rdi, %rdi
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%rax, %rdi
               	andq	$0x3f, %rdi
               	movl	$0x3f, %r11d
               	subq	%rdi, %r11
               	movq	%rax, %rdx
               	shrq	$0x6, %rdx
               	movq	%rdx, %rcx
               	negq	%rcx
               	movq	%rcx, %r9
               	xorq	$-0x1, %r9
               	shrxq	%rdi, %rsi, %rdx
               	shlxq	%r11, %rsi, %r11
               	shlq	%r11
               	shrxq	%rdi, %r10, %rsi
               	orq	%r11, %rsi
               	andq	%r9, %rsi
               	andq	%rcx, %rdx
               	orq	%rdx, %rsi
               	orq	%r8, %rsi
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
               	movl	0x50(%rsp), %eax
               	popq	%rbx
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
               	leaq	0x1(%rax), %r10
               	shrxq	%rax, %rdx, %rsi
               	movq	%rsi, %rax
               	shrq	$0x10, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	addq	%rax, %r10
               	shrxq	%rax, %rsi, %rsi
               	movq	%rsi, %rax
               	shrq	$0x8, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %r10
               	shrxq	%rax, %rsi, %rsi
               	movq	%rsi, %rax
               	shrq	$0x4, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x2, %rax
               	addq	%rax, %r10
               	shrxq	%rax, %rsi, %rsi
               	movq	%rsi, %rax
               	shrq	$0x2, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	addq	%rax, %r10
               	shrxq	%rax, %rsi, %rax
               	shrq	%rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	addq	%r10, %rax
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
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%rax, %rsi
               	andq	$0x3f, %rsi
               	movl	$0x3f, %r10d
               	subq	%rsi, %r10
               	movq	%rax, %rcx
               	shrq	$0x6, %rcx
               	movq	%rcx, %r11
               	negq	%r11
               	movq	%r11, %r9
               	xorq	$-0x1, %r9
               	shrxq	%rsi, %rdx, %rcx
               	shlxq	%r10, %rdx, %r10
               	shlq	%r10
               	shrxq	%rsi, %rdi, %rdx
               	orq	%r10, %rdx
               	andq	%r9, %rdx
               	andq	%r11, %rcx
               	orq	%rcx, %rdx
               	orq	%r8, %rdx
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
               	movss	%xmm0, 0x38(%rsp)
               	movl	0x38(%rsp), %eax
               	cmpl	0x28(%rsp), %eax
               	je	<addr>
               	movl	0x50(%rsp), %eax
               	incq	%rax
               	popq	%rbx
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
               	movabsq	$-0x8000000000000000, %r8 # imm = 0x8000000000000000
               	andq	%rcx, %r8
               	testq	%rax, %rax
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x5, %rcx
               	leaq	0x1(%rcx), %r10
               	shrxq	%rcx, %rax, %rsi
               	movq	%rsi, %rcx
               	shrq	$0x10, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %r10
               	shrxq	%rcx, %rsi, %rsi
               	movq	%rsi, %rcx
               	shrq	$0x8, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %r10
               	shrxq	%rcx, %rsi, %rsi
               	movq	%rsi, %rcx
               	shrq	$0x4, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %r10
               	shrxq	%rcx, %rsi, %rsi
               	movq	%rsi, %rcx
               	shrq	$0x2, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
               	addq	%rcx, %r10
               	shrxq	%rcx, %rsi, %rcx
               	shrq	%rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	addq	%r10, %rcx
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
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%rcx, %rsi
               	andq	$0x3f, %rsi
               	movl	$0x3f, %edi
               	subq	%rsi, %rdi
               	movq	%rcx, %r10
               	shrq	$0x6, %r10
               	negq	%r10
               	movq	%r10, %rbx
               	xorq	$-0x1, %rbx
               	shrxq	%rsi, %rax, %r11
               	shlxq	%rdi, %rax, %rdi
               	shlq	%rdi
               	shrxq	%rsi, %rdx, %rax
               	orq	%rdi, %rax
               	andq	%rbx, %rax
               	andq	%r10, %r11
               	orq	%r11, %rax
               	orq	%r9, %rax
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
               	orq	%r8, %rax
               	movq	%rax, %xmm1
               	mulsd	%xmm1, %xmm0
               	movq	%xmm0, %rax
               	cmpq	0x20(%rsp), %rax
               	je	<addr>
               	movl	0x50(%rsp), %eax
               	addq	$0x2, %rax
               	popq	%rbx
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
               	movabsq	$-0x8000000000000000, %r9 # imm = 0x8000000000000000
               	andq	%rcx, %r9
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
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%rcx, %rsi
               	andq	$0x3f, %rsi
               	movl	$0x3f, %edi
               	subq	%rsi, %rdi
               	movq	%rcx, %r8
               	shrq	$0x6, %r8
               	negq	%r8
               	movq	%r8, %rbx
               	xorq	$-0x1, %rbx
               	shrxq	%rsi, %rax, %r10
               	shlxq	%rdi, %rax, %rdi
               	shlq	%rdi
               	shrxq	%rsi, %rdx, %rax
               	orq	%rdi, %rax
               	andq	%rbx, %rax
               	andq	%r8, %r10
               	orq	%r10, %rax
               	orq	%r11, %rax
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
               	orq	%r9, %rax
               	movq	%rax, %xmm1
               	mulsd	%xmm1, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movss	%xmm0, 0x38(%rsp)
               	movl	0x38(%rsp), %eax
               	cmpl	0x18(%rsp), %eax
               	je	<addr>
               	movl	0x50(%rsp), %eax
               	addq	$0x3, %rax
               	popq	%rbx
               	addq	$0x40, %rsp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x40, %rsp
               	retq

<chk_from_fp>:
               	subq	$0x18, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r14
               	movq	%rdx, 0x20(%rsp)
               	movq	%rsi, 0x28(%rsp)
               	movsd	%xmm0, <rip> # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movq	%xmm0, %rcx
               	movq	%rcx, %r12
               	sarq	$0x3f, %r12
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rcx, %rdx
               	shrq	$0x34, %rdx
               	leaq	-0x3ff(%rdx), %r13
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$0x10000000000000, %rsi # imm = 0x10000000000000
               	orq	%rcx, %rsi
               	leaq	-0x433(%rdx), %rcx
               	movq	%rcx, %r9
               	sarq	$0x3f, %r9
               	xorq	%r9, %rcx
               	subq	%r9, %rcx
               	xorl	%edi, %edi
               	movq	%rcx, %rdx
               	andq	$0x7f, %rdx
               	andq	$0x3f, %rcx
               	movl	$0x3f, %ebx
               	subq	%rcx, %rbx
               	shrq	$0x6, %rdx
               	movq	%rdx, %r11
               	negq	%r11
               	movq	%r11, %r10
               	xorq	$-0x1, %r10
               	shlxq	%rcx, %rsi, %rax
               	shrxq	%rbx, %rsi, %r8
               	shrq	%r8
               	shlxq	%rcx, %rdi, %rdx
               	orq	%r8, %rdx
               	movq	%rax, %r8
               	andq	%r10, %r8
               	andq	%r10, %rdx
               	andq	%r11, %rax
               	orq	%rax, %rdx
               	shrxq	%rcx, %rdi, %rax
               	shlxq	%rbx, %rdi, %rdi
               	shlq	%rdi
               	shrxq	%rcx, %rsi, %rcx
               	orq	%rdi, %rcx
               	andq	%r10, %rcx
               	andq	%rax, %r11
               	orq	%r11, %rcx
               	andq	%r10, %rax
               	movq	%r9, %r10
               	xorq	$-0x1, %r10
               	andq	%r10, %r8
               	andq	%r9, %rcx
               	orq	%rcx, %r8
               	andq	%r10, %rdx
               	andq	%r9, %rax
               	orq	%rax, %rdx
               	movq	%r13, %rcx
               	sarq	$0x3f, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %r8
               	andq	%rcx, %rdx
               	cmpl	$0x80, %r13d
               	setge	%cl
               	movzbq	%cl, %rcx
               	negq	%rcx
               	movq	%rcx, %r9
               	xorq	$-0x1, %r9
               	andq	%r9, %r8
               	orq	%rcx, %r8
               	andq	%r9, %rdx
               	orq	%rcx, %rdx
               	xorq	$-0x1, %r12
               	andq	%r12, %r8
               	andq	%r12, %rdx
               	cmpq	%r14, %rdx
               	jne	<addr>
               	cmpq	0x28(%rsp), %r8
               	je	<addr>
               	movq	0x20(%rsp), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	addq	$0x18, %rsp
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	movq	%xmm0, %rcx
               	movq	%rcx, %r9
               	sarq	$0x3f, %r9
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rcx, %rdx
               	shrq	$0x34, %rdx
               	leaq	-0x3ff(%rdx), %r13
               	movabsq	$0xfffffffffffff, %rax  # imm = 0xFFFFFFFFFFFFF
               	andq	%rcx, %rax
               	movabsq	$0x10000000000000, %rdi # imm = 0x10000000000000
               	orq	%rax, %rdi
               	subq	$0x433, %rdx            # imm = 0x433
               	movq	%rdx, %r10
               	sarq	$0x3f, %r10
               	xorq	%r10, %rdx
               	subq	%r10, %rdx
               	xorl	%ebx, %ebx
               	movq	%rdx, %rax
               	andq	$0x7f, %rax
               	andq	$0x3f, %rdx
               	movl	$0x3f, %r12d
               	subq	%rdx, %r12
               	shrq	$0x6, %rax
               	negq	%rax
               	movq	%rax, %r11
               	xorq	$-0x1, %r11
               	shlxq	%rdx, %rdi, %rsi
               	shrxq	%r12, %rdi, %r8
               	shrq	%r8
               	shlxq	%rdx, %rbx, %rcx
               	orq	%r8, %rcx
               	movq	%rsi, %r8
               	andq	%r11, %r8
               	andq	%r11, %rcx
               	andq	%rax, %rsi
               	orq	%rsi, %rcx
               	shrxq	%rdx, %rbx, %rsi
               	shlxq	%r12, %rbx, %rbx
               	shlq	%rbx
               	shrxq	%rdx, %rdi, %rdx
               	orq	%rbx, %rdx
               	andq	%r11, %rdx
               	andq	%rsi, %rax
               	orq	%rax, %rdx
               	andq	%r11, %rsi
               	movq	%r10, %rax
               	xorq	$-0x1, %rax
               	andq	%rax, %r8
               	andq	%r10, %rdx
               	orq	%rdx, %r8
               	andq	%rax, %rcx
               	andq	%r10, %rsi
               	orq	%rsi, %rcx
               	movq	%r13, %rdx
               	sarq	$0x3f, %rdx
               	xorq	$-0x1, %rdx
               	andq	%rdx, %r8
               	andq	%rdx, %rcx
               	cmpl	$0x80, %r13d
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
               	cmpq	%r14, %rcx
               	jne	<addr>
               	cmpq	0x28(%rsp), %r8
               	je	<addr>
               	movq	0x20(%rsp), %rax
               	incq	%rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	addq	$0x18, %rsp
               	retq

<chk_from_fp_neg>:
               	subq	$0x30, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, 0x38(%rsp)
               	movq	%rdx, 0x28(%rsp)
               	movq	%rsi, 0x30(%rsp)
               	movsd	%xmm0, <rip> # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movq	%xmm0, %rcx
               	movq	%rcx, %r9
               	sarq	$0x3f, %r9
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rcx, %rdx
               	shrq	$0x34, %rdx
               	leaq	-0x3ff(%rdx), %r13
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$0x10000000000000, %rdi # imm = 0x10000000000000
               	orq	%rcx, %rdi
               	subq	$0x433, %rdx            # imm = 0x433
               	movq	%rdx, %r10
               	sarq	$0x3f, %r10
               	xorq	%r10, %rdx
               	subq	%r10, %rdx
               	xorl	%ebx, %ebx
               	movq	%rdx, %rcx
               	andq	$0x7f, %rcx
               	andq	$0x3f, %rdx
               	movl	$0x3f, %r12d
               	subq	%rdx, %r12
               	shrq	$0x6, %rcx
               	movq	%rcx, %rax
               	negq	%rax
               	movq	%rax, %r11
               	xorq	$-0x1, %r11
               	shlxq	%rdx, %rdi, %rsi
               	shrxq	%r12, %rdi, %r8
               	shrq	%r8
               	shlxq	%rdx, %rbx, %rcx
               	orq	%r8, %rcx
               	movq	%rsi, %r8
               	andq	%r11, %r8
               	andq	%r11, %rcx
               	andq	%rax, %rsi
               	orq	%rsi, %rcx
               	shrxq	%rdx, %rbx, %rsi
               	shlxq	%r12, %rbx, %rbx
               	shlq	%rbx
               	shrxq	%rdx, %rdi, %rdx
               	orq	%rbx, %rdx
               	andq	%r11, %rdx
               	andq	%rsi, %rax
               	orq	%rax, %rdx
               	andq	%r11, %rsi
               	movq	%r10, %r11
               	xorq	$-0x1, %r11
               	andq	%r11, %r8
               	andq	%r10, %rdx
               	orq	%rdx, %r8
               	andq	%r11, %rcx
               	andq	%r10, %rsi
               	orq	%rsi, %rcx
               	movq	%r13, %rdx
               	sarq	$0x3f, %rdx
               	xorq	$-0x1, %rdx
               	andq	%rdx, %r8
               	andq	%rdx, %rcx
               	cmpl	$0x80, %r13d
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
               	movq	%r9, %r10
               	xorq	$-0x1, %r10
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	xorq	%r9, %r11
               	movq	%rdx, %r9
               	xorq	$-0x1, %r9
               	andq	%r9, %r8
               	andq	%rdx, %r10
               	orq	%r10, %r8
               	andq	%r9, %rcx
               	andq	%rdx, %r11
               	orq	%r11, %rcx
               	cmpq	0x38(%rsp), %rcx
               	jne	<addr>
               	cmpq	0x30(%rsp), %r8
               	je	<addr>
               	movq	0x28(%rsp), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x30, %rsp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
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
               	movq	%r10, 0x38(%rsp)
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
               	movq	%rcx, %r10
               	negq	%r10
               	movq	%r10, %r11
               	xorq	$-0x1, %r11
               	shlxq	%rax, %rdi, %rcx
               	andq	%r11, %rcx
               	shrxq	%rax, %r8, %rbx
               	shlxq	%r9, %r8, %r8
               	shlq	%r8
               	shrxq	%rax, %rdi, %rax
               	orq	%r8, %rax
               	andq	%r11, %rax
               	andq	%r10, %rbx
               	orq	%rbx, %rax
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
               	xorq	$-0x1, 0x38(%rsp)
               	andq	0x38(%rsp), %rcx
               	cmpq	$0x2, %rcx
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	cvtss2sd	%xmm0, %xmm0
               	movq	%xmm0, %rax
               	movq	%rax, %rbx
               	sarq	$0x3f, %rbx
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
               	movq	%r9, %r10
               	xorq	$-0x1, %r10
               	shlxq	%rcx, %rax, %r11
               	shrxq	%r8, %rax, %r8
               	shrq	%r8
               	shlxq	%rcx, %rdi, %rax
               	orq	%r8, %rax
               	andq	%r10, %rax
               	andq	%r9, %r11
               	orq	%r11, %rax
               	shrxq	%rcx, %rdi, %rcx
               	andq	%r10, %rcx
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
               	xorq	$-0x1, %rbx
               	andq	%rbx, %rax
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
               	movl	$0x3f, %r10d
               	subq	%rax, %r10
               	shrq	$0x6, %rcx
               	movq	%rcx, %r11
               	negq	%r11
               	movq	%r11, %rbx
               	xorq	$-0x1, %rbx
               	shlxq	%rax, %r8, %rcx
               	andq	%rbx, %rcx
               	movq	%r10, 0x28(%rsp)
               	shrxq	%rax, %r9, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x28(%rsp), %r10
               	shlxq	%r10, %r9, %r9
               	shlq	%r9
               	shrxq	%rax, %r8, %rax
               	orq	%r9, %rax
               	andq	%rbx, %rax
               	movq	0x38(%rsp), %r10
               	andq	%r11, %r10
               	movq	%r10, 0x38(%rsp)
               	orq	0x38(%rsp), %rax
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
               	movq	%r10, 0x30(%rsp)
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$0x10000000000000, %r11 # imm = 0x10000000000000
               	orq	%rax, %r11
               	subq	$0x433, %rcx            # imm = 0x433
               	movq	%rcx, %rsi
               	sarq	$0x3f, %rsi
               	xorq	%rsi, %rcx
               	subq	%rsi, %rcx
               	xorl	%ebx, %ebx
               	movq	%rcx, %rdi
               	andq	$0x7f, %rdi
               	andq	$0x3f, %rcx
               	movl	$0x3f, %eax
               	subq	%rcx, %rax
               	shrq	$0x6, %rdi
               	movq	%rdi, %r9
               	negq	%r9
               	movq	%r9, %r8
               	xorq	$-0x1, %r8
               	shlxq	%rcx, %r11, %r10
               	movq	%rax, 0x38(%rsp)
               	movq	%r10, 0x28(%rsp)
               	movq	0x38(%rsp), %r10
               	shrxq	%r10, %r11, %rdi
               	shrq	%rdi
               	shlxq	%rcx, %rbx, %rax
               	orq	%rdi, %rax
               	movq	0x28(%rsp), %r10
               	movq	%r10, %rdi
               	andq	%r8, %rdi
               	andq	%r8, %rax
               	andq	%r9, %r10
               	orq	%r10, %rax
               	shrxq	%rcx, %rbx, %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x38(%rsp), %r10
               	shlxq	%r10, %rbx, %rbx
               	shlq	%rbx
               	shrxq	%rcx, %r11, %rcx
               	movq	0x28(%rsp), %r10
               	orq	%rbx, %rcx
               	andq	%r8, %rcx
               	andq	%r10, %r9
               	orq	%r9, %rcx
               	andq	%r8, %r10
               	movq	%rsi, %r8
               	xorq	$-0x1, %r8
               	andq	%r8, %rdi
               	andq	%rsi, %rcx
               	orq	%rcx, %rdi
               	andq	%r8, %rax
               	andq	%rsi, %r10
               	orq	%r10, %rax
               	movq	0x30(%rsp), %rsi
               	movq	%rsi, %rcx
               	sarq	$0x3f, %rcx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rdi
               	andq	%rcx, %rax
               	cmpl	$0x80, %esi
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
               	movq	%r10, 0x38(%rsp)
               	movq	%rax, %rdx
               	andq	$0x3f, %rdx
               	movl	$0x3f, %edi
               	movq	%rdi, %r11
               	subq	%rdx, %r11
               	movq	%rax, %r10
               	shrq	$0x6, %r10
               	negq	%r10
               	movq	%r11, 0x28(%rsp)
               	movq	%r10, %r11
               	xorq	$-0x1, %r11
               	movq	%r11, 0x30(%rsp)
               	shrxq	%rdx, %rcx, %rbx
               	movq	0x28(%rsp), %r11
               	shlxq	%r11, %rcx, %r11
               	shlq	%r11
               	shrxq	%rdx, %r9, %rcx
               	orq	%r11, %rcx
               	andq	0x30(%rsp), %rcx
               	andq	%r10, %rbx
               	orq	%rbx, %rcx
               	orq	0x38(%rsp), %rcx
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
               	movq	%r10, 0x30(%rsp)
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%rax, %rcx
               	shrq	$0x34, %rcx
               	leaq	-0x3ff(%rcx), %r9
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$0x10000000000000, %r10 # imm = 0x10000000000000
               	orq	%rax, %r10
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
               	movq	%rcx, %r11
               	negq	%r11
               	movq	%r11, %rbx
               	xorq	$-0x1, %rbx
               	shlxq	%rax, %r10, %rcx
               	andq	%rbx, %rcx
               	movq	%r10, 0x28(%rsp)
               	shrxq	%rax, %rsi, %r10
               	movq	%r10, 0x38(%rsp)
               	shlxq	%rdi, %rsi, %rsi
               	shlq	%rsi
               	movq	0x28(%rsp), %r10
               	shrxq	%rax, %r10, %rax
               	orq	%rsi, %rax
               	andq	%rbx, %rax
               	movq	0x38(%rsp), %r10
               	andq	%r11, %r10
               	movq	%r10, 0x38(%rsp)
               	orq	0x38(%rsp), %rax
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
               	xorq	$-0x1, 0x30(%rsp)
               	andq	0x30(%rsp), %rcx
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
               	movq	%r10, 0x38(%rsp)
               	movq	%rax, %rdx
               	andq	$0x3f, %rdx
               	movl	$0x3f, %edi
               	movq	%rdi, %r11
               	subq	%rdx, %r11
               	movq	%rax, %r10
               	shrq	$0x6, %r10
               	negq	%r10
               	movq	%r11, 0x28(%rsp)
               	movq	%r10, %r11
               	xorq	$-0x1, %r11
               	movq	%r11, 0x30(%rsp)
               	shrxq	%rdx, %rcx, %rbx
               	movq	0x28(%rsp), %r11
               	shlxq	%r11, %rcx, %r11
               	shlq	%r11
               	shrxq	%rdx, %r9, %rcx
               	orq	%r11, %rcx
               	andq	0x30(%rsp), %rcx
               	andq	%r10, %rbx
               	orq	%rbx, %rcx
               	orq	0x38(%rsp), %rcx
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
               	movq	%r10, 0x38(%rsp)
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
               	movq	%rcx, %r10
               	andq	$0x7f, %r10
               	andq	$0x3f, %rcx
               	subq	%rcx, %rdi
               	shrq	$0x6, %r10
               	negq	%r10
               	movq	%r10, %r11
               	xorq	$-0x1, %r11
               	shlxq	%rcx, %rax, %rbx
               	shrxq	%rdi, %rax, %rdi
               	shrq	%rdi
               	shlxq	%rcx, %rsi, %rax
               	orq	%rdi, %rax
               	andq	%r11, %rax
               	andq	%r10, %rbx
               	orq	%rbx, %rax
               	shrxq	%rcx, %rsi, %rcx
               	andq	%r11, %rcx
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
               	xorq	$-0x1, 0x38(%rsp)
               	andq	0x38(%rsp), %rax
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
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%rax, %rdx
               	andq	$0x3f, %rdx
               	movl	$0x3f, %edi
               	subq	%rdx, %rdi
               	movq	%rax, %r8
               	shrq	$0x6, %r8
               	negq	%r8
               	movq	%r8, %r11
               	xorq	$-0x1, %r11
               	shrxq	%rdx, %rcx, %r9
               	shlxq	%rdi, %rcx, %rdi
               	shlq	%rdi
               	shrxq	%rdx, %rsi, %rcx
               	orq	%rdi, %rcx
               	andq	%r11, %rcx
               	andq	%r8, %r9
               	orq	%r9, %rcx
               	orq	%r10, %rcx
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
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	andq	%rcx, %r10
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
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%rcx, %rsi
               	andq	$0x3f, %rsi
               	movl	$0x3f, %edi
               	subq	%rsi, %rdi
               	movq	%rcx, %r8
               	shrq	$0x6, %r8
               	negq	%r8
               	movq	%r8, %rbx
               	xorq	$-0x1, %rbx
               	shrxq	%rsi, %rax, %r9
               	shlxq	%rdi, %rax, %rdi
               	shlq	%rdi
               	shrxq	%rsi, %rdx, %rax
               	orq	%rdi, %rax
               	andq	%rbx, %rax
               	andq	%r8, %r9
               	orq	%r9, %rax
               	orq	%r11, %rax
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r11
               	testq	%r11, %r11
               	js	<addr>
               	cvtsi2sd	%r11, %xmm0
               	jmp	<addr>
               	movq	%r11, %r9
               	shrq	%r9
               	andq	$0x1, %r11
               	orq	%r11, %r9
               	cvtsi2sd	%r9, %xmm0
               	addsd	%xmm0, %xmm0
               	leaq	0x3ff(%rcx), %rax
               	shlq	$0x34, %rax
               	orq	%r10, %rax
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
